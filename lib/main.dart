import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/constents.dart';
import 'package:todo_list_app/features/homePage/presentation/view/home_page_desktop.dart';
import 'cores/utlis/shared_pre_helper.dart';
import 'features/homePage/data/models/task_card_model/task_card_model.dart';
import 'features/login/presentation/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.init(r'C:\Users\mohme\');
  await Hive.initFlutter(r'C:\Users\mohme\');
  Hive.registerAdapter(TaskCardModelAdapter()); // Register adapter
  await SharedPreferenceHelper.initSharedPreference();
  Firestore.initialize('online-tasks-app');
  FirebaseAuth.initialize(
      'AIzaSyBqgb09cuODNHrSXjhJujQ4aqxtVtPA7go', VolatileStore());
  
  String? id = SharedPreferenceHelper.getString(key: 'id');

  if (id != null) {
    uId = id;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      home: uId.isEmpty ? const LoginScreen() : const HomePageDesktop(),
    );
  }
}
