import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:king_of_omi/home.dart';
import 'package:king_of_omi/main.dart';
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

  int point = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("points")
        .doc("ceMFj61EBSe3S77F7WBk")
        .get()
        .then((data) {
      setState(() {
        point = data.data()!["point"];
      });
    });
  }

  @override
  void dispose() {
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
                              padding:
                                  const EdgeInsets.all(8).copyWith(bottom: 20),
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
                      Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                "獲得ポイント",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/point_brown.png"),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${widget.quest.point}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            "pt",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        )
                                      ])
                                ],
                              ),
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.black45),
                                  ),
                                ),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("総ポイント"),
                                    Text("${point}pt"),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Row(children: [
                      ElevatedButton(
                      child: Padding(padding:EdgeInsets.all(5), child: const Icon(Icons.person_outlined, size: 40,)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape:  CircleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
                        Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: SizedBox(height: 100, width:150, child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("私に聞いてください!",style: Theme.of(context).textTheme.bodySmall),
                              Text(widget.quest.createdUser+"さん", style: Theme.of(context).textTheme.headlineSmall,),
                            ],
                          )),
                        ),

                      ],),
                    ],
                  ),
                ),

                Padding(
                    padding: EdgeInsets.all(10),
                    child:
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "他のクエストに参加する",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15),
                            )))
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child:
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(0);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                            return MyHomePage(selectedIndex: 0);
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "ホームに戻る",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor, fontSize: 18),
                            )))
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
