import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/model/note.dart';

class NoteModal {
  final Function buttonPressed;
  final String id;
  String mode;

  NoteModal(
      {required this.buttonPressed, required this.id, required this.mode});

  final GlobalKey<FormState> _formKey = GlobalKey();

  String _title = "";
  String _subject = "";

  var _titleFocus = FocusNode();
  var _subjectFocus = FocusNode();

  InputDecoration inputStyle(String text) {
    return InputDecoration(
      border: InputBorder.none,
      labelText: text,
      hintStyle: TextStyle(color: Colors.black26),
      contentPadding: EdgeInsets.zero,
      errorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      focusedErrorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
    );
  }

  showModal({required BuildContext ctx, required Note data}) {
    return showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(ctx).viewInsets.bottom),
                color: Color(0xff575757),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            mode == "add" ? "New Note" : "Edit Note",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          OutlinedButton.icon(
                              style: TextButton.styleFrom(
                                  primary: mode == "add"
                                      ? Colors.green
                                      : Colors.red),
                              onPressed: () {
                                print(mode);
                              },
                              icon: Icon(mode == "add" ? Icons.add : Icons.add),
                              label: Text(mode == "add" ? "Add" : "Edit")),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        // ignore: unnecessary_null_comparison
                        initialValue: data != null ? data.title : null,
                        key: ValueKey("title"),
                        focusNode: _titleFocus,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        onFieldSubmitted: (_) {
                          FocusScope.of(ctx).requestFocus(_subjectFocus);
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return "Title must be at least 4 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                        decoration: inputStyle("Title"),
                      ),
                      TextFormField(
                        // ignore: unnecessary_null_comparison
                        initialValue: data != null ? data.title : null,
                        key: ValueKey("subject"),
                        focusNode: _subjectFocus,
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        onEditingComplete: () {},
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return "Subject must be at least 4 characters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _subject = value!;
                        },
                        decoration: inputStyle("Subject"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
