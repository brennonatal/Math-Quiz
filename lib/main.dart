import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyLoginPage(title: 'Math Quiz'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Your name: ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                        labelText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        username: controller.text,
                        title: 'Math Quiz',
                      )));
        },
        tooltip: 'Send Answer',
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _score = 0;
  int _a = Random().nextInt(100);
  int _b = Random().nextInt(100);
  final answerController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    answerController.dispose();
    super.dispose();
  }

  int checkAnswer(String? answer) {
    if (answer == null) return 0;
    double ans = -10000;
    try {
      ans = double.parse(answer);
    } catch (e) {
      return 0;
    }

    if (ans == _a + _b) {
      return 1;
    }

    return 0;
  }

  Future<void> score() async {
    String user = widget.username;
    var response = await http.post(
      Uri.parse('https://7c2bad50.us-south.apigw.appdomain.cloud/api/placar'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'usuario': user,
      }),
    );
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body);
    } else {
      throw Exception('Erro ao mandaar ponto');
    }
  }

  void _sendAnswer() {
    int isCorrect = checkAnswer(answerController.text);

    if (isCorrect == 1) {
      score();
      setState(() {
        _score++;
        _a = Random().nextInt(100);
        _b = Random().nextInt(100);
      });
    } else {
      setState(() {
        _score = 0;
        _a = Random().nextInt(100);
        _b = Random().nextInt(100);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Score: $_score',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ]),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$_a',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      ' + ',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      '$_b = ',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: TextField(
                        controller: answerController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 4,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          labelText: '',
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (_sendAnswer),
        tooltip: 'Send Answer',
        child: const Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
