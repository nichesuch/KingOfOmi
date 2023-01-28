import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:king_of_omi/map.dart';
import 'package:king_of_omi/quest.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.title, required this.quest});
  final String title;
  final Quest quest;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MapController mapController = MapController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.quest.title),
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
                    showMyLocation: false,
                    location: widget.quest.location)),
            Expanded(
              child: ListView(
                children: [
                  const Text("クエスト詳細"),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(widget.quest.description),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Padding(
                    padding: EdgeInsets.all(10), child: Text("挑戦")))
          ],
        ),
      ),
    );
  }
}
