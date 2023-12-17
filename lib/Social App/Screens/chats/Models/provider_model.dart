import 'package:flutter/cupertino.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/models.dart';
import 'package:shop_app/Social%20App/Screens/chats/services/api_service.dart';

class ModelsProvider with ChangeNotifier{


  String currentModel='gpt-3.5-turbo';
  String get getCurrentModel{
    return currentModel;
  }

  void setCurrentModel(String newModel)
  {
    currentModel=newModel;
    notifyListeners();
  }
  List<ModelsModel> modelList=[];
  List<ModelsModel> get getModelsList{
    return modelList;
  }
  Future<List<ModelsModel>> getAllModels ()async{
    modelList =await ApiService.getModels();
    return modelList;
  }
}