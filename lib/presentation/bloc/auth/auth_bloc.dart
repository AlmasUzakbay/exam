import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_education/data/repository/firebase_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authRepository;

  AuthenticationBloc({required this.authRepository})
      : super(AuthenticationInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await authRepository.signIn(event.userEmail, event.userPassword);
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await authRepository.signUp(event.userEmail, event.userPassword);
      emit(AuthenticationSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(e.message ?? 'An unknown error occurred'));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthenticationState> emit) async {
    await authRepository.signOut();
    emit(AuthenticationSignedOut());
  }
}
