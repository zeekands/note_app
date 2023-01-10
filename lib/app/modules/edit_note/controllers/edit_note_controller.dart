import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/app/data/notes_model.dart';
import 'package:note_app/app/utils/db_helper.dart';

class EditNoteController extends GetxController {
  final notesData = Get.arguments as NotesModel;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final fileController = TextEditingController();
  final intervalController = TextEditingController();
  final isReminder = false.obs;
  final selectedInterval = 0.obs;
  final pickedFile = File("").obs;
  var year = "";
  var month = "";
  var day = "";

  DBHelper db = DBHelper();

  final List<DropdownMenuItem> listInterval = [
    const DropdownMenuItem(
      value: 0,
      child: Text("Tidak ada"),
    ),
    const DropdownMenuItem(
      value: 24,
      child: Text("1 Hari Sebelum"),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text("3 Jam Sebelum"),
    ),
    const DropdownMenuItem(
      value: 1,
      child: Text("1 Jam Sebelum"),
    ),
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    timeController.text = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
    isReminder.value = notesData.isReminder == "0" ? false : true;
    selectedInterval.value = int.parse(notesData.interval ?? "0");
    titleController.text = notesData.title ?? "";
    descriptionController.text = notesData.description ?? "";
    timeController.text = notesData.time ?? "";
    pickedFile.value = File(notesData.file ?? "");
    year = notesData.time.toString().split("-")[0];
    month = notesData.time.toString().split("-")[1];
    day = notesData.time.toString().split("-")[2].split(" ")[0];
  }

  void updateNotes() async {
    await db
        .updateNotes(
      NotesModel.fromJson(
        {
          "id": notesData.id,
          "title": titleController.text,
          "description": descriptionController.text,
          "time": timeController.text,
          "file": pickedFile.value.path,
          "interval": selectedInterval.toString(),
          "isReminder": isReminder.value ? "1" : "0",
        },
      ),
    )
        .then(
      (value) {
        Get.back();

        Get.snackbar(
          "Success",
          "Note has been updated",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
        );
      },
    );
  }

  Future<void> deleteNote() {
    return db.deleteNotes(int.parse(notesData.id.toString())).then((value) {
      Get.back();

      Get.snackbar(
        "Success",
        "Delete note success",
        icon: const Icon(
          Icons.delete_outline_outlined,
          color: Colors.white,
        ),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? selectedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "png", "jpeg", "jpg"],
    );
    if (selectedFile != null) {
      pickedFile.value = File(selectedFile.files.single.path!);
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
}
