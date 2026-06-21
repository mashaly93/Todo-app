import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/screens/Edit_Screen.dart';
import 'package:todo_app/shared/Taskmodel.dart';
import 'package:todo_app/shared/firebase/firebase_manager.dart';

import 'colors.dart';

class TaskItem extends StatefulWidget {
  Taskmodel task;

  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,

      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        child: Container(
          color: Colors.white,
          child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    FirebaseManager.deleteTask(widget.task.Id);
                  },
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(
                      context,
                      EditScreen.routeName,
                      arguments:  widget.task
                    );
                  },
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalDivider(
                  color: blue,
                  thickness: 2,
                  endIndent: 20,
                  indent: 20,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(widget.task.Title, style: TextStyle(color: blue)),
                      Text(widget.task.Description),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.task.Isdone = true;
                    setState(() {});
                  },
                  child: Container(
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      color: widget.task.Isdone == true
                          ? Colors.green
                          : Colors.blue,
                    ),
                    child: widget.task.Isdone == true
                        ? Text(' Done!', style: TextStyle(fontSize: 15))
                        : Icon(Icons.done, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
