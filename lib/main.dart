import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:openai/gpt_3.dart';
import 'package:openai/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;

  OpenAI openAI =
      new OpenAI(apiKey: "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");
  runApp(MyApp(openAI));
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
