import 'package:flutter/material.dart';
import 'package:keep_notes_clone/NoteView.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/model/MyNoteModel.dart';
import 'package:keep_notes_clone/searchView.dart';
import 'package:keep_notes_clone/services/db.dart';
import 'sideMenuBar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'createNoteView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  late List<Note> notesList = [];

  GlobalKey<ScaffoldState> _drowerKey = GlobalKey();
  String note =
      "This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is NoteThis is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is NoteThis is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is NoteThis is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is NoteThis is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is NoteThis is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is NoteThis is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note, This is Note";
  String note1 = "This is Note, This is Note, This is Note";

  @override
  void initState() {
    super.initState();
    // createEntry(Note(
    //     pin: false,
    //     isArchieve: false,
    //     title: "Code with Dhiraj",
    //     content: "This is Dhiraj, brief descriptions of the content",
    //     createdTime: DateTime.now()));
    getAllNotes();
  }

  Future createEntry(Note note) async {
    await NoteDatebse.instance.InsertEntry(note);
  }

  Future getAllNotes() async {
    this.notesList = await NoteDatebse.instance.readAllNotes();
    setState(() {
      isLoading = false;
    });
  }

  Future getOneNote(int id) async {
    await NoteDatebse.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NoteDatebse.instance.updateOneNote(note);
  }

  Future deleteOneNote(Note note) async {
    await NoteDatebse.instance.delteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: bgColor,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNoteView()));
              },
              backgroundColor: cardColor,
              child: Icon(
                Icons.add,
                color: white,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drowerKey,
            drawer: SideMenu(),
            backgroundColor: bgColor,
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _drowerKey.currentState!.openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      color: white,
                                    )),
                                SizedBox(
                                  width: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchView()));
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Search Your Notes",
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  TextButton(
                                      style: ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                            EdgeInsets
                                                .zero), // Remove extra padding
                                        minimumSize: WidgetStatePropertyAll(
                                            Size(35, 35)), // Set a smaller size
                                        tapTargetSize: MaterialTapTargetSize
                                            .shrinkWrap, // Reduce touch target size
                                        foregroundColor: WidgetStatePropertyAll(
                                            Colors.white), // Ensure icon color
                                      ),
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.grid_view_outlined,
                                        color: white,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      NoteSectionAll(),
                      NoteListSection(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget NoteListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "Note List",
                style: TextStyle(
                    color: white.withAlpha(120),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: white.withAlpha(125)),
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "heading",
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          index.isEven
                              ? note.length > 250
                                  ? "${note.substring(0, 250)}..."
                                  : note
                              : note1,
                          style: TextStyle(color: white),
                        )
                      ],
                    ),
                  )),
        ),
      ],
    );
  }

  Widget NoteSectionAll() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              Text(
                "All",
                style: TextStyle(
                    color: white.withAlpha(120),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: MasonryGridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notesList.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteView(
                                    note: notesList[index],
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: white.withAlpha(125)),
                          borderRadius: BorderRadius.circular(7)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notesList[index].title,
                            style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            notesList[index].content.length > 250
                                ? "${notesList[index].content.substring(0, 250)}..."
                                : notesList[index].content,
                            style: TextStyle(color: white),
                          )
                        ],
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}
