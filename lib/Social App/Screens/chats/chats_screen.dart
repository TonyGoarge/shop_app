
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/Cubit/DarkMode.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Cubit/staets.dart';
import 'package:shop_app/Social%20App/Screens/chats/chat_details_screen.dart';
import 'package:shop_app/Social%20App/Screens/chats/desgin/chat_gpt_service.dart';
import 'package:shop_app/Social%20App/models/social_user_model.dart';
import 'package:switcher_button/switcher_button.dart';


class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context , index) => buildChatItem(SocialCubit.get(context).users[index] , context),
              separatorBuilder: (context , index) => MyDivider(),
              itemCount: SocialCubit.get(context).users.length ,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model , context) => InkWell(
    onTap: ()
    {
      NavigatorTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
            children:
            [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(
                width: 15.0,),
              Text(
                '${model.name}',
                style: TextStyle(
                  height: 1.4,
                  fontSize: 17.0,

                ),
              ),

            ],
          ),
    ),
  );
}