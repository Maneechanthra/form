import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form/screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "AIzaSyDzLeNQzRRzdysIeujq0GjR6GFFLuB4Ywc", //  ==   current_key in google-services.json file
      appId:
          "1:1048535425731:android:ccd191aca671c8cfd87876", // ==  mobilesdk_app_id  in google-services.json file
      messagingSenderId:
          "1048535425731", // ==   project_number in google-services.json file
      projectId:
          "myflutter-86545", // ==   project_id   in google-services.json file
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePgae(),
    );
  }
}
