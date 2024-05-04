import 'package:flutter/material.dart';
import 'package:notes/assets/notes.dart';
import 'package:notes/assets/notes_database.dart';
import 'package:provider/provider.dart';

class notesScreen extends StatefulWidget {
  const notesScreen({super.key});

  @override
  State<notesScreen> createState() => _notesScreenState();
}

class _notesScreenState extends State<notesScreen> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void addNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      context.read<NotesDB>().createNote(textController.text);

                      textController.clear();

                      Navigator.pop(context);
                    },
                    child: const Text("Add"),
                  )
                ]));
  }

  void readNotes() {
    context.read<NotesDB>().fetchNotes();
  }

  void updateNotes(Notes note) {
    textController.text = note.text;
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Update Note"),
      content:TextField(controller: textController),
      actions: [
        MaterialButton(onPressed: (){
          context.read<NotesDB>().updateNote(note.id, textController.text);
          textController.clear();

          Navigator.pop(context);
        },
        child: const Text("Update"),)
      ],
    ));
  }

  void deleteNote(int id) {
    context.read<NotesDB>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {

    final notesDB = context.watch<NotesDB>();

    List<Notes> currentNotes = notesDB.currentNotes; 

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
      itemCount: currentNotes.length,
      itemBuilder: (context, index) {
        final note = currentNotes[index];

        return ListTile(
          title: Text(note.text),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () => updateNotes(note), icon: const Icon(Icons.edit)),
              IconButton(onPressed: () => deleteNote(note.id), icon: const Icon(Icons.delete)),
            ],
          ),
        );
      },)
    );
  }
}
