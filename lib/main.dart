import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:king_of_omi/point.dart';
import 'package:king_of_omi/ranking.dart';

import 'edit.dart';
import 'home.dart';
import 'list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('ja_JP');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const MaterialColor customSwatch = MaterialColor(
    0xFFF2A93C,
    <int, Color>{
      50: const Color(0xFFffffff),
      100: const Color(0xFFfff5ec),
      200: const Color(0xFFffebd5),
      300: const Color(0xFFffddb5),
      400: const Color(0xFFffcf93),
      500: const Color(0xFFffc16c),
      600: const Color(0xFFF2A93C),
      700: const Color(0xFFeaa235),
      800: const Color(0xFFde982b),
      900: const Color(0xFFd18d20),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          textTheme: GoogleFonts.sawarabiGothicTextTheme(),
          primarySwatch: customSwatch,
          scaffoldBackgroundColor: Colors.orange[50],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, this.selectedIndex = 0});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int selectedIndex;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Function()? onPressed = (){};

  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const HomePage(title: "キングオブ小見"),
    ListPage(title: "クエスト一覧"),
    RankingPage(title: "ランキング"),
    PointPage(title: "アカウント"),
    EditPage(title: "クエスト登録"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _determinePosition();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const EditPage(title: "クエスト登録");
            })).then((e) {
//              refresh();
            });
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            shape: const AutomaticNotchedShape(
              RoundedRectangleBorder(),
              StadiumBorder(
                side: BorderSide(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: _selectedIndex == 0 ? Theme.of(context).colorScheme.primary : Colors.black45,
                    ),
                    onPressed: () {
                      _onItemTapped(0);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.list,
                      color: _selectedIndex == 1 ? Theme.of(context).colorScheme.primary : Colors.black45,
                    ),
                    onPressed: () {
                      _onItemTapped(1);
                    },
                  ),
                  Container(height: 30,width: 50,),
                  IconButton(
                    icon: Icon(
                      Icons.workspace_premium,
                      color: _selectedIndex == 2 ? Theme.of(context).colorScheme.primary : Colors.black45,
                    ),
                    onPressed: () {
                      _onItemTapped(2);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: _selectedIndex == 3 ? Theme.of(context).colorScheme.primary : Colors.black45,
                    ),
                    onPressed: () {
                      _onItemTapped(3);
                    },
                  ),
                ],
              ),
            ))

        // BottomNavigationBar(
        //   currentIndex: _selectedIndex,
        //   onTap: _onItemTapped,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
        //     BottomNavigationBarItem(icon: Icon(Icons.list), label: '一覧'),
        //     BottomNavigationBarItem(icon: Icon(Icons.add), label: '追加'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.star), label: 'ランキング'),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
        //   ],
        //   type: BottomNavigationBarType.fixed,
        //
        // )
        ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
