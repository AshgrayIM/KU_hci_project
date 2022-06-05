import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hci_project_temp/mode22.dart';
import 'drawer.dart';
import 'package:hci_project_temp/mode1.dart';
import 'package:hci_project_temp/mode3.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
class MyMode2 extends StatefulWidget{
  @override
  _MyMode2State createState() => _MyMode2State();
}
class _MyMode2State extends State<MyMode2>{
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  var word = "";

  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if(!_lastWords.contains("변환")){
        if(_lastWords.contains("교육")){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode1(0)));
        }else if(_lastWords.contains("퀴즈")){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
        }
      }else{
        _lastWords.replaceAll("변환", "");
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('HCI Braille Education'),),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
    onPressed:
    // If not yet listening for speech start, otherwise stop
    _speechToText.isNotListening ? _startListening : _stopListening,
      tooltip: 'Listen',
      child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                // If listening is active show the recognized words
                _speechToText.isListening
                    ? '$_lastWords'
                // If listening isn't active but could be tell the user
                // how to start it, otherwise indicate that speech
                // recognition is not yet ready or not supported on
                // the target device
                    : _speechEnabled
                    ? 'Tap the microphone to start listening...'
                    : 'Speech not available',
              ),
            ),
            Text(_lastWords),
            Container(
              margin: EdgeInsets.all(40.0),
              child: RaisedButton(
                onPressed: (){
                  if(_lastWords.isEmpty){
                    print("단어가 입력안됐지만 무지성으로 감자 넣어버리기");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode22("감자",0)));
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode22(_lastWords,0)));
                  }
                },
                child: Text("변환하기!",style: TextStyle(fontSize: 40.0,),textAlign:TextAlign.center,),
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                elevation: 40.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}