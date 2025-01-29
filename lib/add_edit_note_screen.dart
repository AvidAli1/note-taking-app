import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note.dart';
import 'note_view_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final String userId;
  final Note? note;

  const AddEditNoteScreen({required this.userId, this.note, Key? key})
      : super(key: key);

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);

    return Scaffold(
      appBar:
          AppBar(title: Text(widget.note == null ? 'Add Note' : 'Edit Note')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _contentController.text.isNotEmpty) {
                  final newNote = Note(
                    noteId: widget.note?.noteId ?? '',
                    title: _titleController.text,
                    content: _contentController.text,
                    createdAt: DateTime.now(),
                  );

                  if (widget.note == null) {
                    noteViewModel.addNote(newNote, widget.userId);
                  } else {
                    noteViewModel.updateNote(newNote);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(widget.note == null ? 'Add Note' : 'Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
