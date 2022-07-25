import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class OpenAI {
  String apiKey;
  OpenAI({required this.apiKey});

  Future<String> answer(
    String question,
    int maxTokens,
    List examples,
    List documents, {
    // String examplesContext = "En 1821, fue su independencia.",
    // String searchModel = 'ada',
    String model = 'text-davinci-002',
  }) async {
    String apiKey = this.apiKey;

    Map reqData = {
      "model": model,
      "prompt": question,
      "max_tokens": 4000,
      "temperature": 0.7,
    };

    var response = await http
        .post(
          Uri.parse('https://api.openai.com/v1/completions'),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 120));

    // return response.body.toString();

    Map<String, dynamic> map = json.decode(response.body);
    if (map.isEmpty) {
      return "No results found";
    } else {
      return map["choices"][0]["text"].toString();
    }
  }
}
