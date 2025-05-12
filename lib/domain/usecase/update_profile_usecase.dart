import 'package:dsv_project/domain/repository/profile_repository.dart';

import '../../core/network/error.dart';
import '../../core/network/result.dart';
import '../model/user.dart';

class UpdateProfileUsecase {
  final ProfileRepository profileRepo;

  const UpdateProfileUsecase(this.profileRepo);

  Future<Result<User, AppError>> call(User user) async {
    return await profileRepo.update(user);
  }
}
