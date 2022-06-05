import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hci_project_temp/drawer.dart';
import 'package:page_transition/page_transition.dart';
import 'braille.dart';
import 'package:vibration/vibration.dart';
import 'package:hci_project_temp/mode2.dart';
import 'package:hci_project_temp/mode3.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'mode3.dart';

class MyMode1 extends StatefulWidget{
  MyMode1(var start){
    _MyMode1State.i=start;
  }
  @override
  _MyMode1State createState() => _MyMode1State();
}
class _MyMode1State extends State<MyMode1>{
  static var i=0;
  static var maxI = 49;
  static var showChar = '';
  static var txt = braille();
  var check =List.generate(6, (index) => true);
  final audio = AudioCache();
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
  Widget build(BuildContext context){
    if(i<maxI) {
      _makeCheck();
      _speakWord();
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
              Text(showChar, style: TextStyle(fontSize:30.0, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: const EdgeInsets.only(
                      left: 30, top: 30, right: 40, bottom: 40)
                      , child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        child: Text('1', style: TextStyle(
                            color: Colors.white, fontSize: 80.0),),
                        onPressed: txt.hangle[i][0] == 0 ? null : () {
                          _vibrate();
                          check[0] = true;
                          _checkClear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      )
                  ),
                  Container(margin: const EdgeInsets.only(
                      left: 40, top: 30, right: 30, bottom: 40),
                      child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        child: Text('2', style: TextStyle(
                            color: Colors.white, fontSize: 80.0),),
                        onPressed: txt.hangle[i][1] == 0 ? null : () {
                          _vibrate();
                          check[1] = true;
                          _checkClear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: const EdgeInsets.only(
                      left: 30, top: 40, right: 40, bottom: 40),
                      child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        child: Text('3', style: TextStyle(
                            color: Colors.white, fontSize: 80.0),),
                        onPressed: txt.hangle[i][2] == 0 ? null : () {
                          _vibrate();
                          check[2] = true;
                          _checkClear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      )
                  ),
                  Container(margin: const EdgeInsets.only(
                      left: 40, top: 40, right: 30, bottom: 40),
                      child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        child: Text('4', style: TextStyle(
                            color: Colors.white, fontSize: 80.0),),
                        onPressed: txt.hangle[i][3] == 0 ? null : () {
                          _vibrate();
                          check[3] = true;
                          _checkClear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(margin: const EdgeInsets.only(
                      left: 30, top: 40, right: 40, bottom: 40)
                      , child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        child: Text('5', style: TextStyle(
                            color: Colors.white, fontSize: 80.0),),
                        onPressed: txt.hangle[i][4] == 0 ? null : () {
                          _vibrate();
                          check[4] = true;
                          _checkClear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      )
                  ),
                  Container(margin: const EdgeInsets.only(
                      left: 40, top: 40, right: 30, bottom: 40),
                      child: RaisedButton(
                        color: Colors.black,
                        disabledColor: Colors.grey,
                        child: Text('6', style: TextStyle(
                            color: Colors.white, fontSize: 80.0),),
                        onPressed: txt.hangle[i][5] == 0 ? null : () {
                          _vibrate();
                          check[5] = true;
                          _checkClear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      )
                  ),
                ],
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
    }else
      return Scaffold(
          appBar: AppBar(title: Text('HCI Braille Education'),),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("학습 완료!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 80.0),),
                Container(
                  margin: const EdgeInsets.only(left: 10.0,top: 15, right: 10.0,bottom: 16.0),
                  child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(10,30,10,30),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      child:Text("다시 하기",style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.white)),
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode1(0)));}
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0,top: 15, right: 10.0,bottom: 16.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(10,30,10,30),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    child: Text("점자 퀴즈", style: TextStyle(fontSize: 80.0,fontWeight: FontWeight.bold,color: Colors.white),),
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));},
                  ),
                )
              ]
            )
          ),
        drawer: MyDrawer(),
      );
  }
  void _checkClear(){
    var isAllPushed = true;
    for(var j=0;j<6;j++)
      if(!check[j])
        isAllPushed=false;
    if(isAllPushed){
      i++;
      if(i<=maxI)
        Navigator.push(context,PageTransition(child: MyMode1(i), type: PageTransitionType.fade));
    }
  }
  void _speakWord(){
    final FlutterTts tts = FlutterTts();
    var word="";
    switch(i){
      case 0 : word="초성 ㄱ";break;
      case 1 : word="초성 ㄴ";break;
      case 2 : word = "초성 ㄷ";break;
      case 3 : word = "초성 ㄹ";break;
      case 4 : word = "초성 ㅁ";break;
      case 5 : word = "초성 ㅂ";break;
      case 6 : word = "초성 ㅅ";break;
      case 7 : word = "초성 ㅈ";break;
      case 8 : word = "초성 ㅊ";break;
      case 9 : word = "초성 ㅋ";break;
      case 10 : word = "초성 ㅌ";break;
      case 11 : word = "초성 ㅍ";break;
      case 12 : word = "초성 ㅎ";break;
      case 13 : word = "된소리";break;
      case 14 : word = "종성 ㄱ";break;
      case 15 : word = "종성 ㄴ";break;
      case 16 : word = "종성 ㄷ";break;
      case 17 : word = "종성 ㄹ";break;
      case 18 : word = "종성 ㅁ";break;
      case 19 : word = "종성 ㅂ";break;
      case 20 : word = "종성 ㅅ";break;
      case 21 : word = "종성 ㅇ";break;
      case 22 : word = "종성 ㅈ";break;
      case 23 : word = "종성 ㅊ";break;
      case 24 : word = "종성 ㅋ";break;
      case 25 : word = "종성 ㅌ";break;
      case 26 : word = "종성 ㅍ";break;
      case 27 : word = "종성 ㅎ";break;
      case 28 : word = "중성 ㅏ";break;
      case 29 : word = "중성 ㅑ";break;
      case 30 : word = "중성 ㅓ";break;
      case 31 : word = "중성 ㅕ";break;
      case 32 : word = "중성 ㅗ";break;
      case 33 : word = "중성 ㅛ";break;
      case 34 : word = "중성 ㅜ";break;
      case 35 : word = "중성 ㅠ";break;
      case 36 : word = "중성 ㅡ";break;
      case 37 : word = "중성 ㅣ";break;
      case 38 : word = "중성 ㅐ";break;
      case 39 : word = "중성 ㅔ";break;
      case 40 : word = "중성 ㅚ";break;
      case 41 : word = "중성 ㅘ";break;
      case 42 : word = "중성 ㅝ";break;
      case 43 : word = "중성 ㅢ";break;
      case 44 : word = "중성 ㅖ";break;
      case 45 : word = "중성 ㅟ";break;
      case 46 : word = "중성 ㅒ";break;
      case 47 : word = "중성 ㅙ";break;
      case 48 : word = "중성 ㅞ";break;
      default: word="준비중 입니다.";break;
    }
    showChar = word;
    final TextEditingController controller = TextEditingController(text:word) ;
    tts.setLanguage('ko-KR');
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
    tts.setPitch(1.0);
    tts.speak(controller.text);
  }
  void _makeCheck(){
    for(var j=0;j<6;j++)
      if(txt.hangle[i][j]==1)
        check[j]=false;
  }
  void _vibrate(){
    Vibration.vibrate();
    audio.play("sound/waterdrop.mp3");
  }
}