import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/constents.dart';

import 'cores/utlis/shared_pre_helper.dart';
import 'features/homePage/data/models/task_card_model/task_card_model.dart';
import 'features/homePage/presentation/view/home_page.dart';
import 'features/login/presentation/view/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskCardModelAdapter()); // Register adapter
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHelper.initSharedPreference();

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
      home: uId.isEmpty ? const LoginScreen() : const HomePage(),
    );
  }
}
