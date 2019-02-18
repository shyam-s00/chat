import 'package:chat/models/User.dart';
import 'package:chat/screens/ChatScreen.dart';
import 'package:chat/shared/presentation/TextStyles.dart';
import 'package:chat/shared/services/CloudStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginScreenState();

  final CloudStore auth;

  LoginScreen() : this.auth = new CloudStore();
}

class LoginScreenState extends State<LoginScreen> {

  var _formKey = new GlobalKey<FormState>();

  String _email;
  String _pwd;
  bool _showError = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          key: new Key('loginAppBar'), 
          title: new Text('Login', style: TextStyles.appBarHeadingBold1)
        ),
        body: new Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: new Form(
            key: _formKey,
            child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                child: new TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username / email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) => value.isEmpty ? 'Email cannot be empty' : null,
                  onSaved: (value) => _email = value
                ),
              ),
              new SizedBox(
                height: 25,
              ),
              new SizedBox(
                child: TextFormField(
                  maxLines: 1,                  
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  onSaved: (value) => _pwd = value,
                  controller: _pwdController,
                  validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
                ),
              ),
              new SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Builder(
                  builder: (ctx) => RaisedButton(
                      colorBrightness: Brightness.light,
                      onPressed: () => loginWithEmail(ctx),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text('Sign in'),
                      elevation: 8.0,
                      color: Theme.of(context).buttonColor
                  ),
                ),
              ),
              Visibility(
                visible: _showError,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: TextFormField(
                  enabled: false,
                  initialValue: 'Incorrect username or password.',
                  decoration: InputDecoration.collapsed(hintText: null),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                    wordSpacing: 2,
                  )
                )
              ),
            ],
          ),
          )
        )
      );
  }

  Future<User> loginWithEmail(BuildContext context) async {
    var form = _formKey.currentState;
    setState(() {
      _showError = false;
    });
    if (form.validate()) {
      form.save();
      User user;
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context )  {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Center(
                heightFactor: 3,
                widthFactor: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(strokeWidth: 6.0),
                    SizedBox(width: 20),
                    Text('Signing in ...', style: Theme.of(context).textTheme.subhead)
                  ],
                ),
              )
            );
          }
        );
        user = await widget.auth.login(_email, _pwd);
        Navigator.of(context).pop();

        if (user != null) {
          Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) => new ChatScreen(user)));
        }
      }
      on PlatformException {
        setState(() {
          _showError = true;
        });
        Navigator.of(context).pop();

        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Login Failed.")));
      }
      return user;
    }
    return Future.value(null);
  }
}
