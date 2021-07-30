import 'note.dart';
import '../helper/db_helper.dart';

class Notes {
  List<Note> _notes = [];

  void addNote(String title, String subject) {
    final newNote = Note(
        id: DateTime.now().toString(),
        title: title,
        subject: subject,
        created: DateTime.now(),
        favorite: false);

    DBHelper.insert("notes", {
      "id": newNote.id,
      "title": newNote.title,
      "subject": newNote.subject,
      "created": newNote.created.toIso8601String(),
      "favorite": newNote.favorite == false ? 0 : 1
    });
  }

  Future<List<Note>> fetchAndSetNote() async {
    final data = await DBHelper.getData("notes");

    // print(data);

    _notes = data.map((item) {
      return Note(
          id: item['id'],
          title: item['title'],
          subject: item['subject'],
          created: DateTime.parse(item['created']),
          favorite: item['favorite'] == 0 ? false : true);
    }).toList();

    print(_notes[0].created);

    return _notes;
  }
}
