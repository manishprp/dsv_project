import 'package:dsv_project/domain/model/user.dart';

import '../../core/network/error.dart';

import '../../core/network/result.dart';
import '../repository/loginrepository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<Result<List<User>, AppError>> call(
    String email,
    String password,
  ) async {
    return await loginRepository.login(email, password);
  }
}
