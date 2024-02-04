import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqlflite/screens/Note_screen/view.dart';
import 'package:sqlflite/sqldb.dart';

class AddNotes_screen extends StatefulWidget {
  const AddNotes_screen({super.key});

  @override
  State<AddNotes_screen> createState() => _AddNotes_screenState();
}

class _AddNotes_screenState extends State<AddNotes_screen> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // int response = await sqlDb.insertData('''
          //                         INSERT INTO notes (`title`,`note`,`color`)
          //                         VALUES
          //                         ("${title.text}","${note.text}","${color.text}")
          //                         ''');
          int response = await sqlDb.insert("notes", {
            'note': "${note.text}",
            'title': "${title.text}",
            'color': "${color.text}",
          });
          if (response > 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Note_screen(),
                ),
                (route) => false);
          }
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.grey.shade800,
      ),
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
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 30),
                          hintText: 'Title'),
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
                      maxLines: 10000,
                      controller: note,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Type thomthing here........'),
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
