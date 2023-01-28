import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:king_of_omi/detail.dart';
import 'package:king_of_omi/quest.dart';

import 'edit.dart';

class ListPage extends StatefulWidget {
  ListPage({super.key, required this.title, this.onPressed});

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
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Iterable<Quest> list = [];

  refresh(){
    FirebaseFirestore.instance.collection("quests").orderBy('createdAt', descending: true).get().then((quests) {
      setState(() {
        list = quests.docs.map<Quest>((e) {
          return Quest().fromMap(e.id, e.data());
        });
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
            child: ListView(
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset("assets/images/map.png"),
                ),
                SizedBox(
                  height: 100,
                  child: Image.asset("assets/images/logo.png"),
                ),
                Column(
                    children: list
                        .map<Widget>(
                          (e) =>
                         ListTile(
                           title: Card(
                             margin: const EdgeInsets.all(10),
                            child: Stack(children: [
                              Padding(
                                  padding: EdgeInsets.all(10),
                            child:
                            e.sumbnail.isEmpty ? const Icon(Icons.people) : e.sumbnail.first),
                            Padding(padding: const EdgeInsets.only(left: 120),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(e.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.orange),),
                              e.subtitle,
                            ])),

                          ])
                           ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailPage(title: "クエスト詳細", quest: e);
                            })).then((e) {
                              refresh();
                            });
                          },
                        ) )                       .toList(),
                    )
              ],
            )),
    );
  }
}
