import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hci_project_temp/mode22.dart';
import 'drawer.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
class MyMode2 extends StatefulWidget{
  @override
  _MyMode2State createState() => _MyMode2State();
}
class _MyMode2State extends State<MyMode2>{
  var word = "야";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('HCI Braille Education'),),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: (){
                  _speechToText();
                },
                child: Icon(Icons.mic_outlined, size: 230.0,),
                padding: EdgeInsets.all(50.0),
                shape: CircleBorder(),
                elevation: 40.0,
                color: Colors.orange,
                highlightColor: Colors.red,
              ),
            ),
            Container(
              margin: EdgeInsets.all(40.0),
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode22(word,0)));
                },
                child: Text("변환하기!",style: TextStyle(fontSize: 40.0,),textAlign:TextAlign.center,),
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                elevation: 40.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _speechToText() async{
    final speech = stt.SpeechToText();
    bool available = await speech.initialize( onStatus: (s){log("initialized!");}, onError: (s){log("unable to initialize");} );
    if ( available ) {
      speech.listen( onResult: (result){ word = result.recognizedWords;} );
    }
    else {
      print("The user has denied the use of speech recognition.");
    }
  }
}