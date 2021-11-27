import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'movie.dart';

class MovieItem extends StatelessWidget {
  Movie movie;
  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    bool isImage = false;
    if (movie.image != "N/A") {
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
                    movie.image,
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
                    movie.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    movie.year,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.type,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
