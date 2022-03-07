import 'package:flutter/material.dart';

import 'lifecycle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppLifeCycle(
        child: Scaffold(
          body: Center(
            child: Text('Your Counter value is ${Counter().value}'),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Counter().increment();
              },
              child: const Icon(Icons.add)),
        ),
      ),
    );
  }
}

class Counter {
  static final Counter _instance = Counter._internal();

  factory Counter() => _instance;

  Counter._internal();

  int _value = 0;

  void increment() {
    _value++;
  }

  int get value => _value;
}
