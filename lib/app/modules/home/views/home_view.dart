import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:note_app/app/const/colors.dart';
import 'package:note_app/app/const/text_style.dart';
import 'package:note_app/app/data/notes_model.dart';
import 'package:note_app/app/routes/app_pages.dart';
import 'package:note_app/main.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: mainBlack,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Get.toNamed(Routes.ADD_NOTE);
              if (result == null) {
                controller.onInit();
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADMIN);
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Obx(
        () => controller.listNotes.isNotEmpty
            ? ListView.builder(
                itemCount: controller.listNotes.length,
                itemBuilder: (context, index) {
                  NotesModel notes = controller.listNotes[index];
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      controller.deleteNote(notes.id!).then((value) {
                        Get.snackbar(
                          "Deleted",
                          "Note has been deleted",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(10),
                        );
                        controller.getAllNotes();
                      });
                    },
                    child: Card(
                      color: randomColor[Random().nextInt(10000) % 5],
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.0),
                        onTap: () async {
                          var result = await Get.toNamed(Routes.EDIT_NOTE,
                              arguments: notes);
                          if (result == null) {
                            controller.onInit();
                          }
                        },
                        onLongPress: () {},
                        child: Container(
                          height: 200,
                          width: 300,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible:
                                    controller.listNotes[index].title != '',
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    controller.listNotes[index].title
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    controller.listNotes[index].description
                                        .toString(),
                                    maxLines: 6,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.notifications_active_outlined,
                                      size: 12,
                                    ),
                                    Expanded(
                                        child: Text(
                                      " " +
                                          controller.listNotes[index].interval
                                              .toString() +
                                          " Hour(s) before",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: black10,
                                    )),
                                    if (controller.listNotes[index].file != "")
                                      const Icon(
                                        Icons.attach_file,
                                        size: 12,
                                      ),
                                    Text(
                                      controller.listNotes[index].time
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 10, vertical: 5),
                  );
                },
              )
            : Container(
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/notes2.png",
                      width: width * 0.7,
                    ),
                    Text(
                      "Your note is empty\n Let's Create Some",
                      style: white24,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
