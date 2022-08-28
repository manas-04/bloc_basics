import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/url.dart';
import 'screens/second_screen.dart';
import 'screens/first_screen.dart';

late Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UrlAdapter());
  box = await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Screen2.routeName: (context) => const Screen2(),
      },
      home: const FirstScreen(title: 'Assignment'),
    );
  }
}
