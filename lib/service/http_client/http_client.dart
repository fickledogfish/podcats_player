import 'dart:typed_data';

import 'package:http/http.dart' as http;

class HttpClient {
  const HttpClient();

  Future<String> getString({
    required Uri url,
    Map<String, String>? headers,
  }) async =>
      await http.read(url, headers: headers);

  Future<Uint8List> getBytes({
    required Uri url,
    Map<String, String>? headers,
  }) async =>
      await http.readBytes(url, headers: headers);
}
