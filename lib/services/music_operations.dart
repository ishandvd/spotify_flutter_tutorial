import 'package:spotify_tutorial/models/music.dart';


class MusicOperations {
  MusicOperations._() {}

  static List<Music> getMusic() {
    return <Music>[
      Music('Stairway to Heaven', 
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlcmuSHPsYA7RR3nVbOADFjAg1-ZnV6g03hg&usqp=CAU',
      'The best song in the world',
      ),
      Music('Stairway to Heaven', 
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlcmuSHPsYA7RR3nVbOADFjAg1-ZnV6g03hg&usqp=CAU',
      'The best song in the world'),
      Music('Stairway to Heaven', 
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlcmuSHPsYA7RR3nVbOADFjAg1-ZnV6g03hg&usqp=CAU',
      'The best song in the world'),
      Music('Stairway to Heaven', 
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlcmuSHPsYA7RR3nVbOADFjAg1-ZnV6g03hg&usqp=CAU',
      'The best song in the world'),
    ];
  }
  
}