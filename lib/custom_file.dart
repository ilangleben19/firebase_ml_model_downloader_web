import 'dart:js_interop';
import 'dart:math';

import 'package:web/web.dart' as web;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import './util.dart';

class CustomFile implements File {
  final web.FileSystemFileHandle _handle;

  CustomFile.fromOPFSHandle(web.FileSystemFileHandle handle) : _handle = handle;

  static Future<CustomFile> fromUri(Uri uri) async {
    final root = await web.window.navigator.storage.getDirectory().toDart;

    web.FileSystemDirectoryHandle directoryHandle = root;
    final directories =
        uri.pathSegments.sublist(0, min(uri.pathSegments.length - 2, 0));
    for (String directory in directories) {
      directoryHandle =
          await directoryHandle.getDirectoryHandle(directory).toDart;
    }

    final file =
        await directoryHandle.getFileHandle(uri.pathSegments.last).toDart;
    return CustomFile.fromOPFSHandle(file);
  }

  @override
  File get absolute => this;

  @override
  Future<File> copy(String newPath) async {
    // May be an issue that we're not checking if file already exists - oh well lol

    CustomFile newFile = CustomFile.fromOPFSHandle(await getOFPSFileByPath(
        newPath, web.FileSystemGetFileOptions(create: true)));

    final content = await readAsString();

    await newFile.writeAsString(content);

    return newFile;
  }

  @override
  File copySync(String newPath) {
    throw UnimplementedError();
  }

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) {
    throw UnimplementedError();
  }

  @override
  void createSync({bool recursive = false, bool exclusive = false}) {
    throw UnimplementedError();
  }

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) async {
    throw UnimplementedError();
  }

  @override
  void deleteSync({bool recursive = false}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> exists() async {
    bool ret = true;
    try {
      await _handle.getFile().toDart.catchError((_) {
        // May be redundant
        ret = false;
        throw _;
      });
    } catch (_) {
      ret = false;
    }
    return Future.value(ret);
  }

  @override
  bool existsSync() {
    throw UnimplementedError();
  }

  @override
  bool get isAbsolute => throw UnimplementedError();

  @override
  Future<DateTime> lastAccessed() {
    throw UnimplementedError();
  }

  @override
  DateTime lastAccessedSync() {
    throw UnimplementedError();
  }

  @override
  Future<DateTime> lastModified() {
    throw UnimplementedError();
  }

  @override
  DateTime lastModifiedSync() {
    throw UnimplementedError();
  }

  @override
  Future<int> length() async {
    final fHandle = await _handle.getFile().toDart;
    return fHandle.size;
  }

  @override
  int lengthSync() {
    throw UnimplementedError();
  }

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> openRead([int? start, int? end]) {
    throw UnimplementedError();
  }

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) {
    throw UnimplementedError();
  }

  @override
  IOSink openWrite({FileMode mode = FileMode.write, Encoding encoding = utf8}) {
    throw UnimplementedError();
  }

  @override
  Directory get parent => throw UnimplementedError();

  @override
  String get path => throw UnimplementedError();

  @override
  Future<Uint8List> readAsBytes() {
    return readAsString().then((str) => utf8.encode(str));
  }

  @override
  Uint8List readAsBytesSync() {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) {
    return readAsString(encoding: encoding)
        .then((str) => const LineSplitter().convert(str));
  }

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) {
    throw UnimplementedError();
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) async {
    final fHandle = await _handle.getFile().toDart;
    final jsString = await fHandle.text().toDart;
    return jsString.toDart;
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    throw UnimplementedError();
  }

  @override
  Future<File> rename(String newPath) {
    throw UnimplementedError();
  }

  @override
  File renameSync(String newPath) {
    throw UnimplementedError();
  }

  @override
  Future<String> resolveSymbolicLinks() {
    throw UnimplementedError();
  }

  @override
  String resolveSymbolicLinksSync() {
    throw UnimplementedError();
  }

  @override
  Future setLastAccessed(DateTime time) {
    throw UnimplementedError();
  }

  @override
  void setLastAccessedSync(DateTime time) {
    throw UnimplementedError();
  }

  @override
  Future setLastModified(DateTime time) {
    throw UnimplementedError();
  }

  @override
  void setLastModifiedSync(DateTime time) {
    throw UnimplementedError();
  }

  @override
  Future<FileStat> stat() {
    throw UnimplementedError();
  }

  @override
  FileStat statSync() {
    throw UnimplementedError();
  }

  @override
  Uri get uri => throw UnimplementedError();

  @override
  Stream<FileSystemEvent> watch(
      {int events = FileSystemEvent.all, bool recursive = false}) {
    throw UnimplementedError();
  }

  @override
  Future<File> writeAsBytes(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    throw UnimplementedError();
  }

  @override
  void writeAsBytesSync(List<int> bytes,
      {FileMode mode = FileMode.write, bool flush = false}) {
    throw UnimplementedError();
  }

  @override
  Future<File> writeAsString(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) async {
    final writeStream = await _handle.createWritable().toDart;
    await writeStream.write(contents.toJS).toDart;
    return this;
  }

  @override
  void writeAsStringSync(String contents,
      {FileMode mode = FileMode.write,
      Encoding encoding = utf8,
      bool flush = false}) {
    throw UnimplementedError();
  }
}
