import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

String header = "application/json";
const content = "application/x-www-form-urlencoded";

class HttpClientService {
  static Future<http.Response?> getRequest([
    String? url,
    // String? token,
  ]) async {
    http.Response? response;

    log("This is the http client service url: $url");

    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          // HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
    } catch (e) {
      response = null;
      log(e.toString());
    }
    return response;
  }
}
