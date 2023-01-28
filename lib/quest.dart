import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
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
  String createdUser = "";
  List<Image> image = [];
  List<Widget> sumbnail = [];

  Widget get subtitle => Row(crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(padding: EdgeInsets.only(right: 10),
        child:     Text("${point}p", style: const TextStyle(fontSize: 20),),
        ),
        Padding(padding: EdgeInsets.only(right: 10),
          child:        Text(DateFormat.yMMMMd('ja').format(createdAt)),
        ),
    Expanded(child: Text(description, overflow: TextOverflow.ellipsis, maxLines: 1),)
  ]);

  Quest fromMap(String id, Map<String, dynamic> map) {
    this.id = id;
    title = map["title"] ?? "";
    location =
        LatLng(map["location"]["latitude"] ?? 0, map["location"]["longitude"] ?? 0);
    description = map["description"] ?? "";
    point = int.parse(map["point"] ?? "0");
    createdAt = (map["createdAt"] as Timestamp).toDate();
    createdUser = map["createdUser"] ?? "";
    if(map.containsKey("image")){
      image = (map["image"] as List).map((e) => Image.memory(base64.decode(e.toString()), fit: BoxFit.cover)).toList();
      sumbnail = (map["image"] as List).map((e) =>
      Container(
          width: 100, height: 100,
          child:  ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.memory(base64.decode(e.toString()), fit: BoxFit.cover)))).toList();
    }
    return this;
  }
}
