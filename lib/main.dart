import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'lifecycle.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterBranchSdk.validateSDKIntegration();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Counter counter = Counter();
  Color backgroundColor = Colors.white;

  void listenDynamicLinks() async {
    FlutterBranchSdk.initSession().listen((data) {
      print('listenDynamicLinks - DeepLink Data: $data');
      if (data['key'] == 'open page') {
        setState(() {
          backgroundColor = Colors.black;
        });
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print(
          'InitSession error: ${platformException.code} - ${platformException.message}');
    });
  }

  @override
  initState() {
    super.initState();

    listenDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppLifeCycle(
        child: Scaffold(
          backgroundColor: backgroundColor,
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
