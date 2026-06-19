import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/firebase/firebase_manager.dart';

import '../shared/TaskItem.dart';
import '../shared/Taskmodel.dart';
import '../shared/colors.dart';

class list extends StatefulWidget {
  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  DateTime selectedTime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: selectedTime,
          firstDate: DateTime.now().subtract(Duration(days: 165)),
          lastDate: DateTime.now().add(Duration(days: 200)),
          onDateSelected: (date) {
            selectedTime=date;
            setState(() {

            });
          },
          leftMargin: 20,
          monthColor: blue,
          dayColor: Colors.black,
          activeDayColor: blue,
          activeBackgroundDayColor: Colors.white,
          dotColor: Colors.black,

          selectableDayPredicate: (date) => date.day != 0,
          locale: 'en_ISO',
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Taskmodel>>(
            stream: FirebaseManager.getTask( DateUtils.dateOnly(selectedTime),),
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Taskmodel>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"));
                  }

                  var tasks =
                      snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

                  if (tasks.isEmpty) {
                    return Center(child: Text("NO TASKS"));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskItem(tasks[index]);
                    },
                    itemCount: tasks.length,
                  );
                },
          ),
        ),
      ],
    );
  }
}
