import 'package:flutter/material.dart';
import 'package:quickstartflutter/service/index.dart';

class AllNearbyDriver extends StatefulWidget {
  @override
  _AllNearbyDriverState createState() => _AllNearbyDriverState();
}

class _AllNearbyDriverState extends State<AllNearbyDriver> {
  final _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'All Nearby Drivers',
          style: TextStyle(),
        ),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _service.fetchNearby(),
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
                      child: Text("No Categories Found"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: Text(snapshot.data[i]['device_id']),
                            subtitle: Text(snapshot.data[i]['location']['geometry']['coordinates'].toString()),
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
