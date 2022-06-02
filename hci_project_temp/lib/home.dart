import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hci_project_temp/drawer.dart';
import 'package:hci_project_temp/mode1.dart';
import 'package:hci_project_temp/mode2.dart';
import 'package:hci_project_temp/mode3.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
class MyHome extends StatefulWidget{
  @override
  _MyHomeState createState() => _MyHomeState();
}
class _MyHomeState extends State<MyHome>{
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

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
      if(_lastWords.contains("교육")){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode1(0)));
      }else if(_lastWords.contains("변환")){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode2()));
      }else if(_lastWords.contains("퀴즈")){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    _permissionCheck();
    return Scaffold(
      //앱바로 타이틀을 보여준다.
      appBar: AppBar(title: Text("HCI Braille Education"),),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed:
        // If not yet listening for speech start, otherwise stop
        _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      //버튼을 가운데 정렬로 보여준다.
      body: Center(
        //세개의 모드가 있으므로 세개의 버튼을 column에 넣어서 보여줌
        child: Column(
          children: [
            //첫번째 버튼 Mode1 점자 교육
            Container(
              margin: const EdgeInsets.only(left: 10.0,top: 15, right: 10.0,bottom: 16.0),
              child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(10,30,10,30),
                  child: Text("점자 교육", style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),),
                  color: Colors.yellow,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode1(0)));
                  },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            //두번째 버튼 mode2 점자 변환
            Container(
              margin: const EdgeInsets.only(left: 10.0,top: 15.0, right: 10.0,bottom: 15.0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(10,30,10,30),
                child: Text("점자 변환", style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),),
                color: Colors.green,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode2()));
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            //세번째 버튼 mode3 점자 퀴즈
            Container(
              margin: const EdgeInsets.only(left: 10.0,top: 15.0, right: 10.0,bottom: 15.0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(10,30,10,30),
                child: Text("점자 퀴즈", style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold),),
                color: Colors.red,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
  void _permissionCheck() async{
    log("_permissionCheck()");
    var status = await Permission.microphone;
    if(await status.isDenied){
      status.request();
    }
  }
}