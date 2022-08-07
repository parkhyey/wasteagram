import 'package:flutter/material.dart';

class FindSum extends StatefulWidget {
  const FindSum({Key? key}) : super(key: key);

  @override
  State<FindSum> createState() => _FindSumState();
}

class _FindSumState extends State<FindSum> {
  int sum = 0;

  int _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      sum++;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_incrementCounter().toString()),
      ]
    );
  }
}
