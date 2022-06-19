import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/movie_detail.dart';
import 'package:http/http.dart' as http;

class MovieDetailItem extends StatefulWidget {
  final String movieInput;
  const MovieDetailItem({Key? key, required this.movieInput}) : super(key: key);

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
    //80% of screen width
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<MovieDetail>(
            future: movie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                MovieDetail? movieInfo = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox.fromSize(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11.0),
                            child: Image.network(
                              movieInfo!.image,
                              width: 478,
                              height: 550,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )),
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: cWidth,
                                    child: Text(
                                      movieInfo.title.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: cWidth,
                                    child: Text(
                                      movieInfo.genre,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11.0),
                                      child: Text(
                                          "Released year: " + movieInfo.year,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0)),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: VerticalDivider(
                                        width: 20,
                                        thickness: 2,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11.0),
                                      child: Text(movieInfo.imdbRating,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.0)),
                                    ),
                                  ],
                                ),
                              ),
                              //divider
                              const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Divider(
                                  height: 50,
                                  thickness: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              //end of divider
                              const SectionTitle("PLOT"),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 11.0),
                                    child: SizedBox(
                                      width: cWidth,
                                      child: TextButton(
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const SectionTitle("PLOT"),
                                            content: Text(movieInfo.plot, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'OK'),
                                                child: const Text('OK' ,style: TextStyle(color: Colors.black),),
                                              ),
                                            ],
                                          ),
                                        ),
                                        child: Text(movieInfo.plot,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                height: 1.7,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0)),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                              const SectionTitle("CAST"),
                              SectionDetails(cWidth: cWidth, movieInfo: movieInfo.actors),
                              const SectionTitle("DIRECTOR"),
                              SectionDetails(cWidth: cWidth, movieInfo: movieInfo.director),
                              const SectionTitle("WRITER"),
                              SectionDetails(cWidth: cWidth, movieInfo: movieInfo.writer),
                              const SectionTitle("GENRE"),
                              SectionDetails(cWidth: cWidth, movieInfo: movieInfo.genre),
                            ]))
                      ],
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

class SectionDetails extends StatelessWidget {
  const SectionDetails({
    Key? key,
    required this.cWidth,
    required this.movieInfo,
  }) : super(key: key);

  final double cWidth;
  final String? movieInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 11.0),
          child: SizedBox(
            width: cWidth,
            child: Text(movieInfo!,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.white70,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0)),
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
