import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickstartflutter/model/nearby-data_model.dart';
import 'package:quickstartflutter/model/trip-data_model.dart';

class Service {
  Future<List> fetch() async {
    var response = await http
        .get(Uri.encodeFull("https://v3.api.hypertrack.com/devices"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
          "Basic UUNVX1FFWDJWNkZ0bTJZd285SFBQbTNjaFV3Okk4Mkk0NFBsTnpKU21OVkFCUk9EeWhER0lqbkVTVTdMc2NVeVpVaE45R3ItQXZMTEZWLVNSQQ=="
    });

    var data = jsonDecode(response.body) as List;
    return data;
    // return data.map((item) => parse(item)).toList();
  }

  Future<List> fetchNearby() async {
    var nearbyData = new NearbyData();
    var location = new Location();
    location.type = "Point";
    location.coordinates = [71.505247, 30.191109, 76.96];
    nearbyData.location = location;
    nearbyData.radius = 1000;
    nearbyData.lastUpdatedWithin = 24;
    print(nearbyData.toJson());
    var response =
        await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/devices/nearby"),
            body: jsonEncode(nearbyData),
            headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
              "Basic UUNVX1FFWDJWNkZ0bTJZd285SFBQbTNjaFV3Okk4Mkk0NFBsTnpKU21OVkFCUk9EeWhER0lqbkVTVTdMc2NVeVpVaE45R3ItQXZMTEZWLVNSQQ=="
        });
    print(response);
    var data = jsonDecode(response.body);
    print(data['data']);
    return data['data'] as List;
    // return data.map((item) => parse(item)).toList();
  }
  Future createTrip() async {
    var tripData = new TripData();
    var destination = new Destination();
    var geometry = new Geometry();
    geometry.type = "Point";
    geometry.coordinates = [71.525008,30.169112];
    destination.geometry = geometry;
    tripData.deviceId = 'B4DF3A49-F288-4080-9AB8-E3D5CED4E355';
    tripData.destination = destination;
    print(tripData.toJson());
    var response =
    await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/trips"),
        body: jsonEncode(tripData),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
          "Basic UUNVX1FFWDJWNkZ0bTJZd285SFBQbTNjaFV3Okk4Mkk0NFBsTnpKU21OVkFCUk9EeWhER0lqbkVTVTdMc2NVeVpVaE45R3ItQXZMTEZWLVNSQQ=="
        });
    print(response);
    var data = jsonDecode(response.body);
    print(data);
    return data;
    // return data.map((item) => parse(item)).toList();
  }
}
