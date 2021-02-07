import 'package:cuffshot/TestScreen.dart';
import 'package:cuffshot/auth/AuthActions.dart';
import 'package:cuffshot/auth/AuthBloc.dart';
import 'package:cuffshot/auth/AuthScreen.dart';
import 'package:cuffshot/auth/AuthStates.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AuthBloc>(create: (_) => AuthBloc())],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.cyan),
        title: 'CuffShot',
        routes: routes,
      ),
    );
  }
}

Map<String, Widget Function(BuildContext)> routes = {
  '/': (_) => AuthScreen(),
  'test': (_) => TestW(),
};
