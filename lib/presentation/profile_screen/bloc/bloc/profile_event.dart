part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class UpdateEvent extends ProfileEvent {
  final User user;
  const UpdateEvent(this.user);

  @override
  List<Object> get props => [user];
}
