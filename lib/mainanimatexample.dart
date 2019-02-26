import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  //运行程序
  runApp(LogoApp());
}

class LogoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LogoAppState();
  }
}

//logo
Widget ImageLogo = new Image(
  image: new AssetImage('images/logo.jpg'),
);

//抽象出来
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

//  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
//  static final _sizeTween = new Tween<double>(begin: 0.0, end: 200.0);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("动画demo"),
        ),
        body: new Center(
            //child: new Opacity(
         // opacity: _opacityTween.evaluate(animation),
          child: new Container(
            //宽和高都是根据animation的值来变化
            height: animation.value,
            width: animation.value,
//            child: ImageLogo,
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
       // )),
      ),
    ),
   );
  }
}

//AnimatedBuilder
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  GrowTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("动画demo"),
        ),
        body: new Center(
          child: new AnimatedBuilder(
            animation: animation, //_opacityTween.evaluate(animation)
            builder: (BuildContext context, Widget child) {
              return new Opacity(
                  opacity: 1.0,
                child: new Container(
                //宽和高都是根据animation的值来变化
                height: animation.value,
                width: animation.value,
                child: child,
              ),
              );

            },
            child: child,
          ),
        ),
      ),
    );
  }
}

//with 是dart的关键字，混入的意思，将一个或者多个类的功能添加到自己的类无需继承这些类
//避免多重继承问题
//SingleTickerProviderStateMixin 初始化 animation 和 Controller的时候需要一个TickerProvider类型的参数Vsync
//所依混入TickerProvider的子类
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  //动画的状态，如动画开启，停止，前进，后退等
  Animation animation;

  //管理者animation对象
  AnimationController controller;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //创建AnimationController
    //需要传递一个vsync参数，存在vsync时会防止屏幕外动画（
    //译者语：动画的UI不在当前屏幕时）消耗不必要的资源。 通过将SingleTickerProviderStateMixin添加到类定义中，可以将stateful对象作为vsync的值。
    controller = new AnimationController(
      //时间是3000毫秒
      duration: const Duration(milliseconds: 3000),
      //vsync 在此处忽略不必要的情况
      vsync: this,
    );
    final CurvedAnimation curve =
         CurvedAnimation(parent: controller, curve: Curves.elasticIn);
    //补间动画
    animation = new Tween(
      //开始的值是0
      begin: 0.0,
      //结束的值是200
      end : 200.0,
    ).animate(curve)
    ..addStatusListener((state){
        //如果动画完成了
        if (state == AnimationStatus.completed) {
          //开始反向这动画
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          //开始向前运行着动画
          controller.forward();
        }
    });

//    //添加动画状态
//       animation = new CurvedAnimation(parent: controller, curve: Curves.elasticIn)
//      ..addStatusListener((state) {
//        //如果动画完成了
//        if (state == AnimationStatus.completed) {
//          //开始反向这动画
//          controller.reverse();
//        } else if (state == AnimationStatus.dismissed) {
//          //开始向前运行着动画
//          controller.forward();
//        }
//      }); //添加监听器

//    animation = new Tween<double>(begin: 0.0, end: 200.0).animate(animation1);
    //只显示动画一次
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //return AnimatedLogo(animation: animation);
     return new GrowTransition(child:ImageLogo,animation: animation);
//    return new Center(
//      child: new Container(
//        margin: new EdgeInsets.symmetric(vertical: 10.0),
//        height: animation.value,
//        width: animation.value,
//        child: new FlutterLogo(),
//      ),
//    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //资源释放
    controller.dispose();
  }
}
