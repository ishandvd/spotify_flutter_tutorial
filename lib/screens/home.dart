import 'package:flutter/material.dart';
import 'package:spotify_tutorial/models/category.dart';
import 'package:spotify_tutorial/services/category_operations.dart';
import 'package:spotify_tutorial/models/music.dart';
import 'package:spotify_tutorial/services/music_operations.dart';
import 'package:spotify_tutorial/services/spotify_api.dart';


class Home extends StatelessWidget {
  // const Home({super.key});
  Function _miniPlayer;
  Home(this._miniPlayer); // dart contstructor shorthand



  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      actions: [Padding(
        padding: EdgeInsets.only(right:10),
        child: Icon(Icons.settings))],

    );
  }

  Widget createCategory (Category category) {
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(
        children: [
          Image.network(category.imageURL, fit:BoxFit.cover),
          Padding(padding: EdgeInsets.only(left: 10),
          child: Text(category.name, style: TextStyle(color: Colors.white),)),
        ]
      ),
    );
  }

  Future<List<Widget>> createListOfCategories() async {
    List<Category> categoryList = await SpotifyAPI.getUserTopArtists();
    List<Widget> categories = categoryList.map((Category category) => createCategory(category)).toList();
    return categories;
  }


  Widget createMusic(Music music) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 130,
            width: 130,
            child: InkWell(
              onTap: (){
                _miniPlayer(music);
              },
              child: Image.network(music.image, fit: BoxFit.cover,))),
          Text(music.name, style: TextStyle(color: Colors.white),),
          Text(music.desc, style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }

  Future<Widget> createMusicList(String label) async {
    List<Music> musicList = await SpotifyAPI.getNewReleases();
    SpotifyAPI.getNewReleases();
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            height: 190,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index){
                return createMusic(musicList[index]);
              }, 
              itemCount: musicList.length,
            ),
          ),
        ],
      ),
    );
  }


  Future<Widget> createGrid() async {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 200,
        child: GridView.count(
          childAspectRatio: 10 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: await createListOfCategories(),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    SpotifyAPI.getUserTopArtists();

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueGrey.shade300, Colors.black], 
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          stops: [0.1, 0.3]),
        ),
        child: Column(
          children: [
            createAppBar('Good morning'),
            const SizedBox(height: 5,),
            FutureBuilder(
              future: createGrid(),
              initialData: CircularProgressIndicator(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return snapshot.data ?? const Text('No data');
                  } else {
                    return CircularProgressIndicator();
                  }
                }

                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder(
              future: createMusicList("Albums for you"),
              initialData: CircularProgressIndicator(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return snapshot.data ?? const Text('No data');
                  } else {
                    return CircularProgressIndicator();
                  }
                }

                return const CircularProgressIndicator();
              },
            ),
            FutureBuilder(
              future: createMusicList("Albums for you"),
              initialData: CircularProgressIndicator(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return snapshot.data ?? const Text('No data');
                  } else {
                    return CircularProgressIndicator();
                  }
                }

                return const CircularProgressIndicator();
              },
            ),
          ],),
      )
    );
  }
}