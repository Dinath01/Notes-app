import 'package:flutter/material.dart';
import 'package:notes/assets/notes_database.dart';
import 'package:provider/provider.dart';

class notesScreen extends StatefulWidget {
  const notesScreen({super.key});

  @override
  State<notesScreen> createState() => _notesScreenState();
}

class _notesScreenState extends State<notesScreen> {

  final textController = TextEditingController();

  void addNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(onPressed: (){
                  context.read<NotesDB>().createNote(textController.text);
                  Navigator.pop(context);
                },
                child: const Text("Add"),
                )
              ]
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
