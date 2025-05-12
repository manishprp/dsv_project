import '../../core/network/error.dart';
import '../../core/network/result.dart';
import '../model/user.dart';

abstract class ProfileRepository {
  Future<Result<User, AppError>> update(User user);
}
