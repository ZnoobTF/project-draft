import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TipsPage extends StatefulWidget{
  const TipsPage({
    Key? key,
    //required this.sports,
    required this.ekg1,
    required this.ekg2,
    required this.gender,
    required this.age,
    //required this.info,
}): super(key:key);
  //final List<String> sports;
  final String ekg1;
  final String ekg2;
  final String gender;
  final int age;
  //final String info;
  @override
  State<StatefulWidget> createState(){
    return _TipsPageState();
  }
}

class _TipsPageState extends State<TipsPage>{
  late final OpenAI _openAI;
  bool _isLoading =true;
  String? tips;
  @override
  void initState(){
    _openAI=OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY'],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds:30),
      ),
    );
    _handleInitialMessage();
    super.initState();
  }
  Future<void> _handleInitialMessage() async{
    print("message*************************************");
    String userPrompt= "Pretend you are a professionally trained cardiologist. An EKG of me contains"
        "${widget.ekg1}, and"
        "${widget.ekg2}."
        "I am a ${widget.gender}, ${widget.age} years old."
        "Please explain what each of these mean. Provide a possible plan and detailed steps on what to do to eliminate these anomalies. Take into consideration my age and gender, and apply it to your responses. Do not write anything else.";

    final request= ChatCompleteText(
      messages: [
        Messages(
          role: Role.user,
          content: userPrompt,
        ),
      ],
      maxToken: 1500,
      model: GptTurboChatModel(),
    );
    ChatCTResponse? response=await _openAI.onChatCompletion(request: request);
    setState(() {
      print("****************************");
      tips= response!.choices.first.message!.content.trim();
      _isLoading=false;
      });
    print(tips);
  }
  @override
  Widget build(BuildContext context){
    return Container(
      height:500,
      width:100,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: !_isLoading
        ? ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              tips!,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        )
            :
              Container(
                margin: const EdgeInsets.all(20),
                child: const CircularProgressIndicator(),
              )

      )
    );
  }
}