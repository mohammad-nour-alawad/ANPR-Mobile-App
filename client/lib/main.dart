import 'package:client/pages/login_screen.dart';
import 'package:flutter/material.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Syrian License Plates Recognitions DataBase';
  static const kPrimaryColor = Colors.orange;
  static const kPrimaryLightColor = Color.fromARGB(255, 247, 229, 221);
  static const double defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'RobotoMono',
            primarySwatch: Colors.orange,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              //fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        home:
            LoginScreen(), //isLoggedin ? DetectionListScreen() : LoginScreen(),
      );
}
