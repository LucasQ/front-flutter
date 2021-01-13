import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterApp/components/bottomNavBar.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashWidget(title: 'Splash Screen');
  }
}

class SplashWidget extends StatefulWidget {
  SplashWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xffAF1426), Color(0xff93291E)],
        ),
        navigateAfterSeconds: BottomNavBar(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.none,
          ),
        ),
      ),
    ],
  );
}
