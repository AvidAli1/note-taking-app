import 'package:cloud_firestore/cloud_firestore.dart';
import 'note.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get notes for the current user
  Stream<List<Note>> getNotes(String userId) {
    return _db
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add a new note
  Future<void> addNote(String userId, Note note) async {
    await _db.collection('notes').add({
      ...note.toMap(),
      'userId': userId, // Store note under specific user
    });
  }

  // Update a note
  Future<void> updateNote(Note note) async {
    await _db.collection('notes').doc(note.noteId).update(note.toMap());
  }

  // Delete a note
  Future<void> deleteNote(String noteId) async {
    await _db.collection('notes').doc(noteId).delete();
  }
}
