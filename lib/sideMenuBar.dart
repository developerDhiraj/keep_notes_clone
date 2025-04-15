import 'package:flutter/material.dart';
import 'package:keep_notes_clone/archiveView.dart';
import 'package:keep_notes_clone/colors.dart';
import 'package:keep_notes_clone/setting.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: bgColor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  "Google Keep",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(color: white.withAlpha(9)),
              sectionOne(),
              SizedBox(
                height: 5,
              ),
              sectionTwo(),
              SizedBox(
                height: 5,
              ),
              sectionThree()
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionOne() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Colors.orange.withValues(alpha: 220)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))))),
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  size: 27,
                  color: white.withValues(alpha: 100),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Notes",
                  style: TextStyle(
                      color: white.withValues(alpha: 100), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  Widget sectionTwo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))))),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ArchiveView()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  Icons.archive_outlined,
                  size: 27,
                  color: white.withValues(alpha: 100),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Archive",
                  style: TextStyle(
                      color: white.withValues(alpha: 100), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  Widget sectionThree() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))))),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsView()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 27,
                  color: white.withValues(alpha: 100),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Setting",
                  style: TextStyle(
                      color: white.withValues(alpha: 100), fontSize: 18),
                )
              ],
            ),
          )),
    );
  }
}
