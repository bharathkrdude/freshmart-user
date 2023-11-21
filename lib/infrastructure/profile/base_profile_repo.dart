
import 'package:fresh_mart/domain/models/profile_model.dart';

abstract class BaseProfileRepository {
  Future<ProfileModel>  getProfileData(String email);
  Future<void> updateProfileData(String email,String profileId,ProfileModel newProfile);
}