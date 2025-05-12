import 'package:dsv_project/core/network/safecall.dart';

import '../../core/network/error.dart';
import '../../core/network/result.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/profile_repository.dart';

import '../../core/network/dio_client.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final client = DioClient();

  @override
  Future<Result<User, AppError>> update(User user) async {
    return await safeCall(
      () => client.dio.put('/user/${user.id}', data: user.toJson()),
      (json) => User.fromJson(json.first),
    );
  }
}
