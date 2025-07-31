import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/commonviewmodel.dart';
import 'screen2/start_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CommonViewModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fliq date',
          theme: ThemeData(fontFamily: 'Poppins'),
          home: StartScreen(),
        ));
  }
}
