import 'package:flutter/material.dart';
import 'note.dart';
import 'firestore_service.dart';

class NoteViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  // Fetch notes for a user
  void fetchNotes(String userId) {
    _firestoreService.getNotes(userId).listen((noteList) {
      _notes = noteList;
      notifyListeners();
    });
  }

  // Add a note
  Future<void> addNote(Note note, String userId) async {
    await _firestoreService.addNote(userId, note);
  }

  // Update a note
  Future<void> updateNote(Note note) async {
    await _firestoreService.updateNote(note);
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    await _firestoreService.deleteNote(noteId);
  }
}
