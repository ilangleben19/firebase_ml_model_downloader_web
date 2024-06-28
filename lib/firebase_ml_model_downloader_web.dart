import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_model_downloader_platform_interface/firebase_ml_model_downloader_platform_interface.dart';

class FirebaseMlModelDownloaderWeb extends FirebaseModelDownloaderPlatform {
  static void registerWith(Registrar registrar) {
    // Copied from https://github.com/firebase/flutterfire/blob/b1584aa7f3f97bc263b1e8966fd33495613e20b7/packages/firebase_ml_model_downloader/firebase_ml_model_downloader/lib/src/firebase_ml_model_downloader.dart#L32
    FirebaseApp app = Firebase.app();

    FirebaseModelDownloaderPlatform.instance =
        FirebaseMlModelDownloaderWeb(app: app);

    //print("registerWith() is not really implemented...");
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
    print("Web plugin working from getModel()! -Ian");
    //throw UnimplementedError('getModel() is not implemented');
    return Future.value(null);
  }

  /// Lists all models downloaded to device.
  @override
  Future<List<FirebaseCustomModel>> listDownloadedModels() {
    print("Web plugin working from listDownloadedModels()! -Ian");
    //throw UnimplementedError('listDownloadedModels() is not implemented');
    return Future.value(null);
  }

  /// Deletes a locally downloaded model by name.
  @override
  Future<void> deleteDownloadedModel(String modelName) {
    print("Web plugin working from deleteDownloadedModel()! -Ian");
    //throw UnimplementedError('deleteDownloadedModel() is not implemented');
    return Future.value(null);
  }
}
