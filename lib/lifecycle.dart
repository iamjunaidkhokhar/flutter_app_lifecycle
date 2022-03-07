
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AppLifeCycle extends StatefulWidget {
  final Widget child;

  const AppLifeCycle({required this.child, Key? key}) : super(key: key);

  @override
  _AppLifeCycleState createState() => _AppLifeCycleState();
}

class _AppLifeCycleState extends State<AppLifeCycle> with WidgetsBindingObserver {
  late DateTime _startTime;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _startTime = DateTime.now();
    // to start anything with app start
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    // to kill anything with app exit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _appUsageDetail(DateTime.now().difference(_startTime));
        return;
      case AppLifecycleState.resumed:
        _startTime = DateTime.now();
        return;
      default:
        return;
    }
  }
}

void _appUsageDetail(Duration time) {
  if (kDebugMode) {
    print("You app was being used ${time.inSeconds}");
  }
}
