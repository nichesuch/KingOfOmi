import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:king_of_omi/map.dart';
import 'package:latlong2/latlong.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.title, this.id});
  final String title;
  final String? id;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  MapController mapController = MapController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  bool showMyLocation = false;
  String dataTitle = "";

  @override
  void initState() {
    super.initState();

    // ドキュメント作成
    Map<String, dynamic>? docdata;

    if (widget.id != null) {
      FirebaseFirestore.instance
          .collection('quests') // コレクションID
          .doc(widget.id) // ドキュメントID
          .get()
          .then((doc) {
        docdata = doc.data();
        print(docdata);
        if (docdata == null) return;

        setState(() {
          dataTitle = docdata!["title"];
          mapController.move(
              LatLng(docdata!["location"]["latitude"],
                  docdata!["location"]["longitude"]),
              16);
        });
      }); // データ
    } else {
      setState(() {
        showMyLocation = true;
      });
    }
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
                child: MapView(
                    mapController: mapController,
                    showMyLocation: showMyLocation)),
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: "クエスト名",
                      hintText: 'Enter a search term',
                    ),
                  ),
                  TextField(
                    controller: pointController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "獲得ポイント",
                      hintText: 'Enter a search term',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "クエスト詳細",
                      hintText: 'Enter a search term',
                    ),
                      maxLines: 10
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        child: Icon(Icons.add),
        onPressed: () {
          LatLng now = mapController.center;
          //ドキュメント作成
          FirebaseFirestore.instance
              .collection('quests') // コレクションID
              .add({
            "title": titleController.text,
            "point": pointController.text,
            "description": descriptionController.text,
            "location": {"latitude": now.latitude, "longitude": now.longitude},
            "createdAt": DateTime.now()
          }).then((value) => Navigator.of(context).pop());
        },
      ),
    );
  }
}
