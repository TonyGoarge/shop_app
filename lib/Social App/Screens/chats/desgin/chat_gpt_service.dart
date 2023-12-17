
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/News%20App/Cubit/DarkMode.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/Model_Chat.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/provider_model.dart';
import 'package:shop_app/Social%20App/Screens/chats/Textwidget.dart';
import 'package:shop_app/Social%20App/Screens/chats/desgin/desgin_msg/chatwidget.dart';

import 'package:shop_app/Social%20App/Screens/chats/Constants/constant.dart';
import 'package:shop_app/Social%20App/Screens/chats/desgin/drop_down.dart';
import 'package:shop_app/Social%20App/Screens/chats/services/api_service.dart';

class ChatGPT extends StatelessWidget {
 bool _isTyping=false;
// late  String? msg;
// late int? chatIndex;
var Textcontroller = TextEditingController();
@override
// void initstate()
// {
//   textEditingController=TextEditingController();
//
// }
// void dispose()
// {
//   textEditingController.dispose();
//
// }
  List<ChatModel>chatlist=[];
  @override
  Widget build(BuildContext context) {
    final modelsProvider=Provider.of<ModelsProvider>(context);

    var isDark =DarkCubit.get(context).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text('BEST PRODUCT '),
        actions: [
          IconButton(onPressed: ()
          async{
            await showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              backgroundColor: CardColor,
                context: context,
                builder: (context){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children:
                     [
                       Flexible(
                         child: TextWidget(
                           label: 'Chosen Model :',
                            fontSize: 15.0,
                         ),
                         
                       ),
                       SizedBox(
                         width: 3.0,),
                       Flexible(
                         flex:2,
                           child: ModelDropDown()),
                     ],
                    ),
                  );
                });
          },
              icon:
              isDark? 
              Icon(
                Icons.more_vert_rounded,
                color: Colors.white,)
                  :
              Icon(
            Icons.more_vert_rounded,color: Colors.black,
          ))
        ],
        elevation: 2.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
              'https://blog.routinehub.co/content/images/2023/02/openAI-chat-gpt-1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children:
          [
            Flexible(
              child: ListView.builder(
                itemCount: chatlist.length,
                  itemBuilder: (context,index)
                      {
                        return ChatWidget(
                        msg: chatlist[index].msg,
                          chatIndex: (chatlist[index].chatIndex) ,
                        );
                      }
              ),
            ),
            if(_isTyping)...[
              // isDark? SpinKitThreeBounce(
              //
              //   color: Colors.white,
              //   size: 18.0,
              //  ):
    SpinKitThreeBounce(
                color: Colors.black,
                size: 18.0,
              ),
            ],
              SizedBox(
                height: 5.0,),
              Material(
                color: CardColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child:
                        TextField(
                          style: isDark?TextStyle(
                              color:Colors.white) : TextStyle(
                              color:Colors.black),
                        controller: Textcontroller,
                          onSubmitted: (value)
                          async{await sendMessageFCT(modelsProvider: modelsProvider,);

                          },
                          decoration: InputDecoration.collapsed(
                              hintText: 'How can i help you',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      IconButton(onPressed: ()

                        async{await sendMessageFCT(modelsProvider: modelsProvider,);
                          try{
                            setState(Null Function() param0) {
                              _isTyping = true;
                            }
                            log('Request has been sent');
                            chatlist= await ApiService.SendMessage(
                                message: Textcontroller.text,
                                modelId:modelsProvider.getCurrentModel
                            );
                            setState((){});
                          }catch(error){
                            log('error $error');
                          }
                          finally {
                            setState() {
                              _isTyping = false;
                            }
                          }
                        },


                          icon: Icon(Icons.send,color: Colors.white,),
    ),
                    ],
                  ),
                ),
              ),
            ]

        ),
      ),
    );
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider}) async{
    try{
      setState() {
        _isTyping = true;
      }
      log('Request has been sent');
      final list= await ApiService.SendMessage(
          message: Textcontroller.text,
          modelId:modelsProvider.getCurrentModel );
    }catch(error){
      log('error $error');
    }
    finally {
      setState() {
        _isTyping = false;
      }
    }
  }

}
