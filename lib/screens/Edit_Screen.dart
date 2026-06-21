import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/Taskmodel.dart';
import 'package:todo_app/shared/colors.dart';

import '../shared/firebase/firebase_manager.dart';

class EditScreen extends StatefulWidget {


  static const String routeName = 'EditScreen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  late DateTime selectedDate;
  late Taskmodel task;
  bool isInit = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as Taskmodel;
    if (!isInit) {
      selectedDate =
          DateTime.fromMillisecondsSinceEpoch(task.Date);

      titleController.text = task.Title;
      descController.text = task.Description;

      isInit = true;
    }


    return Scaffold(
      appBar: AppBar(backgroundColor: blue, title: Text('To DO list')),
      body: Container(
        color: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text('Edit Your Task')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: task.Title,
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descController ,
                    decoration: InputDecoration(
                      hintText: task.Description,
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentGeometry.bottomLeft,
                    child: Text('Select Time'),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.fromMillisecondsSinceEpoch(task.Date),
                        firstDate: DateTime.now().subtract(Duration(days: 165)),
                        lastDate: DateTime.now().add(Duration(days: 200)),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      selectedDate.toString().substring(0, 10),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () async {
                    task.Title = titleController.text;
                    task.Description = descController.text;

                    task.Date = selectedDate.millisecondsSinceEpoch;

                    await FirebaseManager.updateTask(task);

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save Chagnes',
                    style: TextStyle(color: Colors.white),
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
