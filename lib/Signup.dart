import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey=GlobalKey<FormState>();
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();
  final _confirmPasswordController= TextEditingController();

  Future<bool> createNewUser(String email, String password) async{
    try{
      final credential =await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e){
      print(e);
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up')
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child:Form(
          key:_formKey,
          child:Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  helperText: 'Email'
                ),
                validator: (String? email){
                  if (email==null || email.isEmpty){
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  helperText: 'Password'
                ),
                obscureText: true,
                validator: (String? password){
                  if (password==null||password.length<8){
                    return 'Please enter a password with at least 8 characters.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  helperText: 'Confirm Password'
                ),
                obscureText: true,
                validator: (String? password){
                  if(password!=_passwordController.text){
                    return 'Passwords do not match.';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()){
                      try{
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text, password: _passwordController.text
                        ).then((_){
                          print('Succesfully created user');
                        });
                      } catch(e){
                        print(e);
                      }
                    }
                  },
                  child: const Text('Sign Up'),
                )
              )
            ],
          )
        )
      )
    );
  }
}
