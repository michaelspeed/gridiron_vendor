import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vendor_flutter/app_theme.dart';
import 'package:vendor_flutter/db/app_database.dart';
import 'package:vendor_flutter/db/entity/user.dart';
import 'package:vendor_flutter/pages/auth/auth.dart';
import 'package:vendor_flutter/pages/auth/intro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder('gridiron.db').build();
  final userDao = db.userDao;
  GetIt.I.allowReassignment = true;
  GetIt.I.registerLazySingleton<UserDao>(() => userDao);
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridIron Vendor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.deepPurple,
          textTheme: AppTheme.textTheme,
          accentColor: AppTheme.grey
      ),
      routes: {
        '/': (context) => Intro(),
      },
    );
  }
}