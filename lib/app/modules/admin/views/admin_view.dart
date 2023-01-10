import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app/app/const/colors.dart';
import 'package:note_app/app/const/text_style.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  const AdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        children: [
          GestureDetector(
            onTap: () {
              controller.pickFile();
            },
            child: Obx(
              () => controller.profilePicture.value == ""
                  ? const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.camera_alt_outlined),
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          FileImage(File(controller.profilePicture.value)),
                    ),
            ),
          ),
          const Text(
            "First name",
            style: white12,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              height: height,
              width: width,
              controller: controller.firstNameController),
          const SizedBox(height: 10),
          const Text(
            "Last name",
            style: white12,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              height: height,
              width: width,
              controller: controller.lastNameController),
          const SizedBox(height: 10),
          const Text(
            "Email",
            style: white12,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              height: height,
              width: width,
              controller: controller.emailController),
          const SizedBox(height: 10),
          const Text(
            "Password",
            style: white12,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              height: height,
              width: width,
              controller: controller.passwordController),
          const SizedBox(height: 10),
          const Text(
            "Date of birth",
            style: white12,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              height: height,
              width: width,
              controller: controller.dateOfBirthController),
          const SizedBox(height: 10),
          const Text(
            "Gender",
            style: white12,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              height: height,
              width: width,
              controller: controller.genderController),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: secondaryBlack,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              controller.saveAdmin();
            },
            child: const Text("Save Changes"),
          ),
        ],
      )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
  }) : super(key: key);

  final double height;
  final double width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06,
      width: width,
      decoration: BoxDecoration(
        color: secondaryBlack,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        style: white12,
        controller: controller,
        decoration: const InputDecoration(
            hintText: 'First Name',
            border: InputBorder.none,
            hintStyle: white12),
      ),
    );
  }
}
