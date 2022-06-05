import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hci_project_temp/mode33.dart';
import 'drawer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hci_project_temp/mode1.dart';
import 'package:hci_project_temp/mode2.dart';
import 'package:hci_project_temp/mode3.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
class MyMode3 extends StatefulWidget{
  MyMode3(bool isCorrect,bool isStart){
    if(isCorrect) {
      _MyMode3State.score += 10;
    }
    if(isStart) {
      _MyMode3State.score = 0;
      _MyMode3State.problemNum=10;
    }
  }
  @override
  _MyMode3State createState() => _MyMode3State();
}
class _MyMode3State extends State<MyMode3>{
  static var score = 0; //사용자의 점수
  static var problemNum = 0; //사용자가 풀어야 하는 문제수
  var word = "";  //사용자가 풀어야 하는 문제
  static var wordList;
  static var wordListLength=1;
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
    if(problemNum==0) {
      if(score==100)
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n축하합니다!",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 70.0,),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
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
          ),
        );
      else if(score>=80)
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n아쉽네요T.T",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0,color: Colors.white,),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
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
          ),
        );
      else if(score>=50)
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n분발하세요!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0,color: Colors.white),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
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
          ),
        );
      else
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n다시 공부\n하세요...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 65.0,color: Colors.white),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
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
          ),
        );
    }
    _speakInfo();

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
              child: FutureBuilder(
                  future: _loadAsset("assets/word.txt"),
                  builder: (context, snapshot){
                   var rows = snapshot.data.toString().split('\n');
                   wordList=List.generate(rows.length, (index){
                     return rows[index];
                   });
                   wordListLength=rows.length;
                   _randomWord();
                   return Text("");
                  }
                ),
            ),
            Text(problemNum.toString(), style: TextStyle(fontSize:90.0, fontWeight: FontWeight.bold),),
            Container(
              margin: EdgeInsets.all(20.0),
              child: RaisedButton(
                  child: Icon(Icons.volume_up_rounded,size: 200,color: Colors.white),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(40.0),
                  color: Colors.black,
                  highlightColor: Colors.grey,
                  //짧게 누르면 문제 듣기/다시듣기
                  onPressed: (){
                    _speakProblem();
                  },
                  //길게 누르면 문제 풀기
                  onLongPress: (){
                    problemNum--;
                    print(word);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode33(word,0)));
                  },
              ),
            ),
            TextButton(
              onPressed: () {
                print(word);
              },
              child: Text("디버깅용 단어출력"),
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
  void _speakInfo(){
    //퀴즈 규칙, 남은 문제수, 푼 문제수 등의 정보를 음성으로 안내함
    final FlutterTts tts = FlutterTts();
    final TextEditingController controller = TextEditingController(
        text:"버튼을 눌러서 소리를 듣고 길게 눌러서 문제를 풀어보세요. 남은 문제는 10문제중 $problemNum문제입니다."
    ) ;
    tts.setLanguage('ko-KR');
    tts.setSpeechRate(0.5);
    tts.setVolume(1.0);
    tts.setPitch(1.0);
    tts.speak(controller.text);
  }
  void _randomWord () {
    var random = Random();
    word=wordList[random.nextInt(wordListLength)];
    //word = "야구장";
    print("setting new Word:${word}");
  }
  void _speakProblem(){
    //문제를 읽어줌
    final FlutterTts tts = FlutterTts();
    final TextEditingController controller = TextEditingController(text:word) ;
    tts.setLanguage('ko-KR');
    tts.setSpeechRate(0.3);
    tts.setVolume(1.0);
    tts.setPitch(1.0);
    tts.speak(controller.text);
  }
  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
}