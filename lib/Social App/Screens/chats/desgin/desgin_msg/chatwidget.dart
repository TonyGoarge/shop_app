import 'package:flutter/material.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Social%20App/Screens/chats/Textwidget.dart';

class ChatWidget extends StatelessWidget {
final String? msg;
final int? chatIndex;

   ChatWidget({Key? key, this.msg, this.chatIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: 
      [
        Container(
          color:chatIndex==0?ScaffoldbackgroundColor: CardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatIndex==0
                    ? Image.network(

                    'https://cdn4.iconfinder.com/data/icons/user-icons-5/100/user-6-512.png',
                height: 30.0,
                  width: 30.0,
                )
                     : Image.network(
                    'https://blog.routinehub.co/content/images/2023/02/openAI-chat-gpt-1.jpg',
                height: 30.0,
                  width: 30.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.0,),
                Expanded(child:
                TextWidget(
                  label:msg,
                )
                ),
                chatIndex==0 ? SizedBox.shrink() :Row(
                  children:
                  [
                    Icon(Icons.thumb_up_alt_outlined,
                    color: Colors.white,),
                    SizedBox(width: 5.0,),
                    Icon(Icons.thumb_down_alt_outlined,
                    color: Colors.white,),
                  ],
                )
              ],
               ),
            ),
          ),

      ],
    );
  }
  
}
