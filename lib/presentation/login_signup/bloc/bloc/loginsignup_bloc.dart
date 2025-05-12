import 'package:bloc/bloc.dart';
import 'package:dsv_project/core/local/store_user.dart';
import '../../../../core/network/result.dart';
import '../../../../data/repository/loginsignup_repository_impl.dart';
import '../../../../domain/usecase/signup_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/network_error.dart';
import '../../../../domain/model/user.dart';
import '../../../../domain/usecase/loginusecase.dart';

part 'loginsignup_event.dart';
part 'loginsignup_state.dart';

class LoginsignupBloc extends Bloc<LoginsignupEvent, LoginsignupState> {
  final LoginUseCase loginUseCase = LoginUseCase(LoginSignupRepositoryImpl());
  late final SignupUsecase signupUseCase;

  LoginsignupBloc() : super(LoginsignupInitial()) {
    on<LoginEvent>(loginEventHandler);
    on<SignupEvent>(signupEventHandler);
  }

  loginEventHandler(LoginEvent event, Emitter<LoginsignupState> emit) async {
    emit(LoginsignupLoading());
    // fetching user and then checking ours (we are just mimicking the login)
    var usersList = await loginUseCase.call(event.email, event.password);
    usersList.onSuccess((data) {
      var ourUser =
          data.where((element) {
            return element.email == event.email &&
                element.password == event.password;
          }).toList();

      if (ourUser.isNotEmpty &&
          (ourUser.first.email != null && ourUser.first.password != null)) {
        StoreRetrieve.store(ourUser.first);
        emit(LoginsignupSuccess(user: ourUser.first));
      } else {
        emit(LoginsignupFailure(errorMessage: "User not registered"));
      }
    });
    if (usersList is Failure) {
      var errorType = usersList as Failure;
      if (errorType is NetworkError) {
        emit(LoginsignupFailure(errorMessage: "Network error"));
      } else {
        emit(LoginsignupFailure(errorMessage: "Unknown error"));
      }
    }
  }

  signupEventHandler(SignupEvent event, Emitter<LoginsignupState> emit) async {
    signupUseCase = SignupUsecase(
      LoginSignupRepositoryImpl(),
      user: event.user,
    );

    emit(LoginsignupLoading());
    // fetching user and then checking ours (we are just mimicking the login)
    var result = await signupUseCase!.call();
    if (result is Success) {
      var user = (result as Success).data as User;
      StoreRetrieve.store(user);
      emit(LoginsignupSuccess(user: user));
    } else {
      if (result is NetworkError) {
        emit(LoginsignupFailure(errorMessage: "Network error"));
      } else {
        emit(LoginsignupFailure(errorMessage: "Unknown error"));
      }
    }
  }
}
