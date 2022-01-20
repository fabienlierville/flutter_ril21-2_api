import 'package:api/api/api_movie.dart';
import 'package:api/models/movie.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  List<Movie> movies = [];
  StatusApi statusApi = StatusApi.chargement;

  @override
  void initState() {
    getPupularsMovies();
    super.initState();
  }

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
      body: bodyNamic(),
    );
  }

  Widget bodyNamic(){
    if(statusApi==StatusApi.chargement){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(statusApi==StatusApi.ok){
      //Todo : Liste des filmes (Listview.Builder ...)
      return Center();
    }

    return Center(
      child: Text("Error"),
    );

  }

  Future<void> getPupularsMovies() async{
      ApiMovie api = ApiMovie();
      setState(() {
        statusApi = StatusApi.chargement;
      });
      await Future.delayed(Duration(seconds: 3));
      //Faire un setState qui demande l'affichage d'un Widget "Patientez ..."
      Map<String,dynamic> json = await api.getPopular();
      if(json["code"] == 200){
        List<Movie> moviesApi = Movie.moviesFromApi(json["body"]);
        setState(() {
          movies = moviesApi;
          statusApi = StatusApi.ok;
        });
        movies.forEach((Movie movie) {
          print(movie.title);
        });
      }else{
        setState(() {
          statusApi = StatusApi.error;
        });
      }
  }


}

enum StatusApi {
  chargement,
  error,
  ok
}