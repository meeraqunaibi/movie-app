import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/movie_detail_item.dart';
import 'movie.dart';
import 'movie_item.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController movieD = TextEditingController();
  Future<List<Movie>>? movie;
  Future<List<Movie>> fetchMovie(value) async {
    http.Response response = await http
        .get(Uri.parse("https://www.omdbapi.com/?s=$value&apikey=7708b4b2"));
    var jsonObject = jsonDecode(response.body);
    List<Movie> _movie;
    if (response.statusCode == 200) {
      var jsonArray = jsonObject["Search"] as List;
      _movie = jsonArray.map((e) => Movie.fromJson(e)).toList();
      return _movie;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: SizedBox(
            width: 450,
            child: TextField(
              cursorColor: Colors.black,
              onSubmitted: (String value) {

                movie = fetchMovie(value);
                setState(() {});
              },
              controller: movieD,
              style: const TextStyle(
                fontSize: 22,
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                hintText: "Search for movies",
                hintStyle: TextStyle(fontSize: 22),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        FutureBuilder<List<Movie>>(
            future: movie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Movie>? movies = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: movies!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MovieDetailItem(movieInput: movies[index].title)),
                          );
                        },
                        child: MovieItem(movie: movies[index]),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "No Movie Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ));
              } else {
                return Text("");
              }
            })
      ]),
    );
  }
}
