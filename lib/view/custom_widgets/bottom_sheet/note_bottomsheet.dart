// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:my_app/constants/my_color/color_constants.dart';

// class NoteBtmSheet extends StatefulWidget {
  
  
//   final String titleController;
//   final String descriptionController;
//   final String dateController;
//   final VoidCallback onSave;
//   final VoidCallback onCancel;

//   NoteBtmSheet({
//     super.key,
//     required this.titleController,
//     required this.descriptionController,
//     required this.dateController,
//     required this.onSave,
//     required this.onCancel
//     });

//   @override
//   State<NoteBtmSheet> createState() => _NoteBtmSheetState();
// }

// class _NoteBtmSheetState extends State<NoteBtmSheet> {

//   int selectedColor = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Title',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(
//                     color: Colors.white
//                   )
//                 )
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               maxLines: 4,
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(
//                     color: Colors.white
//                   )
//                 )
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 suffixIcon: InkWell(
//                   onTap: (){},
//                   child: Icon(Icons.calendar_month)),
//                 labelText: 'Date',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5)
//                 )
//               ),
//             ),
//           ),
//          SizedBox(height: 10,),
//          Padding(
//            padding: const EdgeInsets.only(left:8.0),
//            child: Align(
//             alignment: Alignment.centerLeft,
//              child: Text('Choose color',style: GoogleFonts.laila(
//                  color: Colors.black),),
//            ),
//          ),
//          SizedBox(height: 5,),
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20),
//            child: Container(
//             height: 45,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: ColorConstants.myColorlist.length,
//               itemBuilder: (context,index) => Padding(
//                 padding: const EdgeInsets.only(left: 5,right: 5),
//                 child: InkWell(
//                   onTap: (){
//                     inSetState(){
//                       selectedColor = index;
//                     }
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 4,
//                         color: selectedColor == index 
//                         ? ColorConstants.myColorlistDark[index]
//                         :Colors.transparent
//                       ),
//                       borderRadius: BorderRadius.circular(6),
//                       color: ColorConstants.myColorlist[index]
//                     ),
//                   ),
//                 ),
//               )
//               ),
//            ),
//          ) ,
//          SizedBox(height: 20,),
//          Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             MaterialButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8)
//               ),
//               color: Colors.black,
//               onPressed:(){},
//               child: Text('Save',style:  GoogleFonts.laila(color: Colors.white),),
//             ),
//             MaterialButton(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8)
//               ),
//               color: Colors.black,
//               onPressed: (){},
//               child: Text('Cancel',style:  GoogleFonts.laila(color: Colors.white),),
//             )
//           ],
//          )
//         ],
//       ),
//     );
//   }
// }