import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTodoSheet extends StatelessWidget {
  final taskController;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  const MyTodoSheet({
    super.key,
    required this.taskController,
    required this.onsave,
    required this.oncancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create Your ToDo here !',
            style: GoogleFonts.laila(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: taskController,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'ToDo name',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.black,
          onPressed: onsave,
          child: Text(
            'Save',
            style: GoogleFonts.laila(color: Colors.white),
          ),
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.black,
          onPressed: oncancel,
          child: Text(
            'Cancel',
            style: GoogleFonts.laila(color: Colors.white),
          ),
        )
      ],
    );
  }
}
