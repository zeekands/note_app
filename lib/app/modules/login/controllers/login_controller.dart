import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:note_app/app/data/admin_model.dart';

class LoginController extends GetxController {
  final LocalStorage storage = LocalStorage('admin.json');
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await storage.ready.then((value) {
      if (storage.getItem('admin') == null) {
        onCreateAdmin();
        print("created");
      } else {
        final admin = AdminModel.fromJson(storage.getItem('admin'));
        print(admin.email);
      }
    });
  }

  void onLogin(String email, String password) {
    final admin = AdminModel.fromJson(storage.getItem('admin'));
    if (admin.email == email && admin.password == password) {
      final adminData = AdminModel(
        id: 1,
        firstName: "Super",
        lastName: "Admin",
        email: "admin@gmail.com",
        dateOfBirth: "2000-03-10",
        gender: "Laki - Laki",
        password: "Admin",
        profilePicture: "",
        isLogin: true,
      );
      storage.setItem('admin', adminData.toJson());
      Get.offNamed('/home');
    } else {
      Get.snackbar("Error", "Email atau Password Salah");
    }
  }

  void onCreateAdmin() {
    final adminData = AdminModel(
      id: 1,
      firstName: "Super",
      lastName: "Admin",
      email: "admin@gmail.com",
      dateOfBirth: "2000-03-10",
      gender: "Laki - Laki",
      password: "Admin",
      profilePicture: "",
      isLogin: false,
    );
    storage.setItem('admin', adminData.toJson());
  }
}
