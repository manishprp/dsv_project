part of 'loginsignup_bloc.dart';

sealed class LoginsignupEvent extends Equatable {
  const LoginsignupEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends LoginsignupEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class SignupEvent extends LoginsignupEvent {
  final User user;
  const SignupEvent({required this.user});

  @override
  List<Object> get props => [user];
}
