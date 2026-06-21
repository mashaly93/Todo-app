import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/shared/Taskmodel.dart';
import 'package:todo_app/shared/colors.dart';
import 'package:todo_app/shared/firebase/firebase_manager.dart';

import '../screens/List.dart';
import '../screens/settingsScreen.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'HomeLayout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final TextEditingController Taskcontroller = TextEditingController();
  final TextEditingController Discriptioncotroller = TextEditingController();
  List<Widget> Tabs = [list(), Setting()];
  DateTime currentDate = DateTime.now();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: blue,
        title: Text(
          'To DO list',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Tabs[index],
      floatingActionButton: FloatingActionButton(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        backgroundColor: blue,

        onPressed: () {
          ShowModalSheet(context);
        },
        child: Icon(Icons.add, color: Colors.white, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: blue,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Tabs[index];
                  setState(() {
                    index = 0;
                  });
                },
                icon: Icon(
                  Icons.list,
                  color: index == 0 ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(width: 50),

              IconButton(
                onPressed: () {
                  Tabs[index + 1];
                  setState(() {
                    index = 1;
                  });
                },
                icon: Icon(
                  Icons.settings,
                  color: index == 1 ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ShowModalSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Expanded(
                child: Center(
                  child: Text(
                    'Add New Task',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(fontFamily: 'mesmerise'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Expanded(
                child: TextFormField(
                  controller: Taskcontroller,
                  onTap: () {},
                  decoration: InputDecoration(
                    hintText: 'Enter Your Task',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,

                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Expanded(
                child: TextFormField(
                  controller: Discriptioncotroller,
                  onTap: () {},
                  decoration: InputDecoration(
                    hintText: 'Task Description',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,

                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 27),
              child: Text(
                'Select Time',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15,
                  textStyle: TextStyle(fontFamily: 'mesmerise'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Align(
                  alignment: AlignmentGeometry.centerStart,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Showpickersheet();
                      },

                      child: Text(
                        currentDate.toString().substring(0, 10),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: blue,
                          fontSize: 15,
                          textStyle: TextStyle(fontFamily: 'mesmerise'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: blue),
                onPressed: () {
                  Taskmodel task = Taskmodel(
                    Isdone: false,
                    Title: Taskcontroller.text,
                    Description: Discriptioncotroller.text,
                    Date: DateUtils.dateOnly(currentDate).millisecondsSinceEpoch, Id: '',
                  );
                  FirebaseManager.addTask(task).then((value) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Added Sucessfully'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Thank You',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blue,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Text('Add Task', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  Showpickersheet() async {
    DateTime? choseDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (choseDate != null) {
      setState(() {
        currentDate = choseDate;
      });
    }
  }
}
