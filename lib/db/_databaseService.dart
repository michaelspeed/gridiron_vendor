import 'package:get_it/get_it.dart';
import 'package:vendor_flutter/db/entity/user.dart';

class DatabaseService {
  UserDao _userDao = GetIt.I<UserDao>();

  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() {
    return _databaseService;
  }
  DatabaseService._internal();

  Future saveLogin(User user) async {
    await _userDao.insertUser(user);
    return user;
  }

  Future updateUser(User user) async {
    await _userDao.updateUser(user);
    return;
  }

  Future<int> findUsers() async {
    List<User> allusers = await _userDao.findAllUser();
    print(allusers.length);
    return allusers.length;
  }

  Future<User> findOneUser() async {
    List<User> allusers = await _userDao.findAllUser();
    return allusers[0];
  }

  Future<String> getToken() async {
    List<User> allusers = await _userDao.findAllUser();
    if (allusers.isNotEmpty) {
      return allusers[0].token;
    } else {
      return null;
    }
  }
}