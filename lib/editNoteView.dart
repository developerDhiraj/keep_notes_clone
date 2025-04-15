import 'package:flutter/material.dart';
import 'package:keep_notes_clone/NoteView.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/home.dart';
import 'package:keep_notes_clone/model/MyNoteModel.dart';
import 'package:keep_notes_clone/services/db.dart';

class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String NewTitle;
  late String NewNoteDet;
  @override
  void initState() {
    // TODO: implement initState
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDet = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () async {
                Note newNote = Note(
                    content: NewNoteDet,
                    title: NewTitle,
                    createdTime: widget.note.createdTime,
                    pin: widget.note.pin,
                    isArchieve: widget.note.isArchieve,
                    id: widget.note.id);
                await NoteDatebse.instance.updateOneNote(newNote);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(
                Icons.save_outlined,
                color: white,
              ))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                  initialValue: NewTitle,
                  onChanged: (value) {
                    NewTitle = value;
                  },
                  cursorColor: white,
                  style: TextStyle(
                      fontSize: 25, color: white, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withAlpha(200)))),
            ),
            Container(
                height: 300,
                child: Form(
                  child: TextFormField(
                      onChanged: (value) {
                        NewNoteDet = value;
                      },
                      initialValue: NewNoteDet,
                      keyboardType: TextInputType.multiline,
                      minLines: 50,
                      maxLines: null,
                      cursorColor: white,
                      style: TextStyle(fontSize: 17, color: white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Note",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.withAlpha(200)))),
                ))
          ],
        ),
      ),
    );
  }
}
