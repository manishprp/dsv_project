import 'package:dsv_project/domain/model/user.dart';

import '../../core/network/error.dart';
import '../../core/network/result.dart';

abstract class LoginRepository {
  Future<Result<List<User>, AppError>> login(String email, String password);
  Future<Result<User, AppError>> signup(User user);
}
