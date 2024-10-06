import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_draft/Select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_draft/image_rec/TextRec.dart';
import 'package:main_draft/Signup.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:<Widget>[
          const Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children:[
                CircleAvatar(
                  radius:80,
                    //backgroundImage: NetworkImage('')
                ),
                const Text("Login",
                    textAlign: TextAlign.center,
                  style:TextStyle(
                   fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:Colors.black87,
                  )
                ),
                LoginForm(),
              ]
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              const Text("Not an existing user?",
                style:TextStyle(fontWeight: FontWeight.bold, fontSize:15)
              ),
              GestureDetector(
                onTap:(){
                  print("User has clicked on Register");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SignupPage()));
                },
                child: const Text("Register Here",
                style:TextStyle(fontSize: 15,color:Colors.blue),)
              )
            ],
          ),
        ]
      ),
    );
  }
}
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey=GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loginError=false;
  bool _obscureText=true;

  Future<bool> signIn(String email, String password) async{
    try{
      final credential =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:<Widget>[
         const SizedBox(height:20),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              prefixIcon:Icon(Icons.email_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )
              )
            ),
            validator:(value){
              if(value!.isEmpty){
                return "This field cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height:10),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                )
              ),
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _obscureText =!_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off: Icons.visibility,
                )
              )
            ),
            obscureText: _obscureText,
          ),
          SizedBox(height:10),
          _loginError ? const Text('Invalid Login Information'): Container(),
          SizedBox(height:10),
          ElevatedButton(
            onPressed: (){
              print("Submitted Login Details");
              signIn(_emailController.text,_passwordController.text).then(
                  (bool success) {
                    if (success) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const SelectionPage()));
                      print('Successfully signed in');
                    }
                    setState(() {
                      _loginError = !success;
                    });
                  }
              );
            },
            child: Text("Login"),
          ),
        ]
      )
    );
  }
}
