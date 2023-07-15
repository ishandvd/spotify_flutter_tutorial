import 'package:flutter/material.dart';
import 'package:spotify_tutorial/screens/home.dart';
import 'package:spotify_tutorial/screens/search.dart';
import 'package:spotify_tutorial/screens/yourlibrary.dart';
import 'package:spotify_tutorial/models/music.dart';
import 'package:spotify_tutorial/screens/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spotify_tutorial/services/spotify_oauth.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var Tabs = [];
  int currentTabIndex = 0;

  Music? music;

  Widget miniPlayer(Music? music) {
    this.music = music;
    setState(() {});
    if(music == null){
      return SizedBox();
    }
    Size deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(duration: const Duration(milliseconds: 500),
    color: Colors.blueGrey,
    width: deviceSize.width,
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Image.network(music.image,
      fit:BoxFit.cover),
      Text(music.name, style: TextStyle(color: Colors.white, fontSize: 20),),
      IconButton(onPressed : () {}, icon: Icon(Icons.play_arrow, color: Colors.white)),
    ],));
  }

  final storage = const FlutterSecureStorage();

  

  @override
  initState() {
    super.initState();
    Tabs = [Home(miniPlayer), Search(), YourLibrary()];
  }

  // ui design code goes inside the build method
  @override
  Widget build(BuildContext context) {

    print(Uri.base.toString());
    var code = Uri.base.queryParameters['code'];

    if(code == null){
      return const Login();
    } else {
      // async function to exchange code for access token
      SpotifyOauth.getAccessToken(code);
    }

    return Scaffold(
      body: Tabs[currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(music),
          BottomNavigationBar(
            onTap: (currentIndex) {
              print("Current Index is $currentIndex");
              currentTabIndex = currentIndex;

              setState(() {});

            },
            selectedLabelStyle: TextStyle(color: Colors.white),
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black45,
            items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white), 
              label:'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books, color: Colors.white), label: 'Library'),
          ],),
        ],
      ),
    );
  }
}