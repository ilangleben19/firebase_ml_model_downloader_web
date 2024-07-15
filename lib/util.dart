import 'dart:js_interop';

import 'package:web/web.dart' as web;

Future<web.FileSystemFileHandle> getOFPSFileByPath(String path,
    [web.FileSystemGetFileOptions? options]) async {
  return getOPFSFileByUri(Uri.dataFromString(path), options);
}

Future<web.FileSystemFileHandle> getOPFSFileByUri(Uri uri,
    [web.FileSystemGetFileOptions? options]) async {
  final directories = uri.pathSegments.sublist(0, uri.pathSegments.length - 1);
  final fileName = uri.pathSegments.last;

  web.FileSystemDirectoryHandle directoryHandle =
      await web.window.navigator.storage.getDirectory().toDart;
  for (final directory in directories) {
    directoryHandle =
        await directoryHandle.getDirectoryHandle(directory).toDart;
  }

  return (options != null
          ? (directoryHandle.getFileHandle(fileName, options))
          : (directoryHandle.getFileHandle(fileName)))
      .toDart;
}
