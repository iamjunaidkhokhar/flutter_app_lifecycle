import 'package:flutter/material.dart';
import 'lifecycle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppLifeCycle(
        child: Scaffold(
          body: const Center(
            child: Text('Your Counter value is in console'),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                print(counter.value);
                counter.increment();
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
