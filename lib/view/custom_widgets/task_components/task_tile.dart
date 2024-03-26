import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  final Function(bool?)? onTapping;
  final Function(BuildContext)? onEdit;
  final Function(BuildContext)? onDelete;
  const TaskTile({
    super.key,
    required this.taskName,
    required this.taskStatus,
    required this.onTapping,
    required this.onEdit,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:20,right: 20,top: 16),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          // SlidableAction(
          //         onPressed:onEdit,
          //         borderRadius: BorderRadius.circular(12),
          //         backgroundColor:Colors.grey.shade50,
          //         icon: Icons.edit,
          //       ),
                SlidableAction(
                  onPressed: onDelete,
                  borderRadius: BorderRadius.circular(12),
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                )
        ]),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white10,
          ),
         
          child: Center(
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: Checkbox(
                activeColor:
                Colors.green,
                value: taskStatus, 
                onChanged:onTapping),
                title: Text(taskName,
                style:GoogleFonts.laila(
                  color: Colors.white,
                  decorationThickness: 2.8,
                  decorationStyle:TextDecorationStyle.wavy,
                  decoration:taskStatus == true
                  ?TextDecoration.lineThrough 
                  :TextDecoration.none
                  ),),
                trailing: Icon(Icons.arrow_back_ios,size: 12,color: Colors.white60,),
            ),
          ),
        ),
      ),
    );
  }
}