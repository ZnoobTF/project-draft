import 'dart:io';
import 'package:main_draft/image_rec/results.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}): super(key:key);

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen>
  with WidgetsBindingObserver {
  late final ImagePicker _picker;
  String text= "";
  final textRecognizer = TextRecognizer();
  File? _image;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _picker= ImagePicker();
  }
  @override
  void dispose(){
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if (state==AppLifecycleState.inactive){
      //app going into background
    } else if (state==AppLifecycleState.resumed){
      //app going into foreground
    }
  }
  _imgFromCamera() async{
    final image=
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image=File(image!.path);
    });
  }

  _imgFromGallery() async{
    final image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image=File(image!.path);
    });
  }
  void _showPicker(){
    showModalBottomSheet(context: context, builder: (BuildContext bc){
      return SafeArea(child: Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap:(){
                _imgFromGallery();
                Navigator.of(context).pop();

              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap:(){
                _imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],

        ),
      ),
      );
    });
  }
  Future<void> _showMyDialog() async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder:(BuildContext context){
        return AlertDialog(
          title: Image.asset(
            'assets/replace.png',
            height:100,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children:<Widget>[
                Text("Do you want to change the current Image?"),
              ],
            ),
          ),
          actions:<Widget>[
            TextButton(
                onPressed: (){
                  _image=null;
                  _showPicker();
                },
                child: const Text("Yes"),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),

          ]
        );
      }
    );
  }
  Padding buildImageContainer(double width, double height){
    return Padding(
      padding: const EdgeInsets.only(top:12.0),
      child: Container(
        width: width,
        height: height *0.4,
        decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0,style:BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),),
        child: _image == null
          ? IconButton(
          icon: const Icon(
            Icons.camera_alt_outlined,
            size:80,
          ),
          onPressed:(){
            _showPicker();
          },
        )
            : Stack(
          children: [
            Container(
              width: width,
              height: height * 0.4,
              decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                side:BorderSide(width:1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),),
            ),
            Positioned(
              top: 5,
              right: 0,
              child: MaterialButton(
                onPressed: (){
                  _showMyDialog();
                },
                color: const Color.fromRGBO(31,150,247,1),
                child: const Icon(
                  Icons.edit,
                  size:24,
                ),
                shape: const CircleBorder(),
              )
            )
          ],
        )
      )
    );
  }

  Future<void> _processImage() async{
    try {
      final inputImage = InputImage.fromFile(_image!);
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      text=recognizedText.text;
      print(text);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultPage(resultText: text)));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error has occured when processing the image')
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    double width =MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("ECG Interpretation"),
        backgroundColor: Colors.red,
      ),
      body:Padding(
        padding: const EdgeInsets.only(left: 12, right:12, top:20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Select/Take ECG Picture",
                maxLines:2,
                textAlign: TextAlign.center,
                style:TextStyle(
                  fontSize:28,
                  fontWeight: FontWeight.bold,
                  color:Color.fromRGBO(50, 50, 50, 1),
                ),
              ),
              Container(
                height: 3,
                color: const Color.fromRGBO(50, 50, 50, 1),
              ),
              const SizedBox(
                height:10,
              ),
              buildImageContainer(width, height),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _image==null
                      ? Colors.grey
                      : const Color.fromRGBO(61, 137, 145, 1.0)),
                onPressed: () => _image==null?null:_processImage(),
                child: const Text('Process Image',
                style:TextStyle(color:Colors.white))
              ),
            ],
          )
        )
      )

    );
  }
}
