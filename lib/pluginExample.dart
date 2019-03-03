import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MyApp());
}



//用无状态控件显示
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //主题色
      theme: ThemeData(
        //设置为蓝色
          primarySwatch: Colors.red),
      //这是一个Widget对象，用来定义当前应用打开的时候，所显示的界面
      home: PluginTest(),
    );
  }
}
//主框架
class PluginTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PluginTestState();
  }
}



class _PluginTestState extends State<PluginTest> {
  //创建通道名称 必须唯一
//  static const platform = const MethodChannel('sample.flutter.io/data');
//  String _data;
//
//  Future<Null> _returndata() async{
//    String data;
//    try{
//      final int resultData = await platform.invokeMethod('data');
//      data = "平台返回数值：$resultData";
//    }catch(e){
//      data = "错误：${e.message}";
//    }
//
//    //状态更新
//    setState(() {
//      _data = data;
//    });
//
//  }


    static const platform = const MethodChannel('samples.flutter.io/battery');
    //电池电量
    String _batteryLevel = 'Unknown battery level.';

    Future<Null> _getBatteryLevel() async {
      String batteryLevel;

      try{
        final int result = await platform.invokeMethod('getBatteryLevel');
        batteryLevel = "Battery level at $result%.";

      } on PlatformException catch (e){
        batteryLevel = "Failed to get battery level: '${e.message}'.";
      }

      //状态更新
      setState((){
        _batteryLevel = batteryLevel;
      });

    }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar
      appBar: AppBar(
        title: Text("插件例子"),
        //标题居中
        centerTitle: true,
      ),
      body:new Center(
        child: Text("$_batteryLevel"),
      ),
      floatingActionButton : FloatingActionButton(
          onPressed: _getBatteryLevel,
          tooltip: "获取平台返回的值",
          child: new Icon(Icons.audiotrack)
      ),

    );
  }

}












