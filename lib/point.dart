import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:king_of_omi/detail.dart';
import 'package:king_of_omi/quest.dart';
import 'package:king_of_omi/rank.dart';

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

  Rank? rank;

  @override
  void initState() {
    FirebaseFirestore.instance.collection("points").doc("ceMFj61EBSe3S77F7WBk").get().then((data) {
      setState(() {
        rank = Rank().fromMap(data.id, data.data()!);
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
        body: Column(
            children:[
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                child: Padding(padding:EdgeInsets.all(10), child: const Icon(Icons.person_outlined, size: 60,)),
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
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.black26),
                    bottom: BorderSide(width: 1.0, color: Colors.black26),
                  ),
                ),
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(30),
                child: Text(rank?.name ?? "", style: Theme.of(context).textTheme.headlineMedium,),
              ),
              Padding(padding: EdgeInsets.only(right: 20, left: 20),
              child: Card(
                shape: RoundedRectangleBorder(
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
                                  "${rank?.point}",
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
                  ],
                ),
              )),
    Padding(padding: EdgeInsets.only(right: 20, left: 20),
    child:

              Row(
                children: [
                  Expanded(
                    child:               Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(children: [
                        Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 50,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text("達成数 "),
                              Text("${rank?.done}")
                            ])
                      ],),
                    ),
                  ),
                  Expanded(
                    child:               Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Column(children: [
                        Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 50,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              Text("ランキング "),
                              Text("${rank?.ranking}"),
                              Text("位"),
                            ])
                      ],),
                    ),
                  )

    ],))
            ]
        ),
    );
  }
}
