import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqlflite/screens/Note_screen/view.dart';
import 'package:sqlflite/sqldb.dart';

class EditeNote_screen extends StatefulWidget {
  final note;
  final id;
  final color;
  final title;
  const EditeNote_screen(
      {super.key,
      required this.note,
      required this.id,
      required this.color,
      required this.title});

  @override
  State<EditeNote_screen> createState() => _EditeNote_screenState();
}

class _EditeNote_screenState extends State<EditeNote_screen> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // int response = await sqlDb.updateData('''
          //                       UPDATE notes SET
          //                       note ="${note.text}",
          //                       title ="${title.text}",
          //                       color ="${color.text}"
          //                       WHERE id = ${widget.id}
          //                         ''');
          int response = await sqlDb.update(
              "notes",
              {
                "note": "${note.text}",
                "title": "${title.text}",
                "color": "${color.text}",
              },
              "id = ${widget.id}");
          if (response > 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Note_screen(),
                ),
                (route) => false);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            child: ListView(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 26.h,
            ),
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 30)),
                    ),
                    TextFormField(
                      controller: color,
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 26),
                          hintText: 'category'),
                    ),
                    TextFormField(
                      maxLines: 1000,
                      controller: note,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type thomthing here',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    // TextFormField(
                    //   controller: color,
                    //   decoration: InputDecoration(hintText: 'color'),
                    // ),
                  ],
                )),

            // ElevatedButton(
            //     onPressed: () async {
            //       int response = await sqlDb.MydeleteDatabase();
            //       print(response);
            //     },
            //     child: Text('Delete'))
          ],
        )),
      ),
    );
  }
}
