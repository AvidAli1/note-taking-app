import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_view_model.dart';
import 'note.dart'; // Your Note model class
import 'add_edit_note_screen.dart';

class HomeView extends StatefulWidget {
  final String userId;

  const HomeView({required this.userId, Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context);
    noteViewModel.fetchNotes(widget.userId);

    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for creating a new note
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Note Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Note Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newNote = Note(
                  noteId: '', // Empty ID for new note
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: DateTime.now(),
                );

                noteViewModel.addNote(newNote, widget.userId); // Add new note
                titleController.clear();
                contentController.clear();
              },
              child: const Text('Add Note'),
            ),
            const SizedBox(height: 20),
            // Display the list of notes
            Expanded(
              child: Consumer<NoteViewModel>(
                builder: (context, noteViewModel, child) {
                  return ListView.builder(
                    itemCount: noteViewModel.notes.length,
                    itemBuilder: (context, index) {
                      final note = noteViewModel.notes[index];
                      return ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.content),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditNoteScreen(
                                userId: widget.userId, note: note),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              noteViewModel.deleteNote(note.noteId),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditNoteScreen(userId: widget.userId),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
