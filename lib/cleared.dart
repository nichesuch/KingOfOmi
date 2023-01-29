import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:king_of_omi/map.dart';
import 'package:king_of_omi/quest.dart';
import 'package:latlong2/latlong.dart';

class ClearedPage extends StatefulWidget {
  const ClearedPage({super.key, required this.title, required this.quest});
  final String title;
  final Quest quest;

  @override
  State<ClearedPage> createState() => _ClearedPageState();
}

class _ClearedPageState extends State<ClearedPage> {
  MapController mapController = MapController();
  bool isActive = false;
  bool canClear = false;
  double radius = 0.0001;
  late StreamSubscription streamSubscription;
  MaterialStatesController statesController = MaterialStatesController();

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
        if (canClear) {
          print("can Clear");
          statesController.update(MaterialState.disabled, true);
        } else {
          print("NO Clear");
          statesController.update(MaterialState.focused, false);
        }
      });
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
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
          children: <Widget>[
            widget.quest.image.first,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SizedBox(
                        height: 100,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 30,
                                right: 30,
                                child: Container(
                                  color: Colors.white,
                                  height: 40,
                                )),
                            Container(
                              padding: const EdgeInsets.all(8).copyWith(bottom: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 30, left: 30),
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset("assets/images/clear.png"),
                      Text(
                        "「${widget.quest.title}」",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),

                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("ポイント獲得条件")),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.black45),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: const Text("スマホを持って現地を訪問する"),
                      ),

                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("クエスト作成者")),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.black45),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(widget.quest.createdUser),
                      ),
                      Padding(padding: EdgeInsets.all(30), child:
                      !isActive
                          ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(10), child: Text("クエストに参加する", style: TextStyle(color: Colors.white, fontSize: 18),)))
                          : ElevatedButton(
                          onPressed: canClear
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
