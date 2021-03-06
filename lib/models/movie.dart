
class Movie{
  final int id;
  final String title;
  final String overview;
  final DateTime releaseDate;
  final String imageUrl;
  final double vote;

  Movie({required this.id,required this.title,required this.overview,required this.releaseDate,required this.imageUrl,required this.vote});

  String getFullImageUrl(){
    return "http://xxxxx/${imageUrl}";
  }

  static List<Movie> moviesFromApi(Map<String,dynamic> json){
    List<Movie> l = [];

    List<dynamic> results = json["results"];

    results.forEach((element) {
      Movie movie = Movie(
        id: element["id"],
        title: element["title"],
        overview: element["overview"],
        imageUrl: element["poster_path"],
        releaseDate: DateTime.parse(element["release_date"]),
        vote: double.tryParse(element["vote_average"].toString())!
      );

      l.add(movie);
    });

    return l;
  }

}