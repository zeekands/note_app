import 'package:get/get.dart';
import 'package:note_app/app/data/notes_model.dart';
import 'package:note_app/app/utils/db_helper.dart';

class HomeController extends GetxController {
  final listNotes = <NotesModel>[].obs;
  DBHelper db = DBHelper();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllNotes();
  }

  Future<void> getAllNotes() async {
    var list = await db.getAllNotes();
    listNotes.clear();
    list!.forEach((notes) {
      listNotes.add(NotesModel.fromJson(notes));
    });
  }

  Future<void> deleteNote(int id) {
    return db.deleteNotes(id);
  }
}
