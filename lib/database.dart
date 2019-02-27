import 'package:flutter/material.dart';

//app入口
void main() {
  runApp(MyApp());
}

//用户名
String username = "";
//密码
String password = "";

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
      home: DataBase(),
    );
  }
}

//主框架
class DataBase extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DataBaseState();
  }
}

class _DataBaseState extends State<DataBase> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar
      appBar: AppBar(
        title: Text("Sqlite简单操作"),
        //标题居中
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: InputMessageWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SqliteHandleWidget(),
          ),
        ],
      ),
    );
  }
}

//用户名和密码
class InputMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //这个是为了用户输入结束后，让密码输入框获取到焦点
    FocusNode secondTextFieldNode = FocusNode();
    return Column(
      children: <Widget>[
        TextField(
          //文字内容改变触发
          onChanged: (user) {
            username = user;
          },
          //输入法装饰器
          decoration: InputDecoration(
            //标签
              labelText: '名字',
              //hint 提示用户输入什么
              hintText: '请输入英文或者数字'),
          //最大为一行
          maxLines: 1,
          //文字提交触发
          onSubmitted: (result) {
            FocusScope.of(context).reparentIfNeeded(secondTextFieldNode);
          },
        ),
        TextField(
          onChanged: (pwd) {
            password = pwd;
          },
          //是否隐藏输入 false 表示不隐藏，true表示隐藏
          obscureText: true,
          maxLines: 1,
          decoration: InputDecoration(
            labelText: '密码',
            hintText: '请输入密码',
          ),
          //键盘输入类型
          keyboardType: TextInputType.text,
          onSubmitted: (data) {},
        ),
      ],
    );
  }
}

//数据库组件操作
class SqliteHandleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SqliteHandleWidgetState();
  }
}

class _SqliteHandleWidgetState extends State<SqliteHandleWidget> {
  //数据库名称
  String myDataBase = "usermessage.db";

  //数据库路径
  String myDataBasePath = "";

  //数据库中的表
  String sql_createUserTable = "CREATE TABLE user("
      "id INTEGER PRIMARY KEY,"
      "username TEXT,"
      "password TEXT)";

  //查找数据库表的数目
  String sql_queryCount = 'SELECT COUNT(*) FROM user';

  //具体查找数据库表的所有信息
  String sql_queryMessage = 'SELECT * FROM user';

  var data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40.0,
          child: RaisedButton(
            textColor: Colors.black,
            child: Text("创建"),
            onPressed: null,
          ),
        ),
        Row(
          //主轴方向中心对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('增'),
                onPressed: null),
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('删'),
                onPressed: null),
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('改'),
                onPressed: null),
          ],
        ),
        Row(
          //主轴方向中心对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('查条数'),
                onPressed: null),
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('查信息'),
                onPressed: null),
          ],
        ),
      ],
    );
  }
}
