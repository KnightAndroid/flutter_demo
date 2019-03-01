class ResultModel{
   String _id;
   String createdAt;
   String desc;
   String publishedAt;
   String source;
   String type;
   String url;
   bool used;
   String who;

   ResultModel(jsonData){
     _id = jsonData['_id'];
     createdAt = jsonData['createdAt'];
     desc = jsonData['desc'];
     publishedAt = jsonData['publishedAt'];
     source = jsonData['source'];
     type = jsonData['type'];
     url = jsonData['url'];
     used = jsonData['used'];
     who = jsonData['who'];
   }

 }

//   ResultModel.fromJson(Map<String,dynamic> map)
//       : _id = map['_id'],
//         createdAt = map['createdAt'],
//         desc = map['desc'],
//         publishedAt = map['publishedAt'],
//         source = map['source'],
//         type = map['type'],
//         url = map['url'],
//         used = map['used'],
//         who = map['who'];
//}