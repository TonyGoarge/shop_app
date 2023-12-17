import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/Social%20App/Screens/chats/Constants/api_constant.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/Model_Chat.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/models.dart';

class ApiService{
  // .....to handle version model .....
  static Future<List<ModelsModel>> getModels()async{
    try{
      var response = await http.get(
        Uri.parse('$BASE_URL/models'),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );
      Map jsonResponse= jsonDecode(response.body);
      if(jsonResponse['error']!=null)
        {
          print("jsonResponse['error'] ${jsonResponse['error']['message']}");
          throw HttpException(jsonResponse['error']['message']);
        }
      // print(jsonResponse.toString());
      List temp=[];
      for(var value in jsonResponse['data'])
        {
          temp.add(value);
          // log('temp ${value['id']}');
        }
      return ModelsModel.modelsFormSnapshot(temp);
    }catch(error){
      log(error.toString());
      rethrow;
    }
  }

  //.....send Message ....
  static Future<List<ChatModel>> SendMessage({required String message,required String modelId})async{
    try{
      var response = await http.post(
        Uri.parse('$BASE_URL/completions'),
        headers: {'Authorization': 'Bearer $API_KEY',
          'Content-Type' :'application/json'
        },
body: jsonEncode({
            "model": modelId,
            "prompt": message,
            "max_tokens": 7,

          })
      );
      Map jsonResponse= jsonDecode(response.body);
      if(jsonResponse['error']!=null)
      {
        print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel>chatlist=[];
        if(jsonResponse['choices'].length>0)
        {
        log('jsonResponse [choices]text ${jsonResponse['choices'][0]['text']}');
        chatlist=List.generate(
            jsonResponse['choices'].length,
                (index)=> ChatModel(msg:jsonResponse['choices'][index]['text'],
            chatIndex:1));
      }
        return chatlist;
    }catch(error){
      log(error.toString());
      rethrow;
    }
  }
}