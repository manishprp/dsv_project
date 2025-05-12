import '../../core/network/error.dart';
import '../../core/network/result.dart';
import '../model/user.dart';
import '../repository/loginrepository.dart';

class SignupUsecase {
  final User user;
  final LoginRepository loginRepository;

  SignupUsecase(this.loginRepository, {required this.user});

  Future<Result<User, AppError>> call() async {
    return await loginRepository.signup(user);
  }
}
