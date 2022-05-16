import 'package:flutter/material.dart';
import 'drawer.dart';
import 'mode3.dart';
class MyMode333 extends StatefulWidget{
  MyMode333(var isCorrect){
    _MyMode333State.isCorrect = isCorrect;
  }
  @override
  _MyMode333State createState() => _MyMode333State();
}
class _MyMode333State extends State<MyMode333>{
  static var isCorrect = true;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("HCI Braille Education"),),
      drawer: MyDrawer(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}