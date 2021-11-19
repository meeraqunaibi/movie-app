import 'package:flutter/material.dart';
import 'package:movie_app/main_page.dart';

void main() {
  // HttpOverrides.global = MyHttpOverrides();
  runApp(const MovieApp());
}
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MainPage(),
    );
  }
}


