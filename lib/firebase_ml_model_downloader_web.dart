import 'dart:io';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_model_downloader_platform_interface/firebase_ml_model_downloader_platform_interface.dart';

class FirebaseMlModelDownloaderWeb extends FirebaseModelDownloaderPlatform {
  static void registerWith(Registrar registrar) {
    FirebaseModelDownloaderPlatform.instance =
        FirebaseMlModelDownloaderWeb.instance;
  }

  static FirebaseMlModelDownloaderWeb get instance {
    return FirebaseMlModelDownloaderWeb._();
  }

  FirebaseMlModelDownloaderWeb._() : super(appInstance: null);

  FirebaseMlModelDownloaderWeb({required FirebaseApp app})
      : super(appInstance: app);

  @override
  FirebaseModelDownloaderPlatform delegateFor({required FirebaseApp app}) {
    return FirebaseMlModelDownloaderWeb(app: app);
  }

  /// Gets the downloaded model file based on download type and conditions.
  @override
  Future<FirebaseCustomModel> getModel(
    String modelName,
    FirebaseModelDownloadType downloadType,
    FirebaseModelDownloadConditions conditions,
  ) {
    return Future.value(FirebaseCustomModel(
        file: File.fromUri(Uri(path: './Test file name.text')),
        size: 613,
        name: 'Test file name.test',
        hash: ''));
  }

  /// Lists all models downloaded to device.
  @override
  Future<List<FirebaseCustomModel>> listDownloadedModels() {
    print("Web plugin working from listDownloadedModels()! -Ian");
    throw UnimplementedError('listDownloadedModels() is not implemented');
  }

  /// Deletes a locally downloaded model by name.
  @override
  Future<void> deleteDownloadedModel(String modelName) {
    print("Web plugin working from deleteDownloadedModel()! -Ian");
    throw UnimplementedError('deleteDownloadedModel() is not implemented');
  }
}
