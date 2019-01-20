import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:io';
import 'package:flutter/services.dart';

//入口函数
void main() {
  //MaterialApp组件渲染后
  runApp(MyApp());
  //判断如果是Android版本的话 设置Android状态栏透明沉浸式
  if (Platform.isAndroid) {
    //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏，写在渲染之前对MaterialApp组件会覆盖这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

//程序继承StatelessWidget，该应用程序成为一个widget，在Flutter中，大多数东西都是widget
class MyApp extends StatelessWidget {
  // 这个是应用的根widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:new RandomWordsWidget(),
    );
  }
}

//创建有状态的widget
class RandomWordsWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

//用来保存RandomWords widget的状态
class RandomWordsState extends State<RandomWordsWidget> {
  final _normalWords = <WordPair>[];
  final Set<WordPair> _collected = new Set<WordPair>();

  //创建填充单词的ListView
  Widget _buildNormalWorlds() {
    //内容上下16dp
    return new ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        //每个单词都会条约一次itemBuilder，然后将单词添加到ListTile中
        itemBuilder: (context, i) {
          //添加分割线
          //奇数行，会添加一个分割线的widget，分割上下单词
          //偶数行，就正常构造添加ListTitle row
          //构造一像素的分割线 也可以自己去定义宽高
          //i.isOdd是判断是否奇数
          if(i.isOdd){
            //注意：这里执行后会跳出循环
            return new Divider();
          }

          //这里对2求商，就是计算出ListView中减去分割线后的实际单词数量
          //如 i为 1，2，3，4，5，那么商结果是0，1，1，2，2
          //1 除以 2商是0 2除以2商是1 以此类推
          final int index = i ~/2;

          //首先创建10条单词
          if (index >= _normalWords.length) {
            //接着再生成10个单词，添加到列表上
            _normalWords.addAll(generateWordPairs().take(10));
          }
          return _buildItem(_normalWords[index]);
        });
  }

  //设置每个item项的内容和样式
  Widget _buildItem(WordPair pair) {
    //单词是否收藏了
    final bool isCollected = _collected.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        textAlign: TextAlign.center,
      ),
      //trailing 是后置图标属性
      trailing: new Icon(
        //material 包下 icons.dart
        isCollected ? Icons.favorite : Icons.favorite_border,
        //图标颜色设置
        color:isCollected ? Colors.red : null,
      ),

      //item的点击事件属性
      onTap:(){
        //状态设置
        setState(() {
          //如果收藏了
          if(isCollected){
            //那就将set集合里移除
            _collected.remove(pair);
          } else {
            //添加
            _collected.add(pair);
          }
        });

      }
    );
  }

  Widget build(BuildContext buildContext) {
      return new Scaffold(
        appBar: new AppBar(
          //间隔默认是0
          titleSpacing: 0.0,
//          title: new Center(child: const Text("Weclome to Flutter"),
          title: new Container(decoration: new BoxDecoration(color: new Color(0x00000000),
          ),
              child:new Stack(
                children:<Widget>[
                  new Center(child:new Text("Weclome to Flutter")),
                  new Container(
                    alignment: Alignment.centerRight,
                    child:new IconButton(
                        //图标样式
                        icon: new Icon(Icons.list),
                        //点击事件 点击后执行_collectWordsPage
                        onPressed: _collectWordsPage),
                  ),

                ],
              )),

          ),
        body:_buildNormalWorlds(),
        );

  }

  //跳转新页面开始
  void _collectWordsPage() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          //传递收藏后的单词
          final Iterable<ListTile> tiles = _collected.map((WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase, //单词
              ),
            );
          },
          );
          //添加分割线开始
          final List<Widget> divided = ListTile.divideTiles(
            tiles: tiles,
            context:context,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              titleSpacing: 0.0,
              //MaterialPageRoute这个自带了返回键 下面的属性设置取消返回键
              automaticallyImplyLeading:false,
              title: new Container(decoration: new BoxDecoration(color: new Color(0x00000000),
              ),
              child:new Stack(
                children: <Widget>[
                  new Container(
                    //左边位置
                    alignment: Alignment.centerLeft,
                    child:new IconButton(
                      //图标样式
                      icon:new Icon(Icons.arrow_back),
                      //点击事件
                      onPressed: (){
                        Navigator.pop(context);
                      }
                    ),
                  ),
                  new Center(child:new Text("Collect Words")),
                ],
              ),)
            ),
            body: new ListView(children: divided),
          );
        },

      ),
    );
  }

}



