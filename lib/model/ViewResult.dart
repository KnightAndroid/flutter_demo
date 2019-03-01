import 'ResultModel.dart';

class ViewResult{
  bool error;
  List<ResultModel> list;
  ViewResult(joinData){
    //获得返回的error值
    error = joinData['error'];
    list = [];
    print(joinData['results']);
    //获得"results"里的内容
    if(joinData['results'] != null){
       for(var dataItem in joinData['results']){
         list.add(new ResultModel(dataItem));
       }
    }
}





//  ViewResult.fromJson(Map<String,dynamic> map)
//    : error = map['error'],
//      resultModel = ResultModel.fromJson(map['results']);
}