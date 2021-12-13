import 'package:flutter/material.dart';
import 'package:movie_app/database_watch_list.dart';
import 'package:movie_app/watch_list_item.dart';
import 'package:movie_app/watch_list_search_page.dart';
import 'movie_detail.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {

  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              IconButton(
                onPressed: ()=>{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> WatchListSearch()))
                } ,
                // icon: Icons.search,
                color: Colors.grey, icon: Icon(Icons.search),
              ),
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
              DatabaseProvider.db.getMovies(newValue);
              setState(() {
              });
            },
            items: ['All', 'Action', 'Adventure', 'Drama', 'Horror', 'Romance', 'Fantasy', 'Comedy', 'History', 'Sci-Fi']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(
                  width: 85,
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
      body: FutureBuilder<List<MovieDetail>>(
        future: DatabaseProvider.db.getMovies(dropdownValue),
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
    );
    // backgroundColor: Colors.black,
  }
}
