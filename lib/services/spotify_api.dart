import 'dart:convert';
import 'package:spotify_tutorial/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_tutorial/models/music.dart';
import 'package:spotify_tutorial/services/spotify_oauth.dart';


class SpotifyAPI {

  SpotifyAPI._();

  static const String BASE_URL = "api.spotify.com";


  static Future<List<Category>> getUserTopArtists() async {
  final Uri uri = Uri.https(BASE_URL, '/v1/me/top/artists', {});
  print("uri: ${uri.toString()}");
  final accessToken = await SpotifyOauth.readAccessToken();
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );
    print(response.body);
    var artists = json.decode(response.body)['items'];

    var userTopArtists = <Category>[];
    for (var artist in artists) {
      String imageURL = artist['images'][0]['url'];
      String name = artist['name'];
      userTopArtists.add(Category(name, imageURL));
    }
    return userTopArtists;
  }
  
  static Future<List<Music>> getNewReleases() async {
  final Uri uri = Uri.https(BASE_URL, '/v1/browse/new-releases', {});
  print("uri: ${uri.toString()}");
  final accessToken = await SpotifyOauth.readAccessToken();
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );
    print(response.body);
    var albums = json.decode(response.body)["albums"]["items"];
    var newReleases = <Music>[];
    for (var release in albums) {
      String imageURL = release['images'][0]['url'];
      String name = release['name'];
      String artist = release['artists'][0]['name'];
      newReleases.add(Music(name, imageURL, artist));
    }
    
    return newReleases;
  }

}