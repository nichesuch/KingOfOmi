import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:king_of_omi/detail.dart';
import 'package:king_of_omi/main.dart';
import 'package:king_of_omi/quest.dart';

import 'edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(children: [
        Padding(padding: EdgeInsets.all(50)),
        Expanded(
            child: Image.asset(
          "assets/images/logo.png",
          scale: 0.5,
        )),
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return MyHomePage(
                              selectedIndex: 4,
                            );
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/images/list.png", height: 70,),
                                Padding(padding: EdgeInsets.all(10)),
                                const Text(
                                  "クエストを\n登録する",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return MyHomePage(
                              selectedIndex: 1,
                            );
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/images/omi_icon_sanka.png", height: 70,),
                                Padding(padding: EdgeInsets.all(10)),
                                const Text(
                                  "クエストに\n参加する",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ))))),
          ],
        ))
      ]),
    );
  }
}
