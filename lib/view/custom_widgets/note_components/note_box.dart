import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/constants/my_color/color_constants.dart';

class MyNoteBox extends StatelessWidget {

  final String? noteTitle;
  final String? noteDesc;
  final String? date;
  final int myColor;
  final VoidCallback? onDelete;

  const MyNoteBox({super.key,
    this.noteTitle,
    this.noteDesc,
    this.date,
    this.myColor = 1,
    this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.myColorlist[myColor],
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(noteTitle ?? "",
                style:GoogleFonts.laila(
                 color: Colors.black,
                 fontWeight:FontWeight.bold,
                 fontSize:20) ,),
                InkWell(
                    onTap: onDelete,
                    child: Icon(Icons.delete)
                    )
              ],
            ),
            SizedBox(height: 10,),
            Text(noteDesc ?? "",
            maxLines: 3,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.justify,
            style:GoogleFonts.laila(
                 color: Colors.black,
                 fontSize:16
                 ) ,
            ),
            SizedBox(height: 12,),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(date ?? "",style:GoogleFonts.laila(
                   color: Colors.black,
                   fontWeight:FontWeight.bold
                   ) ,),
            )
          ],
        ),
      ),
    );
  }
}