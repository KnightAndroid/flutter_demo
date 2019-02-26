import 'package:flutter/material.dart';
import 'mainnewroute.dart';

//使用toast
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  //运行程序
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //配置初始路由
      initialRoute: '/',
      routes: {
        //默认走这个条件`/`
        '/':(context){
          return HomeStateful();
        },
        //新页面路由
        '/mainnewroute':(context){
          return new newRoute("sdsd");
        }
      },
      //主题色
      theme: ThemeData(
        //设置为红色
          primarySwatch: Colors.red),
      //配置了初始路由，下面就不需要了
      //home: HomeStateful(),
    );
  }
}


class HomeStateful extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new HomeWidget();
  }

}

class HomeWidget extends State<HomeStateful> {
  //列表要显示的数据
  List list = new List();
  //ListView控制器
  ScrollController _controller = ScrollController();
  //是否正在加载 刷新
  bool isfresh = false;

  //是否隐藏底部
  bool isBottomShow = false;

  //加载状态
  String statusShow = '加载中...';
  //这个方法只会调用一次，在这个Widget被创建之后，必须调用super.initState()
  @override
  void initState(){
    super.initState();
    //初始化数据
    initData();
    //添加监听
    _controller.addListener((){
        //这里判断滑到底部第一个条件就可以了，加上不在刷新和不是上滑加载
        if(_controller.position.pixels == _controller.position.maxScrollExtent){
           //滑到底部了
           _onGetMoreData();
        }
    });
  }

  //延迟3秒后刷新
  Future initData() async{
    //正在加载
    statusShow = '加载中...';
    await Future.delayed(Duration(seconds: 3),(){
      setState(() {
        //用生成器给所有元素赋初始值
        list = List.generate(20, (i){
          return i;
        });
      });
    });
  }
  //Paint pg = Paint();
  // pg.color = Color(0xFF3344FF);
  //第二行第一列背景
  LinearGradient l1 = new LinearGradient(colors: [Colors.orange, Colors.deepOrange]);
  //第二行第二列背景
   LinearGradient l2 = new LinearGradient(colors: [Colors.greenAccent, Colors.green]);
  @override
  Widget build(BuildContext context) {
    /**
     * TextStyle:封装
     * colors:颜色
     * fontsizes：字体大小
     * isFontWeight：是否加粗
     */
    TextStyle getTextStyle(Color colors,double fontsizes,bool isFontWeight){
      return TextStyle(
        color:colors,
        fontSize: fontsizes,
        fontWeight: isFontWeight == true ? FontWeight.bold : FontWeight.normal ,
      );
    }

    //抽取第二行渐变text效果
    Container getText(String text,LinearGradient linearGradient){
      return Container(
        //距离左边距离10dp
        margin: const EdgeInsets.only(left: 10),
        //约束 相当于直接制定了该Container的宽和高，且它的优先级要高于width和height
        constraints: new BoxConstraints.expand(
          width: 70.0, height: 30.0,),
        //文字居中
        alignment: Alignment.center,
        child: new Text(
            text,
            style:getTextStyle(Colors.white,14,false),
        ),
        decoration: new BoxDecoration(
          color: Colors.blue,
          //圆角
          borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
          //添加渐变
          gradient:linearGradient,
        ),
      );

    }

    //第二行
    Widget rowWidget = Row(
      //主轴左边对齐
      mainAxisAlignment: MainAxisAlignment.start,
      //交叉轴(竖直方向)居中
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("分类:",
          style: getTextStyle(Colors.blue,14,true),

        ),
        getText("多线程", l1),
        getText("Java深入", l2),
      ],

    );


    /**
     * 组件加上下左右padding
     * w:所要加padding的组件
     * all:加多少padding
     */
    Widget getPadding(Widget w,double all){
      return Padding(
        child:w,
        padding:EdgeInsets.all(all),
      );
    }

    /**
     * 组件选择性加padding
     * 这里用了位置可选命名参数{param1,param2,...}来命名参数，也调用的时候可以不传
     *
     */
    Widget getPaddingfromLTRB(Widget w,{double l,double t,double,r,double b}){
      return Padding(
        child:w,
        padding:EdgeInsets.fromLTRB(l ?? 0,t ?? 0,r ?? 0,b ?? 0),
      );
    }
    //第三行
    Widget rowthreeWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
         new Expanded(
             child: Text(
                 "作者:EnjoyMoving",
                 style: getTextStyle(Colors.grey[400], 14, true),

             ),

         ),
         getPaddingfromLTRB(Text(
           '时间:2019-02-02',
           style: getTextStyle(Colors.black, 14, true),
         ), r :10.0),

         getPaddingfromLTRB(Icon(
           Icons.favorite_border,
           color:Colors.grey[400],
         ),r:0.0)
      ],
    );


    //根Widget 布局一
    Widget ColumnWidget = Column(
      //主轴上设置居中
      mainAxisAlignment: MainAxisAlignment.center,
      //交叉轴(水平方向)设置从左开始
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //第一行
        getPaddingfromLTRB(Text('Java synchronized原理总结',
          style: getTextStyle(Colors.black, 16,true),
        ),t:0.0),
        //第二行
        getPaddingfromLTRB(rowWidget,t:10.0),
        //第三行
        getPaddingfromLTRB(rowthreeWidget,t:10.0),

      ],
    );

    //根Widget 布局二 开始
    //右边图片布局
    Widget LayoutTwoLeft = Container(
        //这次使用裁剪实现圆角矩形
        child:ClipRRect(
          //设置圆角
          borderRadius: BorderRadius.circular(4.0),
          child: Image.network(
            'https://img3.doubanio.com//view//photo//s_ratio_poster//public//p2545472803.webp',
            width: 100.0,
            height: 150.0,
            fit:BoxFit.fill,
          ),
        ),
    );

    //右下角圆形
    CircleAvatar getCircleAvator(String image_url){
      //圆形头像
      return CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(image_url),
      );
    }

    //右布局
    Widget LayoutTwoRightColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //电影名称
        Text(
          '流浪地球',
          style: getTextStyle(Colors.black, 20.0, true),
        ),

        //豆瓣评分
        Text(
          '豆瓣评分：7.9',
          style: getTextStyle(Colors.black54, 16.0, false),
        ),

        //类型
        Text(
          '类型：科幻、太空、灾难',
          style:getTextStyle(Colors.black54, 16.0, false),
        ),

        //导演
        Text(
          '导演：郭帆',
          style: getTextStyle(Colors.black54, 16.0, false),
        ),

        //主演
        Container(
          margin: EdgeInsets.only(top:8.0),
          child:Row(
            children: <Widget>[
              Text('主演：'),
              //以Row从左到右排列头像
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left:2.0),
                    child: getCircleAvator('https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1533348792.03.webp'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:12.0),
                    child: getCircleAvator('https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1501738155.24.webp'),
                  ),
                  Container(
                    margin: EdgeInsets.only(left:12.0),
                    child: getCircleAvator('https://img3.doubanio.com//view//celebrity//s_ratio_celebrity//public//p1540619056.43.webp'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    //布局二 右布局 用Expanded占满剩余空间
    Widget LayoutTwoRightExpanded = Expanded(
      child:Container(
        //距离左布局10
        margin:EdgeInsets.only(left:10.0),
        //高度
        height:150.0,
        child: LayoutTwoRightColumn,
      ),
    );

    //整体
    Widget RowWidget = Row(
      //主轴上设置从开始方向对齐
      mainAxisAlignment: MainAxisAlignment.start,
      //交叉轴(水平方向)居中
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        LayoutTwoLeft,
        LayoutTwoRightExpanded,
      ],
    );



    //布局三开始第一行
    Widget LayoutThreeOne = Row(
       children: <Widget>[
         Expanded(
           child: Row(
             children: <Widget>[
               Text('作者：'),
               Text('HuYounger',
                  style: getTextStyle(Colors.redAccent[400], 14, false),
               ),
             ],
           )
         ),
         //收藏图标
         getPaddingfromLTRB(Icon(Icons.favorite,color:isfresh ? Colors.red : Colors.black),r:10.0),
         //分享图标
         Icon(Icons.share,color:Colors.black),
       ],
    );


    //布局三开始第三行
    Widget LayoutThreeThree = Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Text('分类:'),
              getPaddingfromLTRB(Text('开发环境/Android',
                  style:getTextStyle(Colors.deepPurpleAccent, 14, false)),l:8.0),

            ],
          ),
        ),
        Text('发布时间：2018-12-13'),
      ],
    );



    //布局三整合
    Widget LayoutThreeColumn = Column(
      //主轴上设置居中
      mainAxisAlignment: MainAxisAlignment.center,
      //交叉轴(水平方向)设置从左开始
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //第一行
        LayoutThreeOne,
        //第二行
        getPaddingfromLTRB(Text('Android Monitor使用介绍',
              style:getTextStyle(Colors.black, 18, false),
        ),t:10.0),
        //第三行
        getPaddingfromLTRB(LayoutThreeThree,t:10.0),
      ],

    );

    //卡片
    Widget cardWidget = Card(
      child: Container(
        //alignment: Alignment(0.0, 0.0),
          height: 160.0,
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child:  Center(
            // 布局一
            // child: ColumnWidget,

            // 布局二
            // child:RowWidget,

            // 布局三
            child:LayoutThreeColumn,
          )
      ),
    );

    //ListView Item
    Widget _itemColumn(BuildContext context,int index){
      if(index <list.length){
        return Column(
          children: <Widget>[
            cardWidget,
          ],
        );

      }
      //这里返回底部
      return _GetMoreDataWidget();

    }


    //ListView item 布局二
    Widget cardWidget_two = Card(
      child: Container(
        //alignment: Alignment(0.0, 0.0),
          height: 160.0,
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Center(
            // 布局一
            child: ColumnWidget,
          )
      ),
    );


    //手势测试
    Widget gestureTest = GestureDetector(
          child: Container(
            width: 300.0,
            height: 300.0,
            color:Colors.red,
          ),
//          onTapDown: (d){
//            print("onTapDown");
//          },
//          onTapUp: (d){
//            print("onTapUp");
//          },
//          onTap:(){
//            print("onTap");
//          },
//          onTapCancel: (){
//            print("onTaoCancel");
//          },
//           onDoubleTap: (){
//              print("双击onDoubleTap");
//           },
//           onLongPress: (){
//              print("长按onLongPress");
//           },
//           onLongPressUp: (){
//              print("长按抬起onLongPressUP");
//           },
//            onVerticalDragDown: (_){
//               print("竖直方向拖动按下onVerticalDragDown:"+_.globalPosition.toString());
//            },
//            onVerticalDragStart: (_){
//               print("竖直方向拖动开始onVerticalDragStart"+_.globalPosition.toString());
//            },
//            onVerticalDragUpdate: (_){
//               print("竖直方向拖动更新onVerticalDragUpdate"+_.globalPosition.toString());
//            },
//            onVerticalDragCancel: (){
//               print("竖直方向拖动取消onVerticalDragCancel");
//            },
//            onVerticalDragEnd: (_){
//               print("竖直方向拖动结束onVerticalDragEnd");
//            },
//             onPanDown: (_){
//                 print("onPanDown");
//             },
//             onPanStart: (_){
//                 print("onPanStart");
//             },
//             onPanUpdate: (_){
//                 print("onPanUpdate");
//             },
//             onPanCancel: (){
//                 print("onPanCancel");
//             },
//             onPanEnd: (_){
//                 print("onPanEnd");
//             },
               onScaleStart: (_){
                   print("onScaleStart");
               },
               onScaleUpdate: (_){
                   print("onScaleUpdate");
               },
               onScaleEnd: (_){
                   print("onScaleEnd");
               },

    );

    //Pointer
    Widget TestContainer = Listener(
      child:Container(
        width: 300.0,
        height: 300.0,
        color:Colors.red,
        child: RaisedButton(
            child: Text('点击我'),
            onPressed: () async {
//              var data = await Navigator.of(context).pushNamed('/mainnewroute');
//              //打印返回来的数据
//              print(data);
              var data = await Navigator.push(
                context,
                MaterialPageRoute(builder: (newPage){
                  return new newRoute("这是一份数据到新页面");
                }),
              );
              print(data);
            }),
    ),
      onPointerDown: (event){
        print("onPointerDown");
      },
      onPointerUp: (event){
        print("onPointerUp");
      },
      onPointerMove: (event){
        print("onPointerMove");
      },
      onPointerCancel: (event){
        print("onPointerCancel");
      },

    );
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Demo'),
        ),
        //下拉刷新开始
//        body: RefreshIndicator(
//          onRefresh: _onRefresh,
//            //ListView提供一个builder属性 这是添加不同类型的itemView
//              child: ListView.separated(
//                  itemBuilder: (BuildContext context,int index){
//                    return  _itemColumn(context,index);
//
//                  },
//                  separatorBuilder: (BuildContext context,int index){
//                    return Column(
//                      children: <Widget>[
//                        (index + 1) % 3 == 0 ? cardWidget_two : Container()
//                        //cardWidget_two
//                      ],
//                    );
//                  },
//                  itemCount: list.length + 1,
//                  controller: _controller,
//              ),
////            child: ListView.builder(
////                //数目 加上尾部加载更多list就要加1了
////                itemCount: list.length + 1,
////                //itemBuilder是一个匿名回调函数，有两个参数，BuildContext 和迭代器index
////                //和ListView的Item项类似 迭代器从0开始 每调用一次这个函数，迭代器就会加1
////                itemBuilder: _itemColumn,
////                //控制器
////                controller: _controller,
////            ),
//            ),  //下拉刷新 上滑加载结束

         //手势开始
         body:Center(
           child: TestContainer,
         ),
      );
    }
    //下拉刷新方法
  Future<Null> _onRefresh() async {
//      isBottomShow = true;
      isfresh = true;
      print('进入刷新方法');
      //写逻辑 延迟3秒后执行刷新
      //底部加载更多不显示
     await Future.delayed(Duration(seconds: 3),(){
       setState(() {
         //数据清空再重新添加2条数据
         list.clear();
         list.addAll(List.generate(8, (i){
           return i;
         }));
       });
     });
  }

  //上拉加载更多方法
  Future _onGetMoreData() async{
     print('进入上拉加载方法');
     isBottomShow = false;
     isfresh = false;
     if(list.length <=30){
       await Future.delayed(Duration(seconds: 2),(){
         setState(() {
           //加载数据
           //这里添加8项
             list.addAll(List.generate(8, (i){
               return i;
             }));

         });
       });

     }else{

       await Future.delayed(Duration(seconds: 3),(){
         setState(() {
           //加载数据
           //这里添加5项
           isBottomShow = true;

         });
       });


     }


  }

  //显示'加载更多'，显示在界面上
  Widget _GetMoreDataWidget(){
     return Center(
       child: Padding(
         padding:EdgeInsets.all(12.0),
         // Offstage就是实现加载后加载提示圆圈是否消失
         child:new Offstage(
         // widget 根据isBottomShow这个值来决定显示还是隐藏
         offstage: isBottomShow,
           child:
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[
               Text(
                   //根据状态来显示什么
                   statusShow,
                   style:TextStyle(
                     color: Colors.grey[300],
                     fontSize: 16.0,
                   )
               ),
               //加载圆圈

               CircularProgressIndicator(
                 strokeWidth: 2.0,
               )

             ],
           ),
         )

       ),
     );
  }

//  String _getMoreDataString(){
//    print('isFresh的值 $isfresh');
//    print('loadMore的值 $loadMore');
//    if(!this.loadMore && this.isfresh){
//      return '加载更多...';
//    } else if(!this.loadMore){
//        this.isBottomShow = true;
//        return '做人要有底线~';
//    }else{
//      this.isBottomShow = true;
//      return '加载中~';
//    }
//  }

  //State删除对象时调用Dispose，这是永久性 移除监听 清理环境
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
}
