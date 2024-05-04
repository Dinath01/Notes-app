import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/assets/notes.dart';
import 'package:path_provider/path_provider.dart';

class NotesDB extends ChangeNotifier{
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NotesSchema],
      directory: dir.path,
    );
  }

  final List<Notes> currentNotes = [];

  Future<void> createNote(String textFromUser) async {
    final newNote = Notes()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));

    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Notes> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> updateNote (int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if (existingNote != null){
      existingNote.text= newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
  }
}