import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:aws_s3_api/s3-2006-03-01.dart';

import 'package:app/constants/secrets.dart' as secrets;

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

  Future<MemoryImage> getPhoto(String url) async {
    if (!_storage.containsKey(url)) {
      final img = await PhotoService.getPhoto(url);
      _storage[url] = img;
    } else {
      print("Got image from storage!");
    }

    return _storage[url]!;
  }

  Future<bool> setPhoto(MemoryImage img, String url) async {
    try {
      await PhotoService.uploadPhoto(image: img, path: url);
      _storage[url] = img;
      return true;
    } catch (e) {
      return false;
    }
  }
}
