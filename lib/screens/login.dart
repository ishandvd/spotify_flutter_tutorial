import 'package:flutter/material.dart';
import 'package:spotify_tutorial/services/spotify_oauth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    
    final uri = SpotifyOauth.createSpotifyLoginURI();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                )),
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () {
                SpotifyOauth.launchURLWrapper(uri);
              }, // take to spotify login page with redirect to home
              child: const Text("login", 
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 12),
            Text("login to Spotify to get started!", 
            style:const TextStyle(color: Colors.black, fontSize:15, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
