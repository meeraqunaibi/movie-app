import 'package:flutter/material.dart';
import 'package:movie_app/database_watch_list.dart';
import 'package:movie_app/movie_detail.dart';
import 'package:movie_app/watch_list_item.dart';

class WatchListSearch extends StatefulWidget {
  const WatchListSearch({Key? key}) : super(key: key);

  @override
  _WatchListSearchState createState() => _WatchListSearchState();
}

class _WatchListSearchState extends State<WatchListSearch> {
  @override
  String dropdownValue = 'Search by';
  TextEditingController target = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("My Watch List",
              style: TextStyle(
                fontFamily: 'IM Fell English SC',
                color: Colors.red,
                fontSize: 35.0,
              )),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              dropdownValue = newValue!;
              setState(() {
              });
            },
            items: ['Search by', 'Year', 'Title', 'Rating', "Genre"]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    value,
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              );
            }).toList(),
          ),
        ]),
      ),
      backgroundColor: Colors.black,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: SizedBox(
            width: 450,
            child: TextField(
              cursorColor: Colors.black,
              controller: target,
              onSubmitted: (String value) {
                DatabaseProvider.db.searchMovies(target.text, dropdownValue);
                setState(() {});
              },
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
                hintText: "Search for movie",
                hintStyle: TextStyle(fontSize: 22),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<MovieDetail>>(
            future: DatabaseProvider.db.searchMovies(target.text, dropdownValue),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MovieDetail>? movie = snapshot.data;
                return Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: movie!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return WatchListItem(movie: movie[index]);
                          })),
                ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Text("data");
            },
          ),
        ),
      ]),
    );
  }
}
