import 'package:flutter/material.dart';
import 'package:main_draft/learning/elements.dart';
import 'package:main_draft/learning/element_result.dart';
class LibraryHelper extends StatelessWidget {
  final Elements element;
  const LibraryHelper({super.key,required this.element});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        print("User has clicked on button");
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> element_result(resultText: element.name)));
      },
      child: Container(
      color: Colors.grey,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text(element.name.toUpperCase(),style:TextStyle(fontSize:20),textAlign: TextAlign.center),
        const SizedBox(height:5),

      ],
      ),
      ),
    );
  }
}
