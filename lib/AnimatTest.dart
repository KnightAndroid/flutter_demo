import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main(){
  runApp(new AnimateApp());
}

class AnimateApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AnimateAppState();
  }
}

class _AnimateAppState extends State<AnimateApp> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  Animation<double> animation2;

  @override
  void initState() {
    super.initState();
    // 创建 AnimationController 对象
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    // 通过 Tween 对象 创建 Animation 对象
    final CurvedAnimation curve = CurvedAnimation(
        parent: controller, curve: Curves.elasticIn);
    animation = Tween(begin: 40.0, end: 200.0).animate(curve)
      ..addListener(() {
        // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
        setState(() {});
      })
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
    // 执行动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AnimateApp',
        theme: ThemeData(
            primaryColor: Colors.redAccent
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('AnimateApp'),
            ),
            body: Center(
              child: Container(
                // 获取动画的值赋给 widget 的宽高
                width: animation.value,
                height: animation.value,
                decoration: BoxDecoration(
                    color: Colors.redAccent
                ),
              ),
            )
        )
    );
  }

  @override
  void dispose() {
    // 资源释放
    controller.dispose();
    super.dispose();
  }
}