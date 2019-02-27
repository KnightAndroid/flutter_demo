import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


void main(){
  runApp(
    new MaterialApp(
      title: 'Load File',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home:new LoadFile(),
    ),
  );
}



class LoadFile extends StatefulWidget {

  LoadFile({Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState(){
      return _LoadFileState();
  }
}

class _LoadFileState extends State<LoadFile>{
   @override
   void initState(){
     super.initState();
   }

   @override
   Widget build(BuildContext context){
     return new Scaffold(
       appBar: new AppBar(
         title: new Text("LoadFile"),
       ),
       body: new Center(
         child: RaisedButton(
             child: Text("获取文件路径"),
             //点击调用获取文件路径方法
             onPressed: loadPath,
         ),
       ),
     );
   }
}

loadPath() async{
    try{
      //临时目录
      var _tempDir = await getTemporaryDirectory();
      //获取具体路径
      String tempDirPath = _tempDir.path;
      //文档目录
      var _document = await getApplicationDocumentsDirectory();
      String documentPath = _document.path;
      //sd卡目录
      var _sdCard = await getExternalStorageDirectory();
      String sdCardPath = _sdCard.path;

      //打印路径
      print("临时目录:"+ tempDirPath);
      print("文档目录："+ documentPath);
      print("sd卡目录："+ sdCardPath);

    }catch(err){
       print(err);
    }
}






