import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:note_app/app/data/admin_model.dart';
import 'package:note_app/app/routes/app_pages.dart';

class AdminController extends GetxController {
  //TODO: Implement AdminController
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final profilePicture = "".obs;

  final LocalStorage storage = LocalStorage('admin.json');
  final pickedFile = File("").obs;

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await storage.ready.then(
      (value) {
        final admin = AdminModel.fromJson(storage.getItem('admin'));
        print(admin.profilePicture);
        firstNameController.text = admin.firstName.toString();
        lastNameController.text = admin.lastName.toString();
        emailController.text = admin.email.toString();
        passwordController.text = admin.password.toString();
        dateOfBirthController.text = admin.dateOfBirth.toString();
        genderController.text = admin.gender.toString();
        profilePicture.value = admin.profilePicture.toString();
        print(profilePicture.value);
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pickFile() async {
    FilePickerResult? selectedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["png", "jpeg", "jpg"],
    );
    if (selectedFile != null) {
      pickedFile.value = File(selectedFile.files.single.path!);
      profilePicture.value = pickedFile.value.path;
    } else {
      Get.snackbar(
        "No file picked",
        "There is no file picked",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    }
  }

  void saveAdmin() {
    storage.setItem(
        'admin',
        AdminModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          dateOfBirth: dateOfBirthController.text,
          profilePicture: profilePicture.value,
          gender: genderController.text,
          isLogin: true,
        ).toJson());
    Get.back();
    Get.snackbar(
      "Success",
      "Admin has been edited",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  void logout() {
    storage.setItem(
      'admin',
      AdminModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        dateOfBirth: dateOfBirthController.text,
        profilePicture: profilePicture.value,
        gender: genderController.text,
        isLogin: false,
      ).toJson(),
    );
    Get.offAllNamed(Routes.LOGIN);
  }
}
