import 'dart:convert';
import 'package:pkce/pkce.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class SpotifyOauth {
  SpotifyOauth._();
  static const storage = FlutterSecureStorage();
  static const clientID = '1f2e700f628c496794f85553f565aab3';
  static const scope = 'user-read-private user-read-email user-top-read';

  static void writeToSecureStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  static void readCodeVerifier() async {
    var codeVerifierRead = await storage.read(key: 'codeVerifier');
    print(codeVerifierRead);
  }

  static Future<String> readAccessToken() async {
    var accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw 'Access token not found';
    }
    return accessToken;
  }

  static void launchURLWrapper(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  static Uri createSpotifyLoginURI() {
    var pkcePair = PkcePair.generate();
    var codeVerifier = pkcePair.codeVerifier;
    var codeChallenge = pkcePair.codeChallenge;

    writeToSecureStorage("code_verifier" , codeVerifier);
    readCodeVerifier();
    final Uri uri = Uri.https(
      'accounts.spotify.com',
      'authorize',
      {
        'client_id': clientID,
        'response_type': 'code',
        'redirect_uri': 'http://localhost:5555',
        'code_challenge_method': 'S256',
        'code_challenge': codeChallenge.toString(),
        'scope': scope
      },
    );

    return uri;
  }


  static void getAccessToken(String code) async {
    var codeVerifier = await storage.read(key: 'code_verifier');
    final Uri uri = Uri.https(
      'accounts.spotify.com',
      'api/token',
      {
        'client_id': '1f2e700f628c496794f85553f565aab3',
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'http://localhost:5555',
        'code_verifier': codeVerifier,
      },
    );

    final response = await http.post(uri,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    print("Access Token: ${json.decode(response.body)["access_token"]}");
    writeToSecureStorage("access_token", json.decode(response.body)["access_token"]);



  }
}