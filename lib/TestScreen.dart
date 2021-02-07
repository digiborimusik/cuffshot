import 'package:cuffshot/auth/AuthActions.dart';
import 'package:cuffshot/auth/AuthBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestW extends StatefulWidget {
  TestW({Key key}) : super(key: key);

  @override
  _TestWState createState() => _TestWState();
}

class _TestWState extends State<TestW> {
  AuthBloc authbloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authbloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('Test baby!'),
            FlatButton(
                onPressed: () => authbloc.mapEvent(SignOut()),
                child: Text('SignOut')),
            FlatButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: Text('test'))
          ],
        ),
      ),
    );
  }
}
