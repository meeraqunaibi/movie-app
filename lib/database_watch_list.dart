import 'package:movie_app/movie_detail.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static int version = 1;
  static Database? _database;
  static const String tableName = 'movies';
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'movies.db';
    return openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
          create table $tableName (
            imdbID text primary key,
            Title text,
            Released text,
            imdbRating text,
            Genre text,
            Writer text,
            Director text,
            Actors text,
            Plot text,
            Poster text,
            Type text
          )
          ''');
      },
    );
  }

  Future<List<MovieDetail>> get moviesWithDetails async {
    final db = await database;
    List<Map> result = await db!.query(tableName);
    List<MovieDetail> m = [];
    for (var value in result) {
      m.add(MovieDetail.fromMap(value));
    }
    return m;
  }

  insert(MovieDetail movie) async {
    final db = await database;
    return await db!.insert(tableName, movie.toMap());
  }

  Future<List<MovieDetail>> getMovies(String genre) async {
    if (genre == "All") {
      return moviesWithDetails;
    }
    final db = await database;
    List<Map> result = await db!.query(tableName);
    List<MovieDetail> m = [];
    for (var value in result) {
      MovieDetail movie = MovieDetail.fromMap(value);
      List<String> g = (movie.genre).split(", ");
      for (var x in g) {
        if (x == genre) {
          m.add(movie);
        }
      }
    }
    return m;
  }

  Future<List<MovieDetail>> searchMovies(String value, String standard) async {
    final db = await database;
    List<Map> result = [];

    if(standard=="Year"){
      result = await db!.query(tableName, where: 'Released=?', whereArgs: [value]);
    }
    else if(standard=="Rating"){
      result = await db!.query(tableName, where: 'imdbRating=?', whereArgs: [value]);
    }
    else if(standard=="Title"){
      result = await db!.query(tableName, where: 'Title=?', whereArgs: [value]);
    }
    else if(standard=="Genre"){
      return getMovies(value);
    }
    else{
      return [];
    }
    List<MovieDetail> m = [];
    for (var value in result) {
      MovieDetail movie = MovieDetail.fromMap(value);
      m.add(movie);
    }
    return m;
  }



  Future removeAll() async {
    final db = await database;
    return await db!.delete(tableName);
  }

}
