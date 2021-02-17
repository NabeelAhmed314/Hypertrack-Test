import 'package:flutter/material.dart';
import 'package:quickstartflutter/service/index.dart';
import 'package:quickstartflutter/src/all-nearby-drivers.dart';

class AllDriver extends StatefulWidget {
  @override
  _AllDriverState createState() => _AllDriverState();
}

class _AllDriverState extends State<AllDriver> {
  final _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'All Drivers',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
              iconSize: 25,
              icon: Icon(Icons.assistant_navigation),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AllNearbyDriver()));
              })
        ],
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _service.fetch(),
          // ignore: missing_return
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text("No Connection");
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text("No Drivers"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Text(snapshot.data[i]['device_id']),
                            subtitle: Text(snapshot.data[i]['device_status']
                                    ['value']
                                .toString()
                                .toUpperCase()),
                          );
                        });
                  }
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
