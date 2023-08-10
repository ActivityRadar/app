import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:aws_s3_api/s3-2006-03-01.dart';

import 'package:app/constants/secrets.dart' as secrets;
import 'package:flutter_image_compress/flutter_image_compress.dart';

AwsClientCredentials credentials = AwsClientCredentials(
    accessKey: secrets.awsAccessKey, secretKey: secrets.awsSecretKey);
final s3Service = S3(region: "eu-central-1", credentials: credentials);

class PhotoService {
  static final String bucket = secrets.awsBucketName;

  static Future<MemoryImage> getPhoto(String id) async {
    try {
      print("Downloading photo $id...");
      dynamic res = await s3Service.getObject(bucket: bucket, key: id);
      return MemoryImage(res.body);
    } catch (e) {
      print("S3 download failed: $e");
      rethrow;
    }
  }

  static Future<void> uploadPhoto(
      {required MemoryImage image, required String path}) async {
    try {
      await s3Service.putObject(bucket: bucket, key: path, body: image.bytes);
    } catch (e) {
      print("S3 upload failed: $e");
      rethrow;
    }
  }

  static String createPath(
      {required String mode,
      required String extension,
      String? userId,
      String? locationId}) {
    String path;

    switch (mode) {
      case "profile-picture":
        if (userId == null) {
          throw Exception("User ID missing!");
        }

        // this will simply overwrite the previous profile picture...
        path = "$mode/$userId";
      case "location":
        if (locationId == null) {
          throw Exception("Location ID missing!");
        }

        // this might overwrite an existing image, so
        // TODO: check if this image exists yet
        final random = _getRandString(16);

        path = "$mode/$locationId/$random";
      default:
        throw Exception("Mode $mode not supported!");
    }

    return "$path.$extension";
  }

  static String _getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return sha1.convert(utf8.encode(base64Encode(values))).toString();
  }
}

/// A class for managing downloaded images to not redonwload them all the time.
/// TODO: Store files not in memory, but in phone storage.
class PhotoManager {
  final Map<String, MemoryImage> _storage = {};

  static final PhotoManager _instance = PhotoManager._internal();
  static PhotoManager get instance => _instance;
  PhotoManager._internal();

  Future<MemoryImage> getPhoto(String url, {bool force = false}) async {
    if (!_storage.containsKey(url) || force) {
      final img = await PhotoService.getPhoto(url);
      _storage[url] = img;
    } else {
      print("Got image from storage!");
    }

    return _storage[url]!;
  }

  /// gets the thumbnail for a photo, if no thumbnail is found, use the actual photo instead
  Future<MemoryImage> getThumbnail(String url) async {
    late final img;
    try {
      img = await getPhoto(getThumbnailUrl(url));
    } catch (e) {
      print(e);
      img = await getPhoto(url);
    }

    return img;
  }

  String getThumbnailUrl(String url) {
    return "$url.thm";
  }

  Future<MemoryImage> compress(Uint8List bytes, int size) async {
    final compressed = await FlutterImageCompress.compressWithList(bytes,
        minWidth: size, minHeight: size);
    return MemoryImage(compressed);
  }

  Future<bool> setPhoto(MemoryImage img, String url) async {
    try {
      // compress image and upload as thumbnail first
      final thumbnail = await compress(img.bytes, 300);
      final thumbnailUrl = getThumbnailUrl(url);
      await PhotoService.uploadPhoto(image: thumbnail, path: thumbnailUrl);
      _storage[thumbnailUrl] = thumbnail;

      // now compress to avoid uploading big images
      final downsized = await compress(img.bytes, 1000);
      await PhotoService.uploadPhoto(image: downsized, path: url);
      _storage[url] = downsized;
      return true;
    } catch (e) {
      return false;
    }
  }
}
