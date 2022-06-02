import 'package:flutter/material.dart';
import 'drawer.dart';
import 'mode3.dart';
import 'package:hci_project_temp/mode1.dart';
import 'package:hci_project_temp/mode2.dart';
import 'package:hci_project_temp/mode3.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
class MyMode333 extends StatefulWidget{
  MyMode333(var isCorrect){
    _MyMode333State.isCorrect = isCorrect;
  }
  @override
  _MyMode333State createState() => _MyMode333State();
}
class _MyMode333State extends State<MyMode333>{
  static var isCorrect = true;
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
        color: isCorrect? Colors.blue : Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isCorrect? "정답입니다!":"오답입니다.",style: TextStyle(fontSize: 70.0,fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.all(30.0),
                child: RaisedButton(
                    padding: EdgeInsets.all(20.0),
                    child: Text("다음 문제",style: TextStyle(fontSize: 70.0,fontWeight: FontWeight.bold),),
                    color: isCorrect? Colors.white : Colors.yellow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyMode3(isCorrect,false)));
                  }
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
      ),
    );
  }
}