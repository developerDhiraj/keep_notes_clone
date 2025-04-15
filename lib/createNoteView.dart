import 'package:flutter/material.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/home.dart';
import 'package:keep_notes_clone/model/MyNoteModel.dart';
import 'package:keep_notes_clone/services/db.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
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
                await NoteDatebse.instance.InsertEntry(Note(
                    pin: false,
                    isArchieve: false,
                    title: title.text,
                    content: content.text,
                    createdTime: DateTime.now()));
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
              child: TextField(
                  controller: title,
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
                child: TextField(
                    controller: content,
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
                            color: Colors.grey.withAlpha(200)))))
          ],
        ),
      ),
    );
  }
}
