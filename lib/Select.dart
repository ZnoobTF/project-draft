import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:main_draft/learning/Library.dart';
import 'package:main_draft/image_rec/TextRec.dart';
import 'package:main_draft/gpt_landing.dart';
class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.red,

      ),
      body: Center(
        child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children:<Widget> [
          Text("Welcome User!",style:TextStyle(fontSize:50,fontWeight:FontWeight.w500),),
          SizedBox(height:200),
          Text("Selection",style:TextStyle(fontSize:50,fontWeight:FontWeight.w500),),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:<Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Library()));
      },
              child:Container(

                color:Colors.grey,
                height:300,
                width: 150,
                child: Column(
                  children:<Widget>[
                    Text("Library",style:TextStyle(fontSize:22,fontWeight: FontWeight.bold)),
                    SizedBox(height:5),
                    Text("Learn and Search for Common ECG Terms",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize:16),textAlign: TextAlign.center,),
                    //Image.asset('',width:,scale:,)

                  ],
                ),
              ),
              ),
              GestureDetector(
                onTap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TextRecognitionScreen()));
                },
              child:Container(
                color:Colors.blueGrey,
                height:300,
                width:150,
                child: Column(
                  children:<Widget>[
                    Text("Interpretation",style:TextStyle(fontSize:22,fontWeight: FontWeight.bold)),
                    SizedBox(height:5),
                    Text("Image Interpreter for ECG Charts",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize:16),textAlign: TextAlign.center,),
                    //Image.asset('',width:,scale:,)
                  ],
                ),
              ),
              ),
          ]
          )
        ],
        ),
      ),
    );
  }
}
