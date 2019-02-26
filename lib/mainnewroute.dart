
import 'package:flutter/material.dart';
class newRoute extends StatelessWidget{
  //接收上一个页面传递的数据
  String str;
  //构造函数
  newRoute(this.str);

  @override
  Widget build(BuildContext context){
    return HomeWidget(str);
  }
}

class HomeWidget extends StatelessWidget{
  String newDate;
  HomeWidget(this.newDate);

  @override
  Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
         title: Text('new Route'),
       ),
       body: Center(
         child:RaisedButton(
           //显示上一个页面所传递的数据
           child: Text(newDate),
             onPressed: (){
               Navigator.pop(context,"这是新页面返回的数据");
             }),
        // child: Text('这是新的页面'),
       ),
     );
  }
}