part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String errorMessage;
  const ProfileFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];

  ProfileFailure copyWith(String? errorMessage) {
    return ProfileFailure(errorMessage = errorMessage ?? this.errorMessage);
  }
}

final class ProfileSuccess extends ProfileState {
  final User user;
  const ProfileSuccess(this.user);

  @override
  List<Object> get props => [user];

  ProfileSuccess copyWith(User? user) {
    return ProfileSuccess(user = user ?? this.user);
  }
}
