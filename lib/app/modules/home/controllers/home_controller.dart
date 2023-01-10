import 'dart:math';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/app/data/notes_model.dart';
import 'package:note_app/app/utils/db_helper.dart';
import 'package:note_app/app/utils/notification_api.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final listNotes = <NotesModel>[].obs;
  DBHelper db = DBHelper();

  final cron = Cron();

  @override
  void onInit() async {
    super.onInit();
    await getAllNotes();
    cron.schedule(Schedule.parse(' * * * * *'), () async {
      listNotes.forEach((note) {
        setAlert(note);
      });
    });
  }

  Future<void> getAllNotes() async {
    var list = await db.getAllNotes();
    listNotes.clear();
    list!.forEach((notes) {
      listNotes.add(NotesModel.fromJson(notes));
    });
  }

  void setAlert(NotesModel note) {
    final now = DateTime.now();
    final nowFormat = DateFormat('yyyy-MM-dd HH:mm').format(now);

    final year = int.parse(note.time!.split("-")[0]);
    final month = int.parse(note.time!.split("-")[1]);
    final day = int.parse(note.time!.split("-")[2].split(" ")[0]);
    final hour = int.parse(note.time!.split(" ")[1].split(":")[0]);
    final minute = int.parse(note.time!.split(" ")[1].split(":")[1]);

    var timeReminder = DateTime(year, month, day, hour, minute);
    final timeReminderFormat =
        DateFormat('yyyy-MM-dd HH:mm').format(timeReminder);
    final interval = int.parse(note.interval!);
    var intervarReminder = "";

    if (interval == 24) {
      intervarReminder = DateFormat('yyyy-MM-dd HH:mm')
          .format(timeReminder.subtract(const Duration(days: 1)));
    } else if (interval == 3) {
      intervarReminder = DateFormat('yyyy-MM-dd HH:mm')
          .format(timeReminder.subtract(const Duration(hours: 3)));
    } else if (interval == 1) {
      intervarReminder = DateFormat('yyyy-MM-dd HH:mm')
          .format(timeReminder.subtract(const Duration(hours: 1)));
    }

    if (timeReminderFormat == nowFormat) {
      NotifictionApi.showNotification(
        id: Random().nextInt(10000000),
        title: note.title.toString(),
        body: note.description.toString(),
        payload: note.description.toString(),
      );
    }

    if (intervarReminder == nowFormat) {
      NotifictionApi.showNotification(
        id: Random().nextInt(10000000),
        title: "$interval Hour(s) remaining for ${note.title.toString()}",
        body: note.description.toString(),
        payload: note.description.toString(),
      );
    }
  }

  Future<void> deleteNote(int id) {
    return db.deleteNotes(id);
  }
}
