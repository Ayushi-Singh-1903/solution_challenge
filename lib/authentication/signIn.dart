import 'package:flutter/material.dart';
import 'package:solution_challenge/service/auth.dart';

class SignIn extends StatefulWidget {
  final  toggleView;
  const SignIn({Key?key,this.toggleView}):super(key:key);


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password ='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },)
        ],
      ),
      body:Container(
        padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty?'Enter email':null,
                onChanged: (val){
                    setState(() => email=val);
                }
              ),
              SizedBox(height:20.0),
              TextFormField(
                  obscureText: true,
                  validator: (val) => val!.length<6?'Enter a password 6+ chars long':null,
                  onChanged: (val){
                    setState(() => password=val);
                  }
              ),
              SizedBox(height:20.0),
              ElevatedButton(
                  onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(()=>error='could not sign in with those credentials');
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),

              )
            ],
          )
        )
      ),
    );
  }
}