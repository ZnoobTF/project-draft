import 'package:flutter/material.dart';
import 'package:main_draft/learning/elements.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
class element_result extends StatefulWidget {
  const element_result({super.key,required this.resultText});
  final String resultText;

  @override
  State<element_result> createState() => _element_resultState();
}

class _element_resultState extends State<element_result> {
  late final OpenAI _openAI;
  bool _isLoading =true;
  Map _advice = {};
  List<bool> selectedLessons=[];
  @override
  void initState(){
    _openAI =OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY'],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _getInfo();

    super.initState();
  }

  Future<void> _getInfo() async{
    String instructionPrompt=
        "You are a cardiologist using our state-of-the-art medical diagnosis "
        "assistant. The system has a library with different elements and terminology that commonly appear on"
        "ECGs. Your job is to analyze and define the element or terminology that you are presented with in the input data."
        "Please make sure that you only return a JSON format that looks like this: "
        '{"name":<name of element>, "definition":<define the element. '
        'Explain the medical terms and use common terms that a patient without understanding in cardiology can understand. Go in depth and explain what the element does>}. '
        "Ensure the JSON is valid and do not write anything before or after the "
        "JSON structure provided.";
    String userPrompt ="this input data: ${widget.resultText}";
    final request = ChatCompleteText(
      messages: [
        Messages(
          role: Role.system,
          content: instructionPrompt,
        ),
        Messages(
          role: Role.user,
          content: userPrompt,
        ),
      ],
      maxToken: 2500,
      model: GptTurboChatModel(),
    );
    ChatCTResponse? response =await _openAI.onChatCompletion(request: request);

    setState(() {
      String result=response!.choices.first.message!.content.trim();
      // print(result);

      try{
        _advice =Map<String, dynamic>.from(json.decode(result));
        _isLoading=false;
        print(_advice);
      } catch(e) {
        print('Error parsing JSON: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resultText),
        backgroundColor: Colors.red,
      ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: !_isLoading
              ? ListView(children:[
            const SizedBox(height:20),
            const Text(
              'Name',
              style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height:4),
            Text(
              _advice['name'],
              style: const TextStyle(fontSize:20),
            ),
            const SizedBox(height:20),
            const Text(
              'Definition',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _advice['definition'],
              style: const TextStyle(fontSize:20),
            ),
            const SizedBox(height:20),
          ])
              :Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(),
            ),
          ),
        )

    );
  }
}
