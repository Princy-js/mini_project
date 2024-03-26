import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/view/note_page/note_page.dart';
import 'package:my_app/view/todo_page/todo_page.dart';

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.grey[100],
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ToDoPage()));
            },
            child: Text(
              'TODO',
              style: GoogleFonts.laila(color: Colors.black),
            ),
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.grey[100],
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NotePage()));
            },
            child: Text(
              'NOTES',
              style: GoogleFonts.laila(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
