import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:king_of_omi/cleared.dart';
import 'package:king_of_omi/map.dart';
import 'package:king_of_omi/quest.dart';
import 'package:latlong2/latlong.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.title, required this.quest});
  final String title;
  final Quest quest;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MapController mapController = MapController();
  bool isActive = false;
  bool canClear = false;
  double radius = 0.0001;
  late StreamSubscription streamSubscription;
  List<Widget> carousel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    streamSubscription = Geolocator.getPositionStream().listen((position) {
      LatLng loc1 =
          LatLng(position.latitude - radius, position.longitude - radius);
      LatLng loc2 =
          LatLng(position.latitude + radius, position.longitude + radius);
      setState(() {
        canClear = LatLngBounds(loc1, loc2).contains(widget.quest.location);
      });
    });

    setState(() {
      carousel.addAll(widget.quest.image);
      carousel.add(MapView(
          mapController: mapController,
          showMyLocation: false,
          location: widget.quest.location));
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
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
              child: CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1, enableInfiniteScroll: false),
                items: carousel,
              ),
            ),
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
            !isActive
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10), child: Text("挑戦")))
                : ElevatedButton(
                    onPressed: !canClear
                        ? () {
                            if (canClear) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return ClearedPage(
                                    title: "クエスト達成", quest: widget.quest);
                              }));
                            }
                          }
                        : null,
                    child: const Padding(
                        padding: EdgeInsets.all(10), child: Text("達成")))
          ],
        ),
      ),
    );
  }
}
