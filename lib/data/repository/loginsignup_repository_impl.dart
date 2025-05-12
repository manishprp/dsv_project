import '../../domain/model/user.dart';

import '../../core/network/dio_client.dart';
import '../../core/network/safecall.dart';

import '../../core/network/error.dart';

import '../../core/network/result.dart';

import '../../domain/repository/loginrepository.dart';

class LoginSignupRepositoryImpl implements LoginRepository {
  final client = DioClient();

  LoginSignupRepositoryImpl();

  @override
  Future<Result<List<User>, AppError>> login(
    String email,
    String password,
  ) async {
    return await safeCall<List<User>>(() => client.dio.get('/user'), (json) {
      var data = Users.fromJson(json).data;
      return data;
    });
  }

  @override
  Future<Result<User, AppError>> signup(User user) async {
    return await safeCall(
      () => client.dio.post('/user', data: user.toJson()),
      (json) => User.fromJson(json.first),
    );
  }
}
