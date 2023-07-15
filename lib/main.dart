import 'package:flutter/material.dart';
import 'package:spotify_tutorial/screens/app.dart';
import 'package:url_strategy/url_strategy.dart';



void main() {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    title: 'Spotify Tutorial',
    debugShowCheckedModeBanner: false,
    home: MyApp()));
}