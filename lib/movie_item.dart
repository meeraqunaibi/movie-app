import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/database_watch_list.dart';
import 'movie.dart';
import 'movie_detail.dart';
import 'package:http/http.dart' as http;

class MovieItem extends StatefulWidget {
  final Movie movie;
  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  Future<MovieDetail>? movieByID;

  Future<MovieDetail> fetchMovie(value) async {
    http.Response response = await http
        .get(Uri.parse("http://www.omdbapi.com/?t=$value&apikey=7708b4b2"));
    var jsonObject = jsonDecode(response.body);
    MovieDetail _movie;
    if (response.statusCode == 200) {
      _movie = MovieDetail.fromJson(jsonObject);
      return _movie;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isImage = false;
    if (widget.movie.image != "N/A") {
      isImage = true;
    }
    return Container(
      padding: const EdgeInsets.all(4),
      height: 120,
      child: Card(
        color: Colors.black,
        child: Row(
          children: [
            isImage
                ? SizedBox.fromSize(
                    child: Image.network(
                    widget.movie.image,
                    fit: BoxFit.fitHeight,
                    width: 90,
                  ))
                : Image.asset(
                    "assets/images/preview.jpg",
                    width: 90,
                  ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 5, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    widget.movie.year,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => {
                        movieByID = fetchMovie(widget.movie.title),
                            setState(() {})
                          },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.red,
                        size: 40,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      widget.movie.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<MovieDetail>(
                future: movieByID,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MovieDetail? movie = snapshot.data;
                    DatabaseProvider.db.insert(movie!);
                    return Text("");
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${snapshot.error}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ));
                  }
                  return Text("");
                })
          ],
        ),
      ),
    );
  }
}
