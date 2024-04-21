import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationSignedOut extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
