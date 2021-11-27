class MovieDetail {
  String title;
  String year;
  String imdbRating;
  String genre;
  String writer;
  String director;
  String actors;
  String plot;
  String image;

  MovieDetail(
      {required this.title,
      required this.year,
      required this.imdbRating,
      required this.genre,
      required this.writer,
      required this.director,
      required this.actors,
      required this.plot,
      required this.image});

  factory MovieDetail.fromJson(dynamic jsonObject) {
    return MovieDetail(
        title: jsonObject["Title"],
        year: jsonObject["Year"],
        imdbRating: jsonObject["imdbRating"],
        genre: jsonObject["Genre"],
        writer: jsonObject["Writer"],
        director: jsonObject["Director"],
        actors: jsonObject["Actors"],
        plot: jsonObject["Plot"],
        image: jsonObject["Poster"]);
  }
}
