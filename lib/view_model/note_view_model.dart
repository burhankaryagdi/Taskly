import 'package:flutter/material.dart';

import 'package:taskly/model/note.dart';

class NoteViewModel extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(int index, Note updatedNote) {
    _notes[index] = updatedNote;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
