import 'package:get/get.dart';

class nameController extends GetxController {
  // Reactive variable for username
  var username = ''.obs;

  // Method to update the username
  void setUsername(String value) {
    username.value = value;
  }

  // Optional: Getter for username (non-reactive)
  String get currentUsername => username.value;
}
