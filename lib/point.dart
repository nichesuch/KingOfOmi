import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:king_of_omi/detail.dart';
import 'package:king_of_omi/quest.dart';

import 'edit.dart';

class PointPage extends StatefulWidget {
  const PointPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {

  int point = 0;
  String name = "";

  @override
  void initState() {
    FirebaseFirestore.instance.collection("points").doc("ceMFj61EBSe3S77F7WBk").get().then((data) {
      setState(() {
        point = data.data()!["point"];
        name = data.data()!["user"];
      });
    });
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
            child: Text("$pointポイント", style: Theme.of(context).textTheme.headlineLarge,)
        ),
    );
  }
}
