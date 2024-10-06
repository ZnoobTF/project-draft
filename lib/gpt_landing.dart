import 'package:flutter/material.dart';
import 'package:main_draft/chat_gpt/tips.dart';
class GPT_Landing extends StatelessWidget {
  const GPT_Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPT Landing"),
      ),
      body:ListView(

          children:<Widget>[
            TipsPage(ekg1:"MAT",ekg2:"sinus block", gender:"Female",age:78)
          ],
      )
    );
  }
}
