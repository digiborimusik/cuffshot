import 'package:cuffshot/auth/FirebaseAuthService.dart';
import 'package:cuffshot/auth/FirebaseStatusData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Text('qweqwe'),
        ),
        body: Test(),
      ),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  FirebaseAuthService authSrv = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
  }

  void test() async {
    // FirebaseStatusData usr = await authSrv.regIn('vanta@qwseesaa.ru', '123123');

    // FirebaseStatusData usr =
    //     await authSrv.signIn('vanta@qwseesaa.ru', '123123');

    // FirebaseStatusData usr = await authSrv.updateUserData('bich', 'asdsad');

    // FirebaseStatusData usr = await authSrv.signOut();
    print('separ');
    // print(usr.user);

    // print(authSrv.auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    test();
    return Column(
      children: [
        FlatButton(
            onPressed: () {
              // authSrv.regIn('vanta@qwe.ru', 'asdsd2');
            },
            child: Text('test1'))
      ],
    );
  }
}

// class Testt {
//   bool val;
//   Testt({this.val = false});
// }

// class Testt2 extends Testt {
//   bool val2;
//   Testt2(this.val2, {bool df}) : super(val: df);
// }
