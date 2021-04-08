import 'package:floor/floor.dart';

@entity
class User {
  @primaryKey
  final String id;

  final String token;

  final String store;

  User(this.id, this.token, this.store);
}

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUser();

  @Query('SELECT * FROM User WHERE id = :id')
  Stream<User> findUserById(int id);

  @insert
  Future<void> insertUser(User user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUser(User user);
}