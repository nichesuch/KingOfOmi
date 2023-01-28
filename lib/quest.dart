import 'package:latlong2/latlong.dart';

class Quest {
  String id = "";
  String title = "";
  int point = 0;
  String description = "";
  String address = "";
  LatLng location = LatLng(0, 0);
  DateTime startAt = DateTime(2023);
  DateTime endAt = DateTime(2023);
  DateTime createdAt = DateTime(2023);
  String createdUserId = "";

  Quest fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    title = map["title"];
    location =
        LatLng(map["location"]["latitude"], map["location"]["longitude"]);
    return this;
  }
}
