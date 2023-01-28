import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:king_of_omi/map.dart';
import 'package:latlong2/latlong.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.title});
  final String title;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MapController mapController = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ドキュメント作成
    FirebaseFirestore.instance
        .collection('quests') // コレクションID
        .doc('1') // ドキュメントID
        .get().then(
        (doc) => {

    }
    ); // データ
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: MapView(mapController: mapController)),
            Expanded(
              child: ListView(
                children: [
                  Text("aaa"),
                  Text("bbb"),
                  Text("ccc"),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        child: Icon(Icons.add), onPressed: () {
        LatLng now = mapController.center;
        //ドキュメント作成
        FirebaseFirestore.instance
            .collection('quests') // コレクションID
            .doc('1') // ドキュメントID
            .set({ "tilte": "テスト", "location": {"latitude": now.latitude, "longitude": now.longitude}});
      },),
    );
  }
}
