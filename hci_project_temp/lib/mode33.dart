import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:page_transition/page_transition.dart';
import 'braille.dart';
import 'drawer.dart';
import 'mode333.dart';
import 'package:hci_project_temp/mode1.dart';
import 'package:hci_project_temp/mode2.dart';
import 'package:hci_project_temp/mode3.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class MyMode33 extends StatefulWidget{
  var str;
  MyMode33(var str, var i){
    this.str= str;
    _MyMode33State.i = i;
  }
  @override
  _MyMode33State createState() => _MyMode33State(str);
}
class _MyMode33State extends State<MyMode33>{
  static var txt = braille();
  var word;
  static var i=0;
  static var maxI =0;
  static var showChar = '';
  static var brailleWord;
  var check =List.generate(6, (index) => true);
  static var characterList;
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
  _MyMode33State(String str){
    word = str;
  }
  @override
  Widget build(BuildContext context){
    //문제를 일단 한번 한글자씩 더 읽어줌
    _changeWordToBraille();
    _speakProblem();
    _makeCheck();
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
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(showChar, style: TextStyle(fontSize:30.0, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: const EdgeInsets.only(left: 30,top: 30, right: 40,bottom: 40)
                    ,child: RaisedButton(
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      child: Text('1',style: TextStyle(color: Colors.white,fontSize: 100.0),),
                      onPressed: (){check[0]=true;_waitForCharacter(brailleWord[i][0]);},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    )
                ),
                Container(margin: const EdgeInsets.only(left: 40,top: 30, right: 30,bottom: 40),
                    child: RaisedButton(
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      child: Text('2',style: TextStyle(color: Colors.white,fontSize: 100.0),),
                      onPressed: (){check[1]=true;_waitForCharacter(brailleWord[i][1]);},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: const EdgeInsets.only(left: 30,top: 40, right: 40,bottom: 40),
                    child: RaisedButton(
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      child: Text('3',style: TextStyle(color: Colors.white,fontSize: 100.0),),
                      onPressed: (){check[2]=true;_waitForCharacter(brailleWord[i][2]);},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    )
                ),
                Container(margin: const EdgeInsets.only(left: 40,top: 40, right: 30,bottom: 40),
                    child: RaisedButton(
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      child: Text('4',style: TextStyle(color: Colors.white,fontSize: 100.0),),
                      onPressed: (){check[3]=true;_waitForCharacter(brailleWord[i][3]);},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: const EdgeInsets.only(left: 30,top: 40, right: 40,bottom: 40)
                    ,child: RaisedButton(
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      child: Text('5',style: TextStyle(color: Colors.white,fontSize: 100.0),),
                      onPressed: (){check[4]=true;_waitForCharacter(brailleWord[i][4]);},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    )
                ),
                Container(margin: const EdgeInsets.only(left: 40,top: 40, right: 30,bottom: 40),
                    child: RaisedButton(
                      color: Colors.black,
                      disabledColor: Colors.grey,
                      child: Text('6',style: TextStyle(color: Colors.white,fontSize: 100.0),),
                      onPressed: (){check[5]=true;_waitForCharacter(brailleWord[i][5]);},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
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
  }
  void _speakProblem(){
    //문제중 눌러야 하는 것 하나만 읽어줌 ->i번째 글자
    final FlutterTts tts = FlutterTts();
    var character;
    switch(characterList[i]){
      case 0 : character="초성 ㄱ";break;
      case 1 : character="초성 ㄴ";break;
      case 2 : character = "초성 ㄷ";break;
      case 3 : character = "초성 ㄹ";break;
      case 4 : character = "초성 ㅁ";break;
      case 5 : character = "초성 ㅂ";break;
      case 6 : character = "초성 ㅅ";break;
      case 7 : character = "초성 ㅈ";break;
      case 8 : character = "초성 ㅊ";break;
      case 9 : character = "초성 ㅋ";break;
      case 10 : character = "초성 ㅌ";break;
      case 11 : character = "초성 ㅍ";break;
      case 12 : character = "초성 ㅎ";break;
      case 13 : character = "된소리";break;
      case 14 : character = "종성 ㄱ";break;
      case 15 : character = "종성 ㄴ";break;
      case 16 : character = "종성 ㄷ";break;
      case 17 : character = "종성 ㄹ";break;
      case 18 : character = "종성 ㅁ";break;
      case 19 : character = "종성 ㅂ";break;
      case 20 : character = "종성 ㅅ";break;
      case 21 : character = "종성 ㅇ";break;
      case 22 : character = "종성 ㅈ";break;
      case 23 : character = "종성 ㅊ";break;
      case 24 : character = "종성 ㅋ";break;
      case 25 : character = "종성 ㅌ";break;
      case 26 : character = "종성 ㅍ";break;
      case 27 : character = "종성 ㅎ";break;
      case 28 : character = "중성 ㅏ";break;
      case 29 : character = "중성 ㅑ";break;
      case 30 : character = "중성 ㅓ";break;
      case 31 : character = "중성 ㅕ";break;
      case 32 : character = "중성 ㅗ";break;
      case 33 : character = "중성 ㅛ";break;
      case 34 : character = "중성 ㅜ";break;
      case 35 : character = "중성 ㅠ";break;
      case 36 : character = "중성 ㅡ";break;
      case 37 : character = "중성 ㅣ";break;
      case 38 : character = "중성 ㅐ";break;
      case 39 : character = "중성 ㅔ";break;
      case 40 : character = "중성 ㅚ";break;
      case 41 : character = "중성 ㅘ";break;
      case 42 : character = "중성 ㅝ";break;
      case 43 : character = "중성 ㅢ";break;
      case 44 : character = "중성 ㅖ";break;
      case 45 : character = "중성 ㅟ";break;
      case 46 : character = "중성 ㅒ";break;
      case 47 : character = "중성 ㅙ";break;
      case 48 : character = "중성 ㅞ";break;
      default : character = "준비중 입니다.";break;
    }
    showChar = character;
    final TextEditingController controller = TextEditingController(text:character) ;
    tts.setLanguage('ko-KR');
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
    tts.setPitch(1.0);
    tts.speak(controller.text);
  }
  void _changeWordToBraille() {
    //한번 설정되면 바꾸지 않음
    if (i != 0) {
      return;
    }
    var isKor = true;
    /*
    var isEng = false;
    var isNum = false;
    var engExp = new RegExp(r'^[a-zA-Z]+S');
    var korExp = new RegExp(r'^[ㄱ-ㅎ가-힣]+$');
    var numExp = new RegExp(r'[0-9]+$');

    if (engExp.hasMatch(word))
      isEng = true;
    if (korExp.hasMatch(word))
      isKor = true;
    if (numExp.hasMatch(word))
      isNum = true;
     */
    var tempWord = List.generate(
        word.length, (index) => word.codeUnitAt(index));
    var tempLength = 0;
    /*
      한글
      초성 = ((X - 0xAC00) / 28) / 21
      중성 = ((X - 0xAC00) / 28) % 21
      종성 = (X - 0xAC00) % 28
       */
    if (isKor) {
      for (var j = 0; j < tempWord.length-1; j++) {
        var isAorD = ((tempWord[j] - 0xAC00) / 28 / 21).floor();
        if(isAorD==11){
          tempLength++;
        } else if(isAorD==1||isAorD==4||isAorD==8||isAorD==10||isAorD==13){
          tempLength+=3;
        } else{
          tempLength+=2;
        }
        var isDjong = (tempWord[j] - 0xAC00) % 28;
        if (isDjong!=0) {
          tempLength++;
          if(isDjong==2||isDjong==3||isDjong==5||isDjong==6||isDjong==9
              ||isDjong==10||isDjong==11||isDjong==12||isDjong==13||isDjong==14
              ||isDjong==15||isDjong==18||isDjong==20){
            tempLength++;
          }
        }
      }
      print(tempLength);
      //log("$tempLength");
      var tempIndex = 0;
      var isDouble=false;
      characterList = List.generate(tempLength, (index) =>0);
      brailleWord = List.generate(tempLength, (index1) {
        var tempList = List.generate(6, (index2) => 0);
        var cho = 0,
            jung = 0,
            jong = 0;
        while (tempIndex<=tempWord.length*3-1) {
          if (tempIndex % 3 == 0) {
            //print(((tempWord[(tempIndex / 3).floor()] - 0xAC00) / 28 / 21).floor());
            if(!isDouble) {
              switch (((tempWord[(tempIndex / 3).floor()] - 0xAC00) / 28 / 21).floor()) {
                case 0 ://ㄱ
                  cho = 0;
                  break;
                case 1 ://ㄲ
                  cho = 13;
                  isDouble = true;
                  break;
                case 2 ://ㄴ
                  cho = 1;
                  break;
                case 3 ://ㄷ
                  cho = 2;
                  break;
                case 4 ://ㄸ
                  cho = 13;
                  isDouble = true;
                  break;
                case 5://ㄹ
                  cho = 3;
                  break;
                case 6://ㅁ
                  cho= 4;
                  break;
                case 7://ㅂ
                  cho = 5;
                  break;
                case 8://ㅃ
                  cho = 13;
                  isDouble = true;
                  break;
                case 9://ㅅ
                  cho = 6;
                  break;
                case 10://ㅆ
                  cho = 13;
                  isDouble = true;
                  break;
                case 11 ://ㅇ
                  cho = 27;
                  break;
                case 12://ㅈ
                  cho = 7;
                  break;
                case 13://ㅉ
                  cho = 13;
                  isDouble = true;
                  break;
                case 14 ://ㅊ
                  cho = 8;
                  break;
                case 15://ㅋ
                  cho = 9;
                  break;
                case 16://ㅌ
                  cho = 10;
                  break;
                case 17://ㅍ
                  cho = 11;
                  break;
                case 18://ㅎ
                  cho = 12;
                  break;
                default :
                  cho = 27;
                  break;
              }
            }else{
              isDouble = false;
              //print("isDouble=false");
              switch (((tempWord[(tempIndex / 3).floor()] - 0xAC00) / 28 / 21).floor()) {
                case 1 :
                  cho = 0;
                  break;
                case 4 :
                  cho = 2;
                  break;
                case 8:
                  cho = 2;
                  break;
                case 10:
                  cho = 5;
                  break;
                case 13:
                  cho = 6;
                  break;
                default :
                  cho = 27;
                  break;
              }
            }
            if(cho!=27) {
              for (var j = 0; j < 6; j++) {
                tempList[j] = txt.hangle[cho][j];
              }
              characterList[index1] = cho;
              if(!isDouble) {
                tempIndex++;
              }
              return tempList;
            }
            else{
              tempIndex++;
            }
            //log("$tempList");
          }
          if (tempIndex % 3 == 1) {
            //print((tempWord[(tempIndex / 3).floor()] - 0xAC00) / 28 % 21);
            switch (((tempWord[(tempIndex / 3).floor()] - 0xAC00) / 28 % 21)
                .floor()) {
              case 0 ://ㅏ
                jung = 28;
                break;
              case 1://ㅐ
                jung = 38;
                break;
              case 2://ㅑ
                jung = 29;
                break;
              case 3://ㅒ
                jung = 46;
                break;
              case 4://ㅓ
                jung = 30;
                break;
              case 5://ㅔ
                jung = 39;
                break;
              case 6://ㅕ
                jung = 31;
                break;
              case 7://ㅖ
                jung = 44;
                break;
              case 8://ㅗ
                jung = 32;
                break;
              case 9://ㅘ
                jung = 41;
                break;
              case 10://ㅙ
                jung = 47;
                break;
              case 11://ㅚ
                jung = 40;
                break;
              case 12://ㅛ
                jung = 33;
                break;
              case 13://ㅜ
                jung = 34;
                break;
              case 14://ㅝ
                jung = 42;
                break;
              case 15://ㅞ
                jung = 48;
                break;
              case 16://ㅟ
                jung = 45;
                break;
              case 17://ㅠ
                jung = 35;
                break;
              case 18://ㅡ
                jung = 36;
                break;
              case 19://ㅢ
                jung = 43;
                break;
              case 20://ㅣ
                jung = 37;
                break;
              default:
                jung = 28;
                break;
            }
            for (var j = 0; j < 6; j++) {
              tempList[j] = txt.hangle[jung][j];
            }
            //log("$tempList");
            characterList[index1] = jung;
            tempIndex++;
            return tempList;
          }
          else {
            //print((tempWord[(tempIndex / 3).floor()] - 0xAC00) % 28);
            if ((tempWord[(tempIndex / 3).floor()] - 0xAC00) % 28 != 0) {
              if(!isDouble) {
                switch ((tempWord[(tempIndex / 3).floor()] - 0xAC00) % 28) {
                  case 1 ://ㄱ
                    jong = 14;
                    break;
                  case 2://ㄲ
                    jong=13;
                    isDouble = true;
                    break;
                  case 3://ㄱㅅ
                    jong = 14;
                    isDouble = true;
                    break;
                  case 4://ㄴ
                    break;
                  case 5://ㄵ
                    jong = 15;
                    isDouble = true;
                    break;
                  case 6://ㄶ
                    jong = 15;
                    isDouble = true;
                    break;
                  case 7://ㄷ
                    jong = 16;
                    break;
                  case 8://ㄹ
                    jong = 17;
                    break;
                  case 9://ㄺ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 10://ㄻ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 11://ㄼ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 12://ㄽ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 13://ㄾ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 14://ㄿ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 15://ㅀ
                    jong = 17;
                    isDouble = true;
                    break;
                  case 16://ㅁ
                    jong = 18;
                    break;
                  case 17://ㅂ
                    jong = 19;
                    break;
                  case 18://ㅄ
                    jong = 19;
                    isDouble = true;
                    break;
                  case 19://ㅅ
                    jong = 20;
                    break;
                  case 20://ㅆ
                    jong = 13;
                    isDouble = true;
                    break;
                  case 21://ㅇ
                    jong = 21;
                    break;
                  case 22://ㅈ
                    jong = 22;
                    break;
                  case 23://ㅊ
                    jong = 23;
                    break;
                  case 24://ㅋ
                    jong = 24;
                    break;
                  case 25://ㅌ
                    jong = 25;
                    break;
                  case 26://ㅍ
                    jong = 26;
                    break;
                  case 27://ㅎ
                    jong = 27;
                    break;
                }
              }else{
                switch((tempWord[(tempIndex/3).floor()]-0xAC00)%28){
                  case 2 :
                    jong = 14;
                    break;
                  case 3:
                    jong = 20;
                    break;
                  case 5:
                    jong = 22;
                    break;
                  case 6:
                    jong = 27;
                    break;
                  case 9:
                    jong = 14;
                    break;
                  case 10:
                    jong = 18;
                    break;
                  case 11:
                    jong = 19;
                    break;
                  case 12:
                    jong = 20;
                    break;
                  case 13:
                    jong = 25;
                    break;
                  case 14:
                    jong = 26;
                    break;
                  case 15:
                    jong = 27;
                    break;
                  case 18:
                    jong = 20;
                    break;
                  case 20:
                    jong = 20;
                    break;
                  default :
                    jong = 14;
                    break;
                }
                isDouble=false;
              }
              for (var j = 0; j < 6; j++) {
                tempList[j] = txt.hangle[jong][j];
              }
              //log("$tempList");
              characterList[index1] = jong;
              if(!isDouble) {
                tempIndex++;
              }
              return tempList;
            }else{
              tempIndex++;
            }
          }
        }
      });
    }
    //log("$brailleWord");
    maxI = tempLength;
  }
  void _waitForCharacter(var c){
    //눌러야 하는 점자를 누른경우
    if(c==1) {
      //한글자가 온전히 눌렸는지 검사
      if (_isOneCaracterClear()) {
        //눌렸다면
        i++;
        if(i<maxI) {
          Navigator.push(context,PageTransition(child:  MyMode33(word, i), type: PageTransitionType.fade));
        }
        else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyMode333(true)));
        }
      }else{
        //안눌렸다면
        return;
      }
    }
    else {
      //누르지 말아야 하는 점자를 누른 경우
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyMode333(false)));
    }
  }
  bool _isOneCaracterClear(){
    //모든 점자가 눌렸는지 검사
    //모두 눌렸다면
    var isAllPushed = true;
    for(var j=0;j<6;j++)
      if(!check[j])
        isAllPushed=false;
    //아니라면
    return isAllPushed;
  }
  void _makeCheck(){
    for(var j=0;j<6;j++){
      if(brailleWord[i][j]==1) {
        check[j] = false;
      }
    }
  }
}