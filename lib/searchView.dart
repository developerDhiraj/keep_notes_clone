import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keep_notes_clone/NoteView.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/model/MyNoteModel.dart';
import 'package:keep_notes_clone/services/db.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<int> SearchResultIDs = [];
  List<Note?> SearchResultNotes = [];

  bool isLoading = false;

  void SearchResults(String query) async {
    SearchResultNotes.clear();
    setState(() {
      isLoading = true;
    });
    final ResultIds =
        await NoteDatebse.instance.getNoteString(query); // [1,2,3,4]
    List<Note?> SearchResultNotesLocal = []; // [nOte1,nOTE2 ]
    ResultIds.forEach((element) async {
      final SearchNote = await NoteDatebse.instance.readOneNote(element);
      SearchResultNotesLocal.add(SearchNote);
      setState(() {
        SearchResultNotes.add(SearchNote);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: white.withAlpha(25),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: white,
                        )),
                    Expanded(
                      child: TextField(
                          textInputAction: TextInputAction.search,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search Your Notes",
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 16),
                          ),
                          onSubmitted: (value) {
                            setState(() {
                              SearchResults(value.toLowerCase());
                            });
                          }),
                    ),
                  ],
                ),
                NoteSectionAll()
              ],
            ),
          ),
        ));
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
                "View Your Result",
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
              itemCount: SearchResultNotes.length,
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
                                    note: SearchResultNotes[index]!,
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
                            SearchResultNotes[index]!.title,
                            style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            SearchResultNotes[index]!.content.length > 250
                                ? "${SearchResultNotes[index]!.content.substring(0, 250)}..."
                                : SearchResultNotes[index]!.content,
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
