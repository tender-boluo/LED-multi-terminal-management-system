import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'gmt.dart';

class Oss {
  String key = 'LTAIOi6gPtPWioH4';
  String secret = 'BRtQbQBNU9ky0RWN5CFvX2zbU0OoUZ';
  String endpoint = 'oss-cn-beijing.aliyuncs.com';
  String bucketName = 'software-terminal';

  Options headerSign({String args}) {
    String gmt = Gmt.format(DateTime.now().millisecondsSinceEpoch+10*1000);//'Tue, 12 Mar 2019 05:11:16 GMT';//DateTime.now().toIso8601String();
    print("gmt $gmt");
    if(args == null) {
      args = '/';
    }
    else {
      args = "/$args/";
    }
    String signature = base64.encode(Hmac(sha1, utf8.encode(secret)).convert(
        utf8.encode("GET\n\n\n$gmt\n$args")
    ).bytes);

    Options options = Options(
        headers: {
          'Authorization':"OSS " + key + ":" + signature,
          'Date':gmt,
        }
    );
    return options;
  }
}