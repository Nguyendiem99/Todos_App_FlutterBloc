import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class HomeInitial extends HomeState{
  final String? messgae;
  HomeInitial({this.messgae});
  @override
  // TODO: implement props
  List<Object?> get props => [messgae];
}
class LoginStateSuccess extends HomeState{
  final String username;
  LoginStateSuccess({required this.username});
  @override
  // TODO: implement props
  List<Object?> get props => [username];
}
class RegisteringServicesState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}