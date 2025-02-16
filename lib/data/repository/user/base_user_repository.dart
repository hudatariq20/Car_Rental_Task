
import 'package:auth_weather_api/data/models/user_model.dart';

abstract class BaseUserRepository {
  //getUser
  Stream<User> getUser(String userId);
  //createUser
  Future<void> createUser(User user);
  //updateUser
  Future<void> updateUser(User user);
}
