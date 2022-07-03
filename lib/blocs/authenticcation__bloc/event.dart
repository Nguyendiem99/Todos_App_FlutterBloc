import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginEvent extends HomeEvent{
  final String username;
  final String password;
  LoginEvent({required this.username,required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [username,password];
}
class RegisterServicesEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterAccountEvent extends HomeEvent {
  final String username;
  final String password;

  RegisterAccountEvent(this.username, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}