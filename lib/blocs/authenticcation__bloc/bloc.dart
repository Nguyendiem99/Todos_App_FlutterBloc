import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_bloc/blocs/authenticcation__bloc/event.dart';
import 'package:todos_app_bloc/blocs/authenticcation__bloc/state.dart';
import 'package:todos_app_bloc/servies/authentication.dart';
import 'package:todos_app_bloc/servies/todos.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final AuthenticationService _auth;
  final Todo _todo;
  HomeBloc(this._auth, this._todo) : super(RegisteringServicesState()){
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(LoginStateSuccess(username: user));
      }
    });
    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      switch (result) {
        case UserCreationResult.success:
          emit(LoginStateSuccess(username: event.username));
          break;
        case UserCreationResult.failure:
          emit(HomeInitial(messgae: "There's been an error"));

          break;
        case UserCreationResult.already_exists:
          emit(HomeInitial(messgae:  "User already exists"));

          break;
      }
    });
    on<RegisterServicesEvent>((event, emit) async {
      await _auth.init();
      await _todo.init();

      emit(HomeInitial());
    });
  }
}