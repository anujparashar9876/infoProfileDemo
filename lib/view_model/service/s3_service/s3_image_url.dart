import 'dart:convert';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:infoprofiledemo/data/app_exception.dart';
import 'package:infoprofiledemo/view_model/service/s3_service/s3_creds.dart';

import 'dart:io';

import 'package:intl/intl.dart';



Future<Uint8List> fileToUint8List(File file) async {
  try {
    Uint8List uint8list = await file.readAsBytes();

    return uint8list;
  } catch (e) {
    throw Uint8ListConvertException(e.toString());
  }
}

class S3Services {
  Future<String?> upload({
    required File file,
    required String userid,
  }) async {
    Uint8List data;

    try {
      data = await fileToUint8List(file);
    } catch (e) {
      rethrow;
    }

    String formattedDateTime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String fileName = '$userid-$formattedDateTime';
    final length = data.length;
    var s3Endpoint = StorageCredentials.bucketurl;
    final uri = Uri.parse(s3Endpoint);
    final req = http.MultipartRequest('POST', uri);
    final multipartFile = http.MultipartFile(
      'file',
      http.ByteStream.fromBytes(data),
      length,
      filename: fileName,
    );

    final policy = Policy.fromS3PresignedPost(
      fileName,
      StorageCredentials.bucketName,
      StorageCredentials.accesskey,
      15,
      length,
      region: StorageCredentials.region,
    );
    final key = SigV4.calculateSigningKey(StorageCredentials.secretaccesskey,
        policy.datetime, StorageCredentials.region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;

    try {
      await req.send();
      debugPrint('$s3Endpoint$fileName');
      return '$s3Endpoint$fileName';
      
    } catch (e) {
      debugPrint(e.toString());
      throw AWSBucketException(e.toString());
    }
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize,
      {this.region = 'us-east-1'});

  factory Policy.fromS3PresignedPost(
    String key,
    String bucket,
    String accessKeyId,
    int expiryMinutes,
    int maxFileSize, {
    required String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        region: region);
    return p;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
{ "expiration": "$expiration",
  "conditions": [
    {"bucket": "$bucket"},
    ["starts-with", "\$key", "$key"],
    {"acl": "public-read"},
    ["content-length-range", 1, $maxFileSize],
    {"x-amz-credential": "$credential"},
    {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
    {"x-amz-date": "$datetime" }
  ]
}
''';
  }
}
