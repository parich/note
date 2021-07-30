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

  showModal({required BuildContext ctx, required Note data}) {
    return showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (ctx) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.indigo,
                child: null,
              ),
            ),
          );
        });
  }
}
