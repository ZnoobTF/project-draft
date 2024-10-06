import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key,required this.resultText});
  final String resultText;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
    _getAdvice();

    super.initState();
  }

  Future<void> _getAdvice() async{
    String instructionPrompt=
        "You are a cardiologist using our state-of-the-art medical diagnosis "
        "assistant. The system is designed to analyze patient data, including "
        "ECG parameters, and provide possible disease interpretations and health "
        "advice based on a comprehensive medical knowledge base. Your task is to "
        "interact with the system and provide guidance to patients based on the "
        "interpretation results and advice presented in text form, considering "
        "the input data, ECG parameters, and conclusions. Additionally, return "
        "a JSON structure containing the interpretation results and advice to "
        "facilitate further processing or integration with other systems. "
        "Please make sure that you only return a JSON format that looks like this: "
        '{"interpretation":<interpretations>, "explanation":<more explanation. '
        'Explain the medical terms and use common terms that patient can understand>,"advice":<health advice and what patient can do>}. '
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
        title: Text("ECG Interpretation"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: !_isLoading
          ? ListView(children:[
            const SizedBox(height:20),
          const Text(
            'Interpretation',
            style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height:4),
          Text(
            _advice['interpretation'],
            style: const TextStyle(fontSize:20),
          ),
          const SizedBox(height:20),
          const Text(
            'Explanation',
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            _advice['explanation'],
            style: const TextStyle(fontSize:20),
          ),
          const SizedBox(height:20),
          const Text(
            'Advice',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height:4),
          Text(
            _advice['advice'],
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
