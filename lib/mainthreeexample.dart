import 'package:flutter/material.dart';

void main() {
  //运行程序
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
       home:new MyHomeWidget(),
    );
  }
}


class MyHomeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    //实现标题栏
     Widget titleWidget = new Container(
       //内边距
       padding:const EdgeInsets.all(30.0),
       //整体是一个水平的布局
       child:new Row(
         //只有一个孩子
         children: <Widget>[
           //用Expanded 会占用icon之外剩余空间
           new Expanded(
               //垂直布局 放置两个文本
               child: new Column(
                 //设置文本一起始端对齐
                 crossAxisAlignment: CrossAxisAlignment.start,
                 //有两个孩子
                 children: <Widget>[
                   new Container(
                     //底部内边距
                     padding:const EdgeInsets.only(bottom:10.0),
                     //孩子 设置字体样式
                     child:new Text(
                       'Oeschinen Lake Campground',
                       style: new TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ),
                   new Text(
                     'Kandersteg, Switzerland',
                     style: new TextStyle(
                       color:Colors.grey[450],//设置颜色透明度
                     ),
                   )
                 ],
               ),
           ),
           new Icon(
             Icons.star,
             color:Colors.red[400],
           ),

           new Text('41'),
         ],
       ),
     );

     /**
      * 抽取button行的代码复用
      *
      */
     Column getText(IconData icon,String text){
         return new Column(
           //聚集widgets
           mainAxisSize:MainAxisSize.min,
           //child居中
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             new Icon(icon,color:Colors.blue[500]),
             new Container(
               //上部外边距
               margin: const EdgeInsets.only(top:8.0),
               //Text内容样式设定
               child:new Text(
                 text,
                 style:new TextStyle(
                   color:Colors.blue[500],
                 ),
               ),
             )
           ],

         );

     }

     /**
      * 按钮实现
      */
     Widget buttonWidget = new Container(
       //三列
       child:new Row(
         //用MainAxisAlignment.spaceEvenly平均分配子空间
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         //孩子们
         children: <Widget>[
           getText(Icons.call, "CALL"),
           getText(Icons.near_me, "ROUTE"),
           getText(Icons.share, "SHARE"),
         ],
       ),
     );


     /**
      * 文本实现
      */
     Widget textWidget = new Container(
       alignment: Alignment.center,
       //设置内边距
        padding:const EdgeInsets.all(10.0),
        child:new Text(
           'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, '
               'it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, '
               'followed by a half-hour walk through pastures and pine forest, '
               'leads you to the lake, which warms to 20 degrees Celsius in the summer. '
               'Activities enjoyed here include rowing, and riding the summer toboggan run.',
          // softWrap: true,//属性表示文本是否应在软换行符（例如句点或逗号）之间断开。
          // textAlign: TextAlign.center,
         ),

     );
     return new Scaffold(
       //设置标题栏
       appBar: new AppBar(
           title:new Text('Flutter Demo'),
       ),
       //主体用ListView
       body:new ListView(
         children: <Widget>[
           //图片
           new Image.asset(
             'images/lake.jpg',
             width:600.0,
             height:240.0,
             //顺便设置图片属性
             fit:BoxFit.cover,
           ),

           //标题栏
           titleWidget,

           //按钮栏
           buttonWidget,

           //文本栏
           textWidget,
         ],

       ),
     );

  }
}