import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/movie_detail.dart';
import 'package:http/http.dart' as http;

class MovieDetailItem extends StatefulWidget {
  final String movieInput;
  const MovieDetailItem({ required this.movieInput});

  @override
  State<MovieDetailItem> createState() => _MovieDetailItemState();
}

class _MovieDetailItemState extends State<MovieDetailItem> {
  Future<MovieDetail>? movie;

  get movieInput => null;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    movie = fetchMovie(widget.movieInput);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: FutureBuilder<MovieDetail>(
            future: movie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MovieDetail? movieInfo = snapshot.data;
                return Column(
                  children: [
                    SizedBox.fromSize(
                        child: Image.network(
                          movieInfo!.image,
                          width: 478,
                          height: 800,
                          fit: BoxFit.fitWidth,
                        )),
                    Column(

                    )
                  ],
                );
              }
              else {
                return Text("");
              }
            })
    );
  }
}
