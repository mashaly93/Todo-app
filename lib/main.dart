import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/home.dart';
import 'package:todo_app/screens/Edit_Screen.dart';
import 'package:todo_app/shared/MythemData.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  }
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeLayout.routeName,
        routes:{
          EditScreen.routeName:(context){
            return EditScreen();
          }

          ,HomeLayout.routeName:(context){
            return HomeLayout();
          }
        } ,

        theme: Mythemedata.lightMode,
        themeMode: ThemeMode.light,

      );
    }
  }



