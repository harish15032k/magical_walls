import 'package:get/get.dart';
import 'package:magical_walls/presentation/pages/profile/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile_model.dart';

class ProfileController extends GetxController {
  ProfileRepository repo = ProfileRepository();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  var isLoading = false.obs;
  var profileData = <Data>[].obs;

  getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      ProfileRes res = await repo.getProfile(token!);
      if (res.status == true) {
        profileData.assignAll([res.data!]);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
