class Note {
  String noteId;
  String title;
  String content;
  DateTime createdAt;

  Note({
    required this.noteId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // Convert Note to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert Firestore DocumentSnapshot to Note object
  factory Note.fromMap(Map<String, dynamic> data, String documentId) {
    return Note(
      noteId: documentId,
      title: data['title'],
      content: data['content'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
}
