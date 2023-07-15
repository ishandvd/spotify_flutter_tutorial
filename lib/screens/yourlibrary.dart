import 'package:flutter/material.dart';


class YourLibrary extends StatelessWidget {
  const YourLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SafeArea(child: Text('Your Library', style: TextStyle(fontSize: 30, color: Colors.white)));
  }
}