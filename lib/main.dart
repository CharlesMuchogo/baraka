import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:openai/gpt_3.dart';
import 'package:openai/home.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await FlutterConfig.loadEnvVariables();
  HttpOverrides.global = MyHttpOverrides();

  OpenAI openAI = new OpenAI(apiKey: FlutterConfig.get("Your_API_Key"));
  runApp(MyApp(openAI));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  final OpenAI openAI;
  MyApp(this.openAI);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SafeArea(child: Home(openAI)),
    );
  }
}
