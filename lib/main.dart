import 'package:api_requests_1ln_hw/cats_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String fact = '';



  Future<void> getData() async {
    Dio dio = Dio();
    Response response = await dio.get("https://catfact.ninja/fact");
    CatsModel model = CatsModel.fromJson(response.data);
    setState(() {
      fact = model.fact ?? '';
    });
    translate();
  }

    Future <void> translate() async {
    final translator = GoogleTranslator();
    Translation translatedText = await translator.translate(fact, from: 'en', to: 'ru');
    setState(() {
      fact = translatedText.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(fact),
              SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(.5)
                  ),
                  onPressed: getData,
                  child: const Text(
                    "Увидеть факт о кошках",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
