import 'package:get/get.dart';

import '../screens/buddies_screen.dart';
import '../screens/discover_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = const [
    BuddiesScreen(),
    DiscoverScreen(),
    SettingsScreen(),
    ProfileScreen()
  ];
}
