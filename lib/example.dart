import 'package:flutter/material.dart';
import 'dart:convert';//解码和编码JSON
import 'package:http/http.dart' as my_http;
import 'model/ViewResult.dart';
import 'model/ResultModel.dart';



//app入口
void main() {
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
      home: BigPhotoWidget(),
    );
  }
}
//主框架
class BigPhotoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BigPhotoState();
  }
}

class _BigPhotoState extends State<BigPhotoWidget> {
  ViewResult viewresult;
  //具体的数据集合
  List<ResultModel> resultLists = [];
  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async{
    try{
      //因为导入http 用了as xxx方式，所以对象请求都用xxx.get方式
      //方式一
//      await my_http.get("http://gank.io/api/data/福利/10/1")
//      .then((response){
//        if(response.statusCode == 200){
//          var ViewData = json.decode(response.body);
//          viewresult = ViewResult(ViewData);
//          if(!viewresult.error){
//            //继续解析
//            for(int i = 0;i < viewresult.list.length;i++){
//              resultLists.add(viewresult.list[i]);
//            }
//            //记得调用刷新
//            setState(() {
//
//            });
//          }
//        }else{
//          print("error");
//        }
//      });
      //方式二 请求
      var response = await my_http.get("http://gank.io/api/data/福利/10/1");
      //判断状态
      if(response.statusCode == 200){
          //解析
          var ViewData = json.decode(response.body);
          viewresult = ViewResult(ViewData);
          if(!viewresult.error){
            //继续解析
            for(int i = 0;i < viewresult.list.length;i++){
              resultLists.add(viewresult.list[i]);
            }
            //记得调用刷新
            setState(() {

            });
          }
        }else{
          print("error");
        }
    }catch(e){
      print(e);

    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar
      appBar: AppBar(
        title: Text("妹子图"),
        //标题居中
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: resultLists.length,
          itemBuilder: (BuildContext context,int index){
            return Column(
              children: <Widget>[
                photoWidget(resultLists,index),
              ],
            );
          },
      ),
    );
  }
}


//需要传list 和对应下标
Widget photoWidget(List<ResultModel> resultLists,int index){
  return Card(
    child: Container(
      height: 300,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(resultLists[index].url,
                fit:BoxFit.fitWidth,
                //scale: 2.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );

}







