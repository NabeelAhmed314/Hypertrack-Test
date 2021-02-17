import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Trip extends StatefulWidget {
  final url;

  Trip(this.url);

  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Trip Track Page',
          style: TextStyle(),
        ),
      ),
      body: WebView(
          key: _key,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
      ),
    );
  }
}
