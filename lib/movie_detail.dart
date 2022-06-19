class MovieDetail {
  String id;
  String title;
  String year;
  String imdbRating;
  String genre;
  String writer;
  String director;
  String actors;
  String plot;
  String image;
  String type;

  MovieDetail(
      {
      required this.id,
      required this.title,
      required this.year,
      required this.imdbRating,
      required this.genre,
      required this.writer,
      required this.director,
      required this.actors,
      required this.plot,
      required this.image,
      required this.type
      });

  factory MovieDetail.fromJson(dynamic jsonObject) {
    return MovieDetail(
        id: jsonObject["imdbID"],
        title: jsonObject["Title"],
        year: jsonObject["Year"],
        imdbRating: jsonObject["imdbRating"],
        genre: jsonObject["Genre"],
        writer: jsonObject["Writer"],
        director: jsonObject["Director"],
        actors: jsonObject["Actors"],
        plot: jsonObject["Plot"],
        image: jsonObject["Poster"],
        type: jsonObject["Type"],
    );
  }
  factory MovieDetail.fromMap(Map<dynamic, dynamic> data) {
    return MovieDetail(
      id: data["imdbID"],
      title: data["Title"],
      year: data["Released"],
      imdbRating: data["imdbRating"],
      genre: data["Genre"],
      writer: data["Writer"],
      director: data["Director"],
      actors: data["Actors"],
      plot: data["Plot"],
      image: data["Poster"],
      type: data["Type"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imdbID': id,
      'Title': title,
      'Released': year,
      'imdbRating': imdbRating,
      'Genre': genre,
      'Writer': writer,
      'Director': director,
      'Actors': actors,
      'Plot': plot,
      'Poster': image,
      'Type': type,
    };
  }
}
