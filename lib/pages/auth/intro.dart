import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/db/_databaseService.dart';
import 'package:vendor_flutter/pages/auth/auth.dart';
import 'package:vendor_flutter/pages/home/home.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  DatabaseService _databaseService = DatabaseService();

  Future onLoadFromFuture() async {
    int data = await _databaseService.findUsers();
    if (data == 0) {
      return AuthPage();
    } else {
      return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return SplashScreen(
      navigateAfterFuture: onLoadFromFuture(),
      navigateAfterSeconds: AuthPage(),
      title: Text("Loading Services", style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 20.0)),
      backgroundColor: Colors.white,
      photoSize: 100.0,
      loaderColor: AppTheme.primaryColor
    );
  }
}
