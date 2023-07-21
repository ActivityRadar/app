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
  PhotoService();

  final String bucket = secrets.awsBucketName;

  Future<MemoryImage> getPhoto(String id) async {
    dynamic res = await s3Service.getObject(bucket: bucket, key: id);
    return MemoryImage(res.body);
  }

  Future<void> uploadPhoto(
      {required MemoryImage image, required String path}) async {
    try {
      await s3Service.putObject(bucket: bucket, key: path, body: image.bytes);
    } catch (e) {
      print(e);
    }
  }

  String createPath(
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

  String _getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return sha1.convert(utf8.encode(base64Encode(values))).toString();
  }
}
