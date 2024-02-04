import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqlflite/screens/Note_screen/view.dart';

class welcom_screen extends StatelessWidget {
  const welcom_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 155.h,
            ),
            Swing(
                child: Stack(
              children: [
                Image.asset('assets/images/play_store_512.png'),
                Padding(
                  padding: const EdgeInsets.only(top: 200).h,
                  child: Center(
                    child: Text(
                      'Think Pad ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 250).h,
                  child: Center(
                    child: Text(
                      'WHERE IDIEAS COME ALIVE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          wordSpacing: 1.5,
                          letterSpacing: 2),
                    ),
                  ),
                )
              ],
            )),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800,
                    fixedSize: Size(160.w, 40.h)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Note_screen(),
                      ));
                },
                child: Text(
                  'Go Think',
                  style: TextStyle(fontSize: 17.sp),
                ))
          ]),
    );
  }
}
