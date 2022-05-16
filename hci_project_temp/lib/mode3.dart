import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hci_project_temp/mode33.dart';
import 'drawer.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  @override
  Widget build(BuildContext context){
    if(problemNum==0) {
      if(score==100)
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          body: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n축하합니다!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0,),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
                  )
                ],
              ),
            ),
          ),
        );
      else if(score>=80)
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          body: Container(
            color: Colors.green,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n아쉽네요T.T",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0,),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
                  )
                ],
              ),
            ),
          ),
        );
      else if(score>=50)
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          body: Container(
            color: Colors.orange,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n분발하세요!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0,),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
                  )
                ],
              ),
            ),
          ),
        );
      else
        return Scaffold(
          appBar: AppBar(title: Text("HCI Braille Education"),),
          drawer: MyDrawer(),
          body: Container(
            color: Colors.red,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${score}점\n다시 공부\n하세요...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 65.0,),textAlign: TextAlign.center,),
                  RaisedButton(
                      child: Text("다시하기",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70.0),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.yellow,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
                      }
                  )
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
            Text(problemNum.toString(), style: TextStyle(fontSize:100.0, fontWeight: FontWeight.bold),),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                  child: Icon(Icons.volume_up_rounded,size: 230,),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(40.0),
                  color: Color(0xFF386D3A),
                  highlightColor: Color(0xFF5EDB63),
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
            )
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