import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:king_of_omi/detail.dart';
import 'package:king_of_omi/quest.dart';
import 'package:king_of_omi/rank.dart';
import 'package:latlong2/latlong.dart';

import 'edit.dart';

class RankingPage extends StatefulWidget {
  RankingPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  Function()? onPressed;

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<Rank> list = [];

  refresh() {
    FirebaseFirestore.instance
        .collection("points")
        .orderBy('point', descending: true)
        .get()
        .then((points) {
      setState(() {
        list = points.docs.map<Rank>((e) {
          return Rank().fromMap(e.id, e.data());
        }).toList();
      });
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Image.asset("assets/images/map.png"),
          ),
          SizedBox(
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Theme.of(context).colorScheme.primary,
                        height: 80,
                      )),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle),
                    height: 120,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ],
              )),
          Expanded(
              child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: ListView(
                    children: list
                        .asMap()
                        .entries
                        .map<Widget>((e) => ListTile(
                              title: Card(
                                  shape: const StadiumBorder(
                                      side: BorderSide.none),
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        e.key < 5
                                            ? Image.asset(
                                                "assets/images/${e.key + 1}_ranking.png",
                                                width: 70,
                                                height: 70)
                                            : const SizedBox(
                                                width: 70,
                                                height: 70,
                                              ),
                                        ElevatedButton(
                                          child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: const Icon(
                                                Icons.person_outlined,
                                                size: 30,
                                              )),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: CircleBorder(
                                              side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                width: 1,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              children: [
                                                Text(e.value.name,
                                                    overflow: TextOverflow.fade,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium
                                                        ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary)),
                                                Text("${e.value.point}pt",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium)
                                              ],
                                            ))
                                      ])),
                            ))
                        .toList(),
                  )))
        ],
      )),
    );
  }
}
