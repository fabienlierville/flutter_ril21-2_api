import 'package:api/api/api_movie.dart';
import 'package:api/models/movie.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Films du moment"),
        actions: [
          IconButton(
              onPressed: getPupularsMovies,
              icon: Icon(Icons.refresh)
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

  Future<void> getPupularsMovies() async{
      ApiMovie api = ApiMovie();
      //Todo écran d'attente
      //Faire un setState qui demande l'affichage d'un Widget "Patientez ..."
      Map<String,dynamic> json = await api.getPopular();
      if(json["code"] == 200){
        List<Movie> movies = Movie.moviesFromApi(json);
        movies.forEach((Movie movie) {
          print(movie.title);
        });
      }else{
        //Todo écran d'erreur
        //Faire un setState qui demande l'affichage d'un Widget "Error"
      }
  }


}
