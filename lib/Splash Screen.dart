import 'package:flutter/material.dart';
import 'package:main_draft/Login.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}): super(key:key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    init();
  }
  Future<void> init() async{
      await Future.delayed(const Duration(seconds:2)).then((value){
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const LoginPage()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                CircleAvatar(
                  radius:100,
                  //backgroundImage: NetworkImage(''),
                ),
                const Text("Placeholder",
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                )
                ),
                const Spacer(),
                const Column(
                  children: [
                    Text(
                      'Version',
                      style: TextStyle(
                      )
                    ),
                    Text(
                      '1.0.0',
                      style:TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                )

              ],
            )
          ),
          Container(
            height: 30,
          )
        ],
      )
    );
  }
}
