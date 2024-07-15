import 'dart:js_interop';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_model_downloader_web/custom_file.dart';
import 'package:firebase_ml_model_downloader_web/custom_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:web/web.dart';

class ModelDatabase {
  final FirebaseApp firebaseApp;
  final String keyPrefix;
  final String listKey;
  final String modelDirectoryPath;
  final String modelPrefix;
  final String modelFilePathSuffix = '-file-path';
  final String modelSizeSuffix = '-size';
  final String modelHashSuffix = '-hash';

  ModelDatabase._named(
      {required this.firebaseApp,
      required this.keyPrefix,
      required this.modelDirectoryPath,
      required this.listKey,
      required this.modelPrefix});

  factory ModelDatabase(FirebaseApp app) {
    final keyPrefix = '${app.name}-firebase_ml_model_downloader_web-';

    return ModelDatabase._named(
        firebaseApp: app,
        keyPrefix: keyPrefix,
        modelDirectoryPath: '$keyPrefix-models',
        listKey: '${keyPrefix}local_model_list',
        modelPrefix: '${keyPrefix}local_model-');
  }

  Future<List<CustomModel>> listDownloadedModels() async {
    print("made it into model_datbase list fxn");
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    List<CustomModel> customModels = List<CustomModel>.empty();

    List<String>? modelNames = prefs.getStringList(listKey);

    final modelDirectoryHandle = await window.navigator.storage
        .getDirectory()
        .toDart
        .then((rootHandle) => rootHandle
            .getDirectoryHandle(
                modelDirectoryPath, FileSystemGetDirectoryOptions(create: true))
            .toDart);
    print('got dir ok');
    if (modelNames == null) {
      await prefs.setStringList(listKey, []);
    } else {
      for (final modelName in modelNames) {
        final modelKey = '$modelPrefix$modelName';

        final modelFilePath = prefs.getString('$modelKey$modelFilePathSuffix');
        final modelSize = prefs.getInt('$modelKey$modelSizeSuffix');
        final modelHash = prefs.getString('$modelKey$modelHashSuffix');

        if (modelFilePath == null || modelSize == null || modelHash == null) {
          if (kDebugMode) {
            print(
                '[firebase_ml_model_downloader_web] Something is null in listDownloadedModels(): modelFilePath=$modelFilePath  modelSize=$modelSize modelHash=$modelHash');
          }
          continue;
        }

        final modelFileHandle =
            await modelDirectoryHandle.getFileHandle(modelFilePath).toDart;

        customModels.add(CustomModel(
          name: modelName,
          hash: modelHash,
          size: modelSize,
          file: CustomFile.fromOPFSHandle(modelFileHandle),
        ));
      }
    }

    return customModels;
  }
}
