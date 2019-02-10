import 'package:chat/models/User.dart';
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
                height: 25,
              ),
              Builder(
                builder: (ctx) => new MaterialButton(
                onPressed: () => loginWithEmail(ctx),
                child: new Text('Login'),
                elevation: 5.0,
                color: Theme.of(context).buttonColor
                ),
              ),
            ],
          ),
          )
        )
      );
  }

  Future<User> loginWithEmail(BuildContext context) async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      User user;
      try {
        user = await widget.auth.login(_email, _pwd);

        if (user != null) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(user.email + " Logged in Sucessfully")));
        }
      }
      on PlatformException catch(pe) {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(_email + " is not valid")));
      }


      return user;
    }
    return Future.value(null);
  }
}
