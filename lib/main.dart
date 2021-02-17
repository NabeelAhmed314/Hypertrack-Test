import 'package:flutter/material.dart';
import 'package:quickstartflutter/src/Home.dart';

void main() => runApp(HyperTrackApp());

class HyperTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home()
    );
  }
}