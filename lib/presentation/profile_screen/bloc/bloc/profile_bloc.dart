import 'package:bloc/bloc.dart';
import '../../../../core/network/result.dart';
import '../../../../data/repository/profile_repo_impl.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/model/user.dart';
import '../../../../domain/usecase/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUsecase updateUseCase = UpdateProfileUsecase(
    ProfileRepositoryImpl(),
  );
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateEvent>(handleUpdateEvent);
  }

  handleUpdateEvent(UpdateEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    var result = await updateUseCase.call(event.user);
    if (result is Success) {
      var data = (result as Success).data;
      emit(ProfileSuccess(data));
    } else {
      emit(ProfileFailure("Something went wrong"));
    }
  }
}
