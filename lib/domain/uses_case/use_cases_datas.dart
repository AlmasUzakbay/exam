import 'package:flutter_education/data/repository/firebase_repository.dart';

class SignInUseCase {
  final AuthenticationRepository repository;

  SignInUseCase(this.repository);

  Future<void> call(String email, String password) async {
    await repository.signIn(email, password);
  }
}

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(String email, String password) async {
    await repository.signUp(email, password);
  }
}

class SignOutUseCase {
  final AuthenticationRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    await repository.signOut();
  }
}
