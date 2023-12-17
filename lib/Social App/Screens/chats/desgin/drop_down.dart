import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Social%20App/Screens/chats/Constants/constant.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/models.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/provider_model.dart';
import 'package:shop_app/Social%20App/Screens/chats/Textwidget.dart';
import 'package:shop_app/Social%20App/Screens/chats/services/api_service.dart';

class ModelDropDown extends StatefulWidget {
  const ModelDropDown({Key? key}) : super(key: key);

  @override
  State<ModelDropDown> createState() => _ModelDropDownState();
}

class _ModelDropDownState extends State<ModelDropDown> {
  String? currentmodel;
  @override
  Widget build(BuildContext context) {
    final modelsProvider=Provider.of<ModelsProvider>(context,listen: false);
    currentmodel=modelsProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context,snapshot)
    {
      if(snapshot.hasError){
        return Center(child: TextWidget(label: snapshot.error.toString()),);
      }
      return snapshot.data==null ||snapshot.data=='' ? SizedBox.shrink():

      FittedBox(
        child: DropdownButton(
                dropdownColor: ScaffoldbackgroundColor,
                iconEnabledColor: Colors.white,
                items:
                  List<DropdownMenuItem<String>>.generate(
            snapshot.data!.length,
                (index) => DropdownMenuItem(
                value: snapshot.data![index].id,
                child: TextWidget(
                  label: snapshot.data![index].id,
                  fontSize: 15.0,))
        ),

                value: currentmodel,
                onChanged: (value)
                {
                setState(()
                {
                currentmodel=value.toString();
                });
                modelsProvider.setCurrentModel(value.toString(),);
                },
                ),
      );
    }
    );
  }
}

