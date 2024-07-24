import 'dart:convert';

import 'package:bittrack_frontend/models/trustScore.model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final localhostIP = "http://10.0.2.2:3000";
  final deployURL = "https://absence-system.vercel.app";

  String get currentURL => deployURL;
  final Duration timeoutDuration = const Duration(seconds: 10);

  Future<int> fetchTrustScore() async {
    try {
      // final int trustScore this is put on damn bro this is cool
      final response = await http
          .get(Uri.parse(
              'http://www.randomnumberapi.com/api/v1.0/random?min=1&max=100&count=1'))
          .timeout(timeoutDuration);
      final body = jsonDecode(response.body);
      return body[0];
    } catch (e) {
      rethrow;
    }
  }
}
