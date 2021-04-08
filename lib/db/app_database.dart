import 'package:floor/floor.dart';
import 'package:vendor_flutter/db/entity/user.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}