
import 'dart:io';//导IO包
import 'dart:convert';//解码和编码JSON
import 'package:dio/dio.dart';
void main() {
  //_get();
  //_post();
  //dio_get();
  dio_post();
}

_get() async{
  var responseBody;
  //1.创建HttpClient
  var httpClient = new HttpClient();
  //2.构造Uri
  var requset = await httpClient.getUrl(Uri.parse("http://gank.io/api/data/%E7%A6%8F%E5%88%A9/10/1"));
  //3.关闭请求，等待响应
  var response = await requset.close();
  //4.进行解码，获取数据
  if(response.statusCode == 200){
      //拿到请求的数据
      responseBody = await response.transform(utf8.decoder).join();
      //先不解析打印数据
      print(responseBody);
  }else{
    print("error");
  }

}


_post() async{
  var responseBody;
  //1.创建HttpClient
  var httpClient = new HttpClient();
  //2.构造Uri
  var requset = await httpClient.postUrl(Uri.parse("http://www.wanandroid.com/user/login?username=1&password=123456"));
  //3.关闭请求，等待响应
  var response = await requset.close();
  //4.进行解码，获取数据
  if(response.statusCode == 200){
    //拿到请求的数据
    responseBody = await response.transform(utf8.decoder).join();
    //先不解析打印数据
    print(responseBody);
  }else{
    print("error");
  }

}


//dio get请求
dio_get() async{
  try{
      Response response;
      response = await Dio().get("http://gank.io/api/data/%E7%A6%8F%E5%88%A9/10/1");
      if(response.statusCode == 200){
        print(response);
      }else{
        print("error");
      }
  }catch(e){
     print(e);

  }

}

dio_post() async{
  try{
    Response response;
    response = await Dio().post("http://www.wanandroid.com/user/login?username=1&password=123456");
    if(response.statusCode == 200){
      print(response);
    }else{
      print("error");
    }
  }catch(e){
    print(e);

  }
}
