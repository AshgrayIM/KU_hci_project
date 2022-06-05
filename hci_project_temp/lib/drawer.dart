import 'package:flutter/material.dart';
import 'mode1.dart';
import 'mode2.dart';
import 'mode3.dart';

class MyDrawer extends Drawer{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text("HCI\nBraille Education",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))),),
          ListTile(
            title: Text("점자 교육",style: TextStyle(fontSize: 50.0),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode1(0)));
            },),
          ListTile(
            title: Text("점자 변환",style: TextStyle(fontSize: 50.0),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode2()));
            },),
          ListTile(
            title: Text("점자 퀴즈",style: TextStyle(fontSize: 50.0),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyMode3(false,true)));
            },),
        ],
      ),
    );
  }
}