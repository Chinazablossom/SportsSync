
import 'package:get/get.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';
import 'package:sports_sync/repository/user_repo/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  /// GET USER EMAIL TO PASS TO USER REPO TO FETCH USER DATA
  getUserDate(){

    final email = _authRepo.sportSyncUser?.email;
    
    if(email != null){
     return _userRepo.getUserDetails(email);
    }else{
      Get.snackbar("Error", "Login to continue");
    }
    
  }

}