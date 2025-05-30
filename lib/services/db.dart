import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:keep_notes_clone/model/MyNoteModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatebse {
  static final NoteDatebse instance = NoteDatebse._init();
  static Database? _database;
  NoteDatebse._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    // await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
  CREATE TABLE Notes (
   ${NotesImpNames.id} $idType,
   ${NotesImpNames.pin} $boolType,
   ${NotesImpNames.isArchieve} $boolType,
   ${NotesImpNames.title} $textType,
   ${NotesImpNames.content} $textType,
   ${NotesImpNames.createdTime} $textType

  )
    ''');
  }

  Future<Note?> InsertEntry(Note note) async {
    final db = await instance.database;
    final id = await db!.insert(NotesImpNames.TableName, note.toJson());
    return note.copy(id: id);
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesImpNames.createdTime} ASC';
    final query_result =
        await db!.query(NotesImpNames.TableName, orderBy: orderBy);
    return query_result.map((json) => Note.fromJson(json)).toList();
  }

  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!.query(NotesImpNames.TableName,
        columns: NotesImpNames.value,
        where: '${NotesImpNames.id} = ?',
        whereArgs: [id]);
    print(map);
  }

  Future updateOneNote(Note note) async {
    final db = await instance.database;

    await db!.update(NotesImpNames.TableName, note.toJson(),
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  Future pinNote(Note note) async {
    final db = await instance.database;
    await db!.update(
      NotesImpNames.TableName,
      {NotesImpNames.pin: note.pin ? 0 : 1},
      where: "${NotesImpNames.id} = ?",
      whereArgs: [note.id],
    );
  }

  Future archNote(Note note) async {
    final db = await instance.database;
    await db!.update(
      NotesImpNames.TableName,
      {NotesImpNames.isArchieve: note.isArchieve ? 0 : 1},
      where: "${NotesImpNames.id} = ?",
      whereArgs: [note.id],
    );
  }

  Future delteNote(Note note) async {
    final db = await instance.database;
    await db!.delete(NotesImpNames.TableName,
        where: '${NotesImpNames.id}=?', whereArgs: [note.id]);
  }

  Future closeDB() async {
    final db = await instance.database;
    db!.close();
  }

  Future<List<int>> getNoteString(String query) async {
    final db = await instance.database;
    final result = await db!.query(NotesImpNames.TableName);
    List<int> resultsIds = [];
    result.forEach((element) {
      if (element["title"].toString().toLowerCase().contains(query) ||
          element["content"].toString().toLowerCase().contains(query)) {
        resultsIds.add(element["id"] as int);
      }
    });
    return resultsIds;
  }
}
