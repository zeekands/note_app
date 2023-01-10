import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app/app/const/colors.dart';
import 'package:note_app/app/const/text_style.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  const EditNoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 6),
          child: Container(
            decoration: BoxDecoration(
              color: secondaryBlack,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 16,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: secondaryBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () => controller.deleteNote(),
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 8, bottom: 8, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: secondaryBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () => controller.pickFile(),
                icon: const Icon(
                  Icons.attach_file_outlined,
                  size: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: secondaryBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  controller.updateNotes();
                },
                icon: const Icon(
                  Icons.save,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: secondaryBlack,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Tandai Sebagai Pengingat",
                          style: white12,
                        ),
                        Obx(() {
                          return Switch.adaptive(
                            value: controller.isReminder.value,
                            onChanged: (value) => controller.isReminder(value),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.isReminder.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Waktu Pengingat",
                              style: white12,
                            ),
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              style: white12,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              cursorColor: Colors.white,
                              initialValue: controller.timeController.text,
                              initialDate: DateTime(
                                int.parse(controller.year),
                                int.parse(controller.month),
                                int.parse(controller.day),
                              ),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: const Icon(Icons.event),
                              dateLabelText: 'Date',
                              timeLabelText: "Hour",
                              selectableDayPredicate: (date) {
                                return true;
                              },
                              onChanged: (val) =>
                                  controller.timeController.text = val,
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: "Interval Pengingat",
                                labelStyle: white12,
                              ),
                              dropdownColor: secondaryBlack,
                              style: white12,
                              value: controller.selectedInterval.value,
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedInterval.value = newValue;
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Pendidikan tidak boleh kosong, silakan isi pendidikan anda';
                                }
                                return null;
                              },
                              items: controller.listInterval,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Picked File",
                    style: white12,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () {
                      if (controller.pickedFile.value.path != "") {
                        if (controller.pickedFile.value.path.contains(".jpg") ||
                            controller.pickedFile.value.path.contains(".png") ||
                            controller.pickedFile.value.path
                                .contains(".jpeg")) {
                          return Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(controller.pickedFile.value.path),
                                height: 150,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Text(
                          controller.pickedFile.value.path,
                          style: white12,
                        );
                      }
                      return Text(
                        controller.pickedFile.value.path,
                        style: white12,
                      );
                    },
                  ),
                  TextFormField(
                    controller: controller.titleController,
                    style: grey24,
                    decoration: const InputDecoration(
                      hintText: "Judul",
                      hintStyle: grey24,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    maxLines: 20,
                    style: grey12,
                    decoration: const InputDecoration(
                      hintText: "Catatan",
                      hintStyle: grey12,
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
