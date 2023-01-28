import 'package:latlong2/latlong.dart';

class Quest {
  String id = "";
  String title = "";
  LatLng location = LatLng(0, 0);

  Quest fromMap(String id, Map<String, dynamic> map){
    this.id = id;
    title = map!["title"];
    location = LatLng(map!["location"]["latitude"], map!["location"]["longitude"]);
    return this;
  }
}