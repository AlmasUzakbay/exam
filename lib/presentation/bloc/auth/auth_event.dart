import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthenticationEvent {
  final String userEmail;
  final String userPassword;

  SignInRequested(this.userEmail, this.userPassword);

  @override
  List<Object> get props => [userEmail, userPassword];
}

class SignUpRequested extends AuthenticationEvent {
  final String userEmail;
  final String userPassword;

  SignUpRequested(this.userEmail, this.userPassword);

  @override
  List<Object> get props => [userEmail, userPassword];
}

class SignOutRequested extends AuthenticationEvent {}
