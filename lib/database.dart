import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

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
      home: DataBaseWidget(),
    );
  }
}

//主框架
class DataBaseWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DataBaseState();
  }
}

class _DataBaseState extends State<DataBaseWidget> {
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
          //用户输入用户信息
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: InputMessageWidget(),
          ),
          //数据库表的一些基本操作，增，删，改，查
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
            //获取用户名
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
            //获取用户密码
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

  //数据库中的表 简单一点，就创建三个字段，分别是主键，用户名，密码
  String sql_createUserTable = "CREATE TABLE user("
      "id INTEGER PRIMARY KEY,"
      "username TEXT,"
      "password TEXT)";

  //查找数据库表的数目
  String sql_queryCount = 'SELECT COUNT(*) FROM user';

  //具体查找数据库表的所有信息
  String sql_queryMessage = 'SELECT * FROM user';

  //这是从数据库表返回数据
  var _data;

  //创建数据库
  Future<String> createDataBase(String db_name) async {
    //在文档目录建立
    var document = await getApplicationDocumentsDirectory();
    //获取路径 join是path包下的方法，就是将两者路径连接起来
    String path = join(document.path, db_name);
    //逻辑是如果数据库存在就把它删除然后创建
    var _directory = new Directory(dirname(path));
    bool exists = await _directory.exists();
    if (exists) {
      //这里肯定存在 则删除数据库表
      await deleteDatabase(path);
    } else {
      try {
        //不存在则创建目录  如果[recursive]为false，则只有路径中的最后一个目录是
        //创建。如果[recursive]为真，则所有不存在的路径
        //被创建。如果目录已经存在，则不执行任何操作。
        await new Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }


  //创建数据库表方法
  cratedb_table() async {
    //得到数据库的路径
    myDataBasePath = await createDataBase(myDataBase);
    //打开数据库
    Database my_db = await openDatabase(myDataBasePath);
    //创建数据库表
    await my_db.execute(sql_createUserTable);
    //关闭数据库
    await my_db.close();
    setState(() {
      _data = "创建usermessage.db成功，创建user表成功~";
    });
}


//增加方法
addData() async {
    //首先打开数据库
    Database my_db = await openDatabase(myDataBasePath);
    //插入数据
    String add_sql = "INSERT INTO user(username,password) VALUES('$username','$password')";
    await my_db.transaction((tran) async{
       await tran.rawInsert(add_sql);
    });
    //关闭数据库
    await my_db.close();
    setState(() {
      _data = "增加一条数据成功，名字是：$username,密码是：$password";
    });
}


//查询具体数值
queryDetail() async{
    //打开数据库
    Database  my_db = await openDatabase(myDataBasePath);
    //将数据放到集合里面显示
    List<Map> dataList = await my_db.rawQuery(sql_queryMessage);
    await my_db.close();
    setState(() {
       _data = "具体数据详情如下:$dataList";
    });

}


//删除一条数据
delete() async {
    Database my_db = await openDatabase(myDataBasePath);
    //根据id来删除 也可以根据其他信息来删除 例如名字
    String delete_ssql = "DELETE FROM user WHERE id = ?";
    //返回所更改的数目
    int delete_count = await my_db.rawDelete(delete_ssql,['1']);
    //关闭数据库
    await my_db.close();
    //状态更新
    setState(() {
      if(delete_count == 1){
         _data = "删除成功~";
      } else {
        _data = "删除失败，请看错误日志~";
      }
    });
}



//修改数据方法
update() async{
   //数据库
   Database my_db = await openDatabase(myDataBasePath);
   String update_sql = "UPDATE user SET username = ? WHERE id = ?";
   await my_db.rawUpdate(update_sql,['paul','1']);
   await my_db.close();

   setState(() {
      _data = "数据修改成功，请查阅~";
   });

}


//查询有几条
query_num() async{
  //数据库
  Database my_db = await openDatabase(myDataBasePath);
  int data_count = Sqflite.firstIntValue(await my_db.rawQuery(sql_queryCount));
  await my_db.close();
  setState(() {
    _data = "数据条数：$data_count";
  });
}
  


  @override
  Widget build(BuildContext context) {
    return Column(
      //交叉轴设置中间
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40.0,
          child: RaisedButton(
            textColor: Colors.black,
            child: Text("创建数据库表"),
            onPressed: cratedb_table,
          ),
        ),
        Row(
          //主轴方向中心对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                textColor: Colors.black, child: new Text('增'), onPressed: addData),
            new RaisedButton(
                textColor: Colors.black, child: new Text('删'), onPressed: delete),
            new RaisedButton(
                textColor: Colors.black, child: new Text('改'), onPressed: update),
          ],
        ),
        Row(
          //主轴方向中心对齐
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('查条数'),
                onPressed: query_num),
            new RaisedButton(
                textColor: Colors.black,
                child: new Text('查信息'),
                onPressed: queryDetail),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text('具体结果是:$_data'),
        ),
      ],
    );
  }
}
