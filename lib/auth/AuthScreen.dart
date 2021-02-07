import 'package:cuffshot/auth/AuthActions.dart';
import 'package:cuffshot/auth/AuthBloc.dart';
import 'package:cuffshot/auth/AuthStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = context.read<AuthBloc>();

    bloc.stateStream.listen((event) {
      print(event);
      // if (event is IsLogined) {
      //   Navigator.pushReplacementNamed(context, 'test');
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(bloc.state);

    return Scaffold(
      appBar: null,
      body: Container(
          child: StreamBuilder(
        stream: bloc.stateStream,
        initialData: AppStarting(),
        builder: (context, snapshot) {
          if (snapshot.data is IsNotLogged) {
            IsNotLogged act = snapshot.data;
            return SignField(
                isPending: act.busy, isErrored: act.error, errCode: act.code);
          }
          if (snapshot.data is IsLogined) {
            SchedulerBinding.instance.addPostFrameCallback((e) {
              Navigator.pushReplacementNamed(context, 'test');
            });
            return Center(child: Text('Camin baby!'));
          }
          if (snapshot.data is AppStarting) {
            return Text('init');
          }
        },
      )),
    );
  }
}

class SignField extends StatefulWidget {
  bool isPending;
  bool isErrored;
  String errCode;

  SignField({this.isPending = false, this.isErrored = false, this.errCode});

  @override
  _SignFieldState createState() => _SignFieldState();
}

class _SignFieldState extends State<SignField> {
  String email;
  String password;
  AuthBloc authbloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authbloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(16), child: Text('Login or not')),
            ],
          ),
          Container(
            width: 300,
            padding: EdgeInsets.all(8),
            child: TextField(
              enabled: !widget.isPending,
              decoration: InputDecoration(
                icon: Icon(Icons.email_outlined),
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.amber),
                // ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.yellow),
                // ),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.amber),
                // ),
              ),
              controller: TextEditingController(text: email),
              onChanged: (value) => email = value,
            ),
          ),
          Container(
            width: 300,
            padding: EdgeInsets.all(8),
            child: TextField(
              enabled: !widget.isPending,
              decoration: InputDecoration(
                helperText: widget.isErrored ? widget.errCode : null,
                icon: Icon(Icons.lock_open),
                // enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.amber),
                // ),
                // focusedBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.yellow),
                // ),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.amber),
                // ),
              ),
              controller: TextEditingController(text: password),
              onChanged: (value) => password = value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: () => authbloc.mapEvent(SignIn(email, password)),
                  child: Text('Sign in')),
              FlatButton(
                  onPressed: () => authbloc.mapEvent(Register(email, password)),
                  child: Text('Sign up'))
            ],
          )
        ],
      ),
    );
  }
}
