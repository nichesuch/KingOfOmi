import 'dart:async';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:king_of_omi/cleared.dart';
import 'package:king_of_omi/map.dart';
import 'package:king_of_omi/quest.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import 'active_provider.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({super.key, required this.title, required this.quest});
  final String title;
  final Quest quest;

  @override
  State<ActivePage> createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> {
  MapController mapController = MapController();
  bool isActive = false;
  bool canClear = false;
  double radius = 0.001;
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
      carousel.add(MapView(
          mapController: mapController,
          showMyLocation: true,
          canControl: true,
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
        title: Text(widget.title),
      ),
      body: Center(
          child: SingleChildScrollView(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 350,
                          viewportFraction: 1,
                          enableInfiniteScroll: false),
                      items: carousel,
                    ),
                    SizedBox(
                        height: 100,
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
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
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "???${widget.quest.title}???",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.black45),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 30, bottom: 30),
                        child: Text(widget.quest.description),
                      ),

                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("????????????????????????")),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.black45),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                            DateFormat.yMMMMd('ja').format(widget.quest.createdAt)),
                      ),

                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("???????????????????????????")),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.black45),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("${widget.quest.point}pt"),
                      ),

                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("????????????????????????")),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: Colors.black45),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: const Text("??????????????????????????????????????????"),
                      ),

                      const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("?????????????????????")),
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
                        ElevatedButton(
                          onPressed: canClear
                              ? () {
                            if (canClear) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return ClearedPage(
                                        title: "??????????????????", quest: widget.quest);
                                  }));
                              Provider.of<Activity>(context, listen: false).clearActive("ceMFj61EBSe3S77F7WBk", widget.quest);
                            }
                          }
                              : null,
                          child: Padding(
                              padding: EdgeInsets.all(10), child: Text("??????????????????????????????",style: TextStyle(color: Colors.white, fontSize: 18))))
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
