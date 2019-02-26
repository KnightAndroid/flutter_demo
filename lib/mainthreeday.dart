import 'package:flutter/material.dart';

//使用toast
import 'package:fluttertoast/fluttertoast.dart';

//使用`flutter/material.dart` 目的是使用Matrial风格的小控件
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async'; //记得导库
//导入网络资源库

void main() {
  //运行程序
  runApp(MyApp());
}

////继承无状态的StatelessWidget 使程序自身变为Wiget
//class MyApp extends StatelessWidget{
//
//  //要显示的内容
//  final String text;
//
//  //数据内容可以通过构造方法传递进来
//  MyApp(this.text);
//
//  //重写build方法 返回你需要的控件
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Container(
//      //红色背景
//      color: Colors.red,
//      //高度 现在没用 会撑满整个屏幕
//      height: 200,
//      //宽度 撑满整个屏幕
//      width: 200,
//      //内容居中
//      alignment: Alignment.center,
//      //Text控件
//      child: new Text(
//          //Dart语法中 ?? 表示如果text为空，就会返回??号的内容
//          text ?? "my name is Knight",
//        textDirection: TextDirection.ltr,//需要加上这句不然报 RichText widgets require a Directionality widget ancestor.
//      ),
//
//    );
//  }
//}
//
////继承StatefulWidget
//class StateWidget extends StatefulWidget{
//
//   //负责创建tate
//   @override
//   State createState(){
//     return _StateWidget(null);
//   }
//}
//
//
////控件继承State
//class _StateWidget extends State<StateWidget>{
//
//  int Number = 0;
//  String text;
//
//
//  //构造函数
//  _StateWidget(this.text);
//
//  @override
//  void initState(){
//    //初始化，这个函数在控件的生命周期内调用一次
//    super.initState();
//    print("进入initState");
//    //3秒后改变text的内容
//    new Future.delayed(const Duration(seconds: 3),(){
//      setState(() {
//        Number++;
//        text = "已经改变数值，数值现在是$Number";
//      });
//
//    });
//  }
//
//  @override
//  void dispose(){
//    //销毁
//    super.dispose();
//    print('销毁');
//  }
//
//  @override
//  void didChangeDependencies(){
//    //在initState之后调
//     super.didChangeDependencies();
//     print('进入didChange');
//  }
//
//  //重写build方法
//  @override
//  Widget build(BuildContext context){
//    return Container(
//      //红色背景
//      color: Colors.red,
//      //内容居中
//      alignment: Alignment.center,
//      //Text控件
//      child: new Text(
//        //Dart语法中 ?? 表示如果text为空，就会返回??号的内容
//        text ?? "没改变数值",
//        textDirection: TextDirection.ltr,//需要加上这句不然报 RichText widgets require a Directionality widget ancestor.
//      ),
//
//    );
//  }
//}
//
//

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
      home: MyHomePageWidget(),
    );
  }
}

class MyHomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyHomePage();
  }
}

class MyHomePage extends State<MyHomePageWidget> {
  //获取TextEditingController
  final editController = TextEditingController();

  //图片路径
  String image_url =
      "https://ws1.sinaimg.cn/large/0065oQSqgy1fze94uew3jj30qo10cdka.jpg";
  //顶部显示数据
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'Android'),
    new Tab(text: 'IOS'),
    new Tab(text: 'Flutter'),
    new Tab(text: 'RN'),
    new Tab(text: 'Java'),
    new Tab(text: 'C'),
    new Tab(text: 'C++'),
    new Tab(text: 'Go'),
  ];
  //底部数据
  final Map bottomMap = {
    "首页": Icon(Icons.home),
    "朋友圈": Icon(Icons.camera),
    "信息": Icon(Icons.message),
    "其他": Icon(Icons.devices_other),
  };

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: myTabs.length, //Tab长度
      child: new Scaffold(
        //设置appbar
        appBar: new AppBar(
          //底部
          bottom: new TabBar(
            indicatorColor: Colors.red, //指示器颜色 如果和标题栏颜色一样会白色
            tabs: myTabs, //绑定数据
            isScrollable: true, //是否可以滑动
          ),
          //AppBar内容显示
          title: new Text('This is a Demo'),
          //前置图标
          leading: new Icon(Icons.home),
          //背景颜色 改为红色
          backgroundColor: Colors.red,
          //设置阴影
          elevation: 15,
          //设置为标题内容居中
          centerTitle: true,
          //一个 Widget 列表，代表 Toolbar 中所显示的菜单，
          // 对于常用的菜单，通常使用 IconButton 来表示；对于不常用的菜单通常使用 PopupMenuButton 来显示为三个点，点击后弹出二级菜单
          actions: <Widget>[
            //IconButton
            new IconButton(
              //图标
              icon: new Icon(Icons.add_a_photo),
              //提示
              tooltip: 'Add photo',
              //点击事件
              onPressed: () {
                print('text inputted: ${editController.text}');
                Fluttertoast.showToast(
                  msg: 'text inputted: ${editController.text}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                );
              },
            ),
            //菜单弹出按钮
            new PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                      value: "one", child: new Text('This one')),
                  new PopupMenuItem<String>(
                      value: "two", child: new Text('This two')),
                ];
              },
              onSelected: (String action) {
                switch (action) {
                  case "one":
                    //增加点击逻辑
                    break;
                  case "two":
                    //增加点击逻辑
                    break;
                }
              },
            ),
          ],
        ),
        //主体
//      body: new Center(
//        //Text在屏幕中央显示一个文本 改为自定义样式
//        //child: new CustomTextStyle('This is a Text'),
//
//        //富文本
//        //child:new RichWidget()
//
//        //文本输入框 以构造函数传递controller
//        //child:new TextFieldWidget(editController)
//
//        //图片加载
//        //child:new ImageWidget(image_url)
//
//        //FlatButton
//        //child:new FlatButtonWidget()
//      ),
        //contain布局
        //body:new ContainWidget(),

        //Padding布局
        //body: new PaddingWidget(),

        //Container嵌套Padding
        //body:new ContainPaddWidget(),

        //Center
        //body:new CenterWidget(),

        //Stack
        //body: new Center(child: new StackWidget()),

        //Column
        //body:new ColumnWidget(),

        //Row
        //body:new RowWidget(),

        //ListView
        //body: new ListViewWidget(
        //  new List<String>.generate(1000, (i) {
        //    return 'Item &i';
        //  }),
        //),

        //GridView
        //    body: new GridViewWidget(),

        //TabBarView
        body: new TabBarView(
          //选中哪个Tabs，body就会显示
          children: myTabs.map((Tab tab) {
            return new Center(child: new Text(tab.text));
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: () {
              var items = <BottomNavigationBarItem>[];
              bottomMap.forEach((k, v) {
                items.add(BottomNavigationBarItem(
                  title: Text(k), //取map的值
                  icon: v, //取map的图标
                  backgroundColor: Colors.red, //背景红色
                ));
              });
              return items;
            }(),
            currentIndex: _index, //选中第几个
            onTap: (position) {
              Fluttertoast.showToast(
                msg: 'text inputted: $position',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
              );
              setState(() {
                _index = position; //状态更新
              });
            }),
        //左侧抽屉
        drawer: Drawer(
          child: ListView(
            //设置padding
            padding: EdgeInsets.zero,
            children: <Widget>[
              //据说这里可以替换自定义的header
              //userHeader,
              ListTile(
                //标题内容
                title: Text("This is Item_one"),
                //前置图标
                leading: new CircleAvatar(
                  child: new Icon(Icons.scanner),
                ),
              ),
              ListTile(
                //标题内容
                title: Text("This is Item_two"),
                //前置图标
                leading: new CircleAvatar(
                  child: new Icon(Icons.list),
                ),
              ),
              ListTile(
                //标题内容
                title: Text("This is Item_three"),
                //前置图标
                leading: new CircleAvatar(
                  child: new Icon(Icons.score),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//文本 ： 单独文本样式
class CustomTextStyle extends StatelessWidget {
  Paint pg = Paint();
  String text;

  //构造函数 参数外部传进来
  CustomTextStyle(this.text);

  @override
  Widget build(BuildContext context) {
    //设置画笔颜色为黑色
    pg.color = Color(0xFF000000);
    return Text(
      text ?? "Hello",
      style: TextStyle(
          //颜色
          color: Colors.blue,
          //字体大小
          fontSize: 14,
          //字体加粗
          fontWeight: FontWeight.bold,
          //文本背景颜色
          background: pg),
    );
  }
}

//富文本样式
class RichWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'This is RichText',
      style: new TextStyle(
          //false的时候不显示
          inherit: true,
          //字体大小
          fontSize: 16,
          //黑色
          color: Colors.black),
      children: <TextSpan>[
        new TextSpan(
          text: 'Android艺术探索',
          style: new TextStyle(
            color: Colors.redAccent,
            //字体粗细
            fontWeight: FontWeight.bold,
          ),
        ),
        new TextSpan(text: '第一行代码'),
        new TextSpan(
          text: 'Android进阶之光',
          style: new TextStyle(
            color: Colors.indigo,
            //字体样式
            fontSize: 20,
          ),
        )
      ],
    ));
  }
}

//文本输入框
class TextFieldWidget extends StatelessWidget {
  final controller;

  //构造函数传值
  TextFieldWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      //最大长度,右下角会显示一个输入数量的字符串
      maxLength: 26,
      //最大行数
      maxLines: 1,
      //是否自动更正
      autocorrect: true,
      //是否自动对焦
      autofocus: true,
      //设置密码 true：是密码 false：不是秘密
      obscureText: true,
      //文本对齐样式
      textAlign: TextAlign.center,
    );
  }
}

//图片
class ImageWidget extends StatelessWidget {
  String image_url;

  ImageWidget(this.image_url);

  @override
  Widget build(BuildContext context) {
//      return Image(
//        //项目资源图片 方式一
//        //image: new AssetImage('images/Image_fluttericon.jpeg'),
//      );
    //项目资源图片 方式二
//    return Image.asset('images/Image_fluttericon.jpeg');
    // return Image.network(image_url);
    //return new
    return new CachedNetworkImage(
      imageUrl: image_url,
      //占位符
      placeholder: new CircularProgressIndicator(),
      //加载错误时显示的图片
      errorWidget: new Icon(Icons.error),
      //宽高
      width: 200,
      height: 200,
    );
  }
}

//按钮
class FlatButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Fluttertoast.showToast(
          msg: '你点击了FlatButton',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
        );
      },
      child: Text('FlatButton'),
      color: Colors.blue,
      //按钮背景色
      textColor: Colors.white,
      //文字的颜色
      onHighlightChanged: (bool b) {
        //水波纹变化回调
      },
      disabledColor: Colors.black,
      //按钮禁用时的显示的颜色
      disabledTextColor: Colors.black38,
      //按钮被禁用的时候文字显示的颜色
      splashColor: Colors.white, //水波纹的颜色
    );
  }
}

//Container布局
class ContainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("My name is Knight"),
      //  color: Colors.indigo, 得要去掉 不然和下面设置颜色冲突 运行报错
      width: 200,
      //宽
      height: 200,
      //高
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      //设置外边距
      padding: EdgeInsets.all(30),
      //内边距
      decoration: BoxDecoration(
        //设置边框
        //背景色
        color: Colors.redAccent,
        //圆角
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

//Padding布局
class PaddingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      //设置左上右下内边距为4，10，6，8
      padding: EdgeInsets.fromLTRB(4, 10, 6, 8),
      child: Text('My name is Knight'),
    );
  }
}

//Container嵌套Padding
class ContainPaddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, //宽
      height: 200, //高
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 10, 6, 8),
        child: Text("My name is Knight"),
      ),
      decoration: BoxDecoration(
        //设置边框
        //背景色
        color: Colors.redAccent,
        //圆角
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

//Center
class CenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, //宽
      height: 200, //高
      child: Center(
        child: Text("My name is Knight"),
      ),
      decoration: BoxDecoration(
        //设置边框
        //背景色
        color: Colors.redAccent,
        //圆角
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

//层叠布局
class StackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      //Aliginment的范围是[-1,1],中心是[0,0]注释有写
      //和Android一样，左移的取值是往1取，右移是往-1取
      //这里注意，它是取stack里范围最大的布局为基准，下面是以Container为基准对齐
      alignment: new Alignment(-0.6, -0.6),
      children: <Widget>[
        new Image.network(
          'https://ws1.sinaimg.cn/large/0065oQSqgy1fze94uew3jj30qo10cdka.jpg',
          width: 300.0, //宽
          height: 300.0, //高
        ),
        new Opacity(
          opacity: 0.6, //不透明度
          child: new Container(
            width: 100.0,
            height: 100.0,
            color: Colors.redAccent,
          ),
        ),
        new Opacity(
          opacity: 0.6,
          child: new Container(
            width: 200.0,
            height: 200.0,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }
}

//Column布局
class ColumnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //设置垂直方向的对齐方式
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //设置水平方向的对齐方式
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.blue,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.black,
          width: 50,
          height: 50,
        ),
        Container(
          color: Colors.green,
          width: 50,
          height: 50,
        ),
      ],
    );
  }
}

//Row
class RowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
//      //水平方向把剩余空间平分n+1份，然后平分所有的空间
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      //设置垂直方向的对齐方式
//      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
//        Container(
//          color:Colors.blue,
//          width: 50.0,
//          height:50.0,
//        ),
//        Container(
//          color:Colors.black,
//          width:50.0,
//          height:50.0,
//        ),
//        Container(
//          color:Colors.green,
//          width:50.0,
//          height:50.0,
//        ),
//          new RaisedButton(
//        onPressed: (){
//
//        },
//        color:Colors.green,
//        child:new Text('绿色按钮1')
//    ),
//      new Expanded(
//        child:new RaisedButton(
//            onPressed: (){
//
//            },
//            color:Colors.yellow,
//            child:new Text('黄色按钮2')
//        ),
//      ),
//      new RaisedButton(
//          onPressed:(){
//
//          },
//          color:Colors.red,
//          child:new Text('黑色按钮3')),
        Expanded(
          child: Container(
            color: Colors.green,
            padding: EdgeInsets.all(8),
            height: 40.0,
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            color: Colors.yellow,
            padding: EdgeInsets.all(8),
            height: 40.0,
          ),
          flex: 2,
        ),
        Expanded(
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.all(8),
            height: 40.0,
          ),
        ),
      ],
    );
  }
}

//ListView
class ListViewWidget extends StatelessWidget {
  final List<String> items;

  ListViewWidget(this.items);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: items.length,
      //设置水平方向
      scrollDirection: Axis.horizontal,
      //竖直时：确定每一个item的高度
      //水平时：确定每一个item的宽度 得要设置 不然不显示
      itemExtent: 110.0,
      itemBuilder: (context, index) {
        return new ListTile(
          title: new Text('This is $index'),
        );
      },
    );
  }
}

//GridView
class GridViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//      return new GridView.count(
//          crossAxisCount: 3,
//          children: List.generate(40,
//      (i){
//           return Card(
//             child: Center(
//               child:Text('This is $i'),
//             ),
//           );
//      })
//      );
    return new GridView.count(
      //3行
      crossAxisCount: 3,
      //设置水平
      scrollDirection: Axis.horizontal,
      children: List.generate(40, (i) {
        return Card(
          child: Center(
            child: Text('This is $i'),
          ),
        );
      }),
    );
  }
}
