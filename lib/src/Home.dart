import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:quickstartflutter/service/index.dart';
import 'package:quickstartflutter/src/all-drivers.dart';
import 'package:quickstartflutter/src/trip-page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const key =
      'E7SYwYPqRKfheJyc6elMgxeeVznvJ65ACY7s8cH5Xdz-F8PWg_oIB03Rk3Un7KQ_uxqztCoQpcVKeqSY0242cQ'; //Provide the publishable key from the dashboard
  String deviceName = 'Infinix'; //Provide a name for your device
  String _result = 'Not initialized';
  String _deviceId = '';
  HyperTrack sdk;
  String buttonLabel = 'Start Tracking';
  Color buttonColor = Colors.green;
  final _service = new Service();

  void initState() {
    super.initState();
    initializeSdk();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initializeSdk() async {
    HyperTrack.enableDebugLogging();
    // Initializer is just a helper class to get the actual sdk instance
    String result = 'failure';
    try {
      sdk = await HyperTrack.initialize(key);
      updateButtonState();
      result = 'initialized';
      sdk.setDeviceName(deviceName);
      sdk.setDeviceMetadata({"source": "flutter sdk"});
      sdk.onTrackingStateChanged.listen((TrackingStateChange event) {
        if (mounted) {
          setState(() {
            _result = '$event';
          });
          updateButtonState();
        }
      });
    } catch (e) {
      print(e);
    }

    final deviceId = (sdk == null) ? "unknown" : await sdk.getDeviceId();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _result = result;
      _deviceId = deviceId;
    });
  }

  void start() => sdk.start();

  void stop() => sdk.stop();

  void syncDeviceSettings() => sdk.syncDeviceSettings();

  Text getDeviceIdText() {
    return Text(
      _deviceId,
      style: TextStyle(fontSize: 16.0),
    );
  }

  Text displayButton() {
    return (Text(
      this.buttonLabel,
      style: TextStyle(color: Colors.white),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            print('In Trip');
            var data =  await _service.createTrip();
            print('After Create Trip');
            print(data);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Trip(data['views']['share_url'] + '?icon=car&mini=all&layer=street')));
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Driver App',
            style: TextStyle(),
          ),
          actions: [
            IconButton(
                iconSize: 25,
                icon: Icon(Icons.assistant_navigation),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllDriver()));
                })
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Center(
                  child: getDeviceIdText(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  color: buttonColor,
                  onPressed: () {
                    if (this.buttonLabel == "Stop Tracking") {
                      stop();
                    } else {
                      start();
                    }
                  },
                  child: displayButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonState() async {
    final isRunning = await sdk.isRunning();
    if (isRunning) {
      setState(() {
        this.buttonLabel = "Stop Tracking";
        this.buttonColor = Colors.red;
      });
    } else {
      setState(() {
        this.buttonLabel = "Start Tracking";
        this.buttonColor = Colors.green;
      });
    }
  }
}
