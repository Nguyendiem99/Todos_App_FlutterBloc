import 'package:hive/hive.dart';
import 'package:todos_app_bloc/models/user.dart';

class AuthenticationService {
  late Box<User> _users;
  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox<User>('usersBox');
  }
  Future<String?> authenticateUser(final String username,final String password) async {
    final success =await _users.values.any((element) => element.username==username && element.password==password);
    if(success){
      return username;
    }else{
      return null;
    }
  }
  Future<UserCreationResult> createUser(final String username,final String password) async{
    final alreadyExists = await _users.values.any((element) => element.username.toLowerCase() == username.toLowerCase());
    if(alreadyExists){
      return UserCreationResult.already_exists;
    }
    try{
      _users.add(User(username, password));
      return UserCreationResult.success;
    }catch(e){
      return UserCreationResult.failure;
    }
  }
}
enum UserCreationResult { success, failure, already_exists }