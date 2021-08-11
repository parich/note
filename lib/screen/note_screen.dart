import 'package:flutter/material.dart';
import 'package:noteapp/model/note.dart';
import 'package:noteapp/screen/note_modal.dart';
import '../model/notes.dart';
import 'package:intl/intl.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Color color = Colors.red;

  Color circleColor(index) {
    if (index % 4 == 0) {
      color = Colors.red;
    } else if (index % 4 == 1) {
      color = Colors.blue;
    } else if (index % 4 == 2) {
      color = Colors.green;
    } else if (index % 4 == 3) {
      color = Colors.yellow;
    }
    return color;
  }

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              NoteModal(buttonPressed: _submit, id: "0", mode: "edit")
                  .showModal(
                ctx: context,
                data: Note(),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Notes().fetchAndSetNote(),
          builder: (context, AsyncSnapshot result) {
            if (result.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Note> note = result.data;

            return ListView.builder(
                itemCount: note.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        leading: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: circleColor(i),
                          radius: 25,
                          child: Text(note[i].title[0].toUpperCase()),
                        ),
                        title: Text(
                          note[i].title.toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(note[i].subject),
                            Text(DateFormat.yMMMd("en_US")
                                .format(note[i].created)),
                          ],
                        ),
                        trailing: Icon(Icons.star),
                      ),
                      Divider(),
                    ],
                  );
                });
          }),
    );
  }
}
