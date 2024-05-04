import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/assets/drawer.dart';
import 'package:notes/assets/note_list.dart';
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
                backgroundColor: Theme.of(context).colorScheme.background,
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
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text("Update Note"),
              content: TextField(controller: textController),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NotesDB>()
                        .updateNote(note.id, textController.text);
                    textController.clear();

                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                )
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
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: addNote,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary),
        ),
        drawer: SideDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25.0),
              child: Text(
                "Notes",
                style: TextStyle(
                    fontFamily: "Medium",
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];

                  return NoteList(
                    text: note.text,
                    onEditPressed: () => updateNotes(note),
                    onDeletePressed: () => deleteNote(note.id),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
