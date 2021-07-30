import 'package:flutter/foundation.dart';

class Note {
  final String id;
  final String title;
  final String subject;
  final DateTime created;
  bool favorite;

  Note(
      {this.id = '',
      this.title = '',
      this.subject = '',
      DateTime? created,
      this.favorite = false})
      : this.created = created ?? DateTime.now();
}
