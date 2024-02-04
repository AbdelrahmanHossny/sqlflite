import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlflite/colors.dart';
import 'package:sqlflite/helper.dart';
import 'package:sqlflite/screens/AddNotes_screen/view.dart';
import 'package:sqlflite/screens/EditeNote_screen/view.dart';
import 'package:sqlflite/sqldb.dart';

class Note_screen extends StatefulWidget {
  const Note_screen({super.key});

  @override
  State<Note_screen> createState() => _Note_screenState();
}

class _Note_screenState extends State<Note_screen> {
  SqlDb sqlDb = SqlDb();
  bool isloading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.read("notes");
    notes.addAll(response);
    isloading = false;
    setState(() {});
  }

  bool _checkbox = false;
  _savedCheckedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool("check", _checkbox);
    });
  }

  _loadCheckedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isChecked = prefs.getBool("check");
    setState(() {
      _checkbox = isChecked ?? false;
    });
  }

  getRondomColor() {
    Random random = Random();
    return backgroundColor[random.nextInt(backgroundColor.length)];
  }

  @override
  void initState() {
    readData();
    _savedCheckedValue();
    _loadCheckedValue();
    super.initState();
  }

  List<bool> checked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Notes',
            style: TextStyle(color: Colors.white, fontSize: 26.sp)),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade800,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNotes_screen(),
            ));
          },
          child: Icon(
            Icons.add,
            size: 30,
          )),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(color: Colors.grey.shade800),
            )
          : Container(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditeNote_screen(
                                  note: notes[index]['note'],
                                  id: notes[index]['id'],
                                  color: notes[index]['color'],
                                  title: notes[index]['title']),
                            ));
                          },
                          child: Card(
                            color: getRondomColor(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 6, top: 6),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 20,
                                        height: 20,
                                        child: customCheck(
                                          onChanged: (value) {
                                            setState(() {
                                              _checkbox = !_checkbox;
                                              _savedCheckedValue();
                                            });
                                          },
                                          value: _checkbox,
                                        )),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text('${notes[index]['title']}'),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      '{${notes[index]['color']}}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text('${notes[index]['note']},',
                                    style: TextStyle(height: 1.6),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4),
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: IconButton(
                                        onPressed: () async {
                                          // int response = await sqlDb.deleteData(
                                          //     "DELETE FROM notes WHERE id = ${notes[index]['id']} ");
                                          int response = await sqlDb.delete(
                                              "notes",
                                              "id = ${notes[index]['id']}");
                                          if (response > 0) {
                                            notes.removeWhere((element) =>
                                                element['id'] ==
                                                notes[index]['id']);
                                            setState(() {});
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey.shade800,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
    );
  }
}
