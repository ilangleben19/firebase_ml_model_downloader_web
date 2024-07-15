import 'package:firebase_ml_model_downloader_web/model_database.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_model_downloader_platform_interface/firebase_ml_model_downloader_platform_interface.dart';

class FirebaseMlModelDownloaderWeb extends FirebaseModelDownloaderPlatform {
  final ModelDatabase? modelDatabase;

  static void registerWith(Registrar registrar) {
    FirebaseModelDownloaderPlatform.instance =
        FirebaseMlModelDownloaderWeb.instance;
  }

  static FirebaseMlModelDownloaderWeb get instance {
    return FirebaseMlModelDownloaderWeb._();
  }

  FirebaseMlModelDownloaderWeb._()
      : modelDatabase = null,
        super(appInstance: null);

  FirebaseMlModelDownloaderWeb({required FirebaseApp app})
      : modelDatabase = ModelDatabase(app),
        super(appInstance: app);

  @override
  FirebaseModelDownloaderPlatform delegateFor({required FirebaseApp app}) {
    return FirebaseMlModelDownloaderWeb(app: app);
  }

  Future<FirebaseCustomModel> getLatestModel(
      String modelName, FirebaseModelDownloadConditions conditions) async {
    throw UnimplementedError();
  }

  Future<FirebaseCustomModel> getLocalModel(String modelName) async {
    throw UnimplementedError();
  }

  /// Gets the downloaded model file based on download type and conditions.
  @override
  Future<FirebaseCustomModel> getModel(
    String modelName,
    FirebaseModelDownloadType downloadType,
    FirebaseModelDownloadConditions conditions,
  ) {
    print("Web plugin working from getModel()! -Ian");

    switch (downloadType) {
      case FirebaseModelDownloadType.localModel:
        return getLocalModel(modelName);
      case FirebaseModelDownloadType.latestModel:
        return getLatestModel(modelName, conditions);
      case FirebaseModelDownloadType.localModelUpdateInBackground:
        getLatestModel(modelName, conditions);
        return getLocalModel(modelName);
    }
  }

  /// Lists all models downloaded to device.
  @override
  Future<List<FirebaseCustomModel>> listDownloadedModels() async {
    print("Web plugin working from listDownloadedModels()! -Ian 12345");
    return modelDatabase!.listDownloadedModels();
  }

  /// Deletes a locally downloaded model by name.
  @override
  Future<void> deleteDownloadedModel(String modelName) {
    print("Web plugin working from deleteDownloadedModel()! -Ian");
    throw UnimplementedError('deleteDownloadedModel() is not implemented');
  }
}
