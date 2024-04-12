import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryTile extends StatelessWidget {
  final String total;
  final String completed;
  final String incompleted;
  const SummaryTile(
      {super.key,
      required this.total,
      required this.completed,
      required this.incompleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      total,
                      style:
                          GoogleFonts.laila(fontSize: 20, color: Colors.white),
                    ))),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Total Task',
                  style: GoogleFonts.laila(color: Colors.white, fontSize: 14),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      completed,
                      style:
                          GoogleFonts.laila(fontSize: 20, color: Colors.white),
                    ))),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Completed',
                  style: GoogleFonts.laila(color: Colors.white, fontSize: 14),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      incompleted,
                      style:
                          GoogleFonts.laila(fontSize: 20, color: Colors.white),
                    ))),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Pending',
                  style: GoogleFonts.laila(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
