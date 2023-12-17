import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Cubit/staets.dart';
import 'package:shop_app/Social%20App/new_post/new_post_screen.dart';

import '../../News App/Styles/iconBroken.dart';

class sociallayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state)
      {
        if (state is SocialNewPostState)
          {
            NavigatorTo(context,NewPostScreen(),);
          }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text(
             cubit.titles[cubit.currentindex],
            ),
            actions:
            [
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Search)),
            ],
          ),

            body:cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
              items:[
                BottomNavigationBarItem(
                    icon:Icon(
                      IconBroken.Home,
                    ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon:Icon(
                      IconBroken.Chat,
                    ),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                    icon:Icon(
                      IconBroken.Paper_Upload,
                    ),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                    icon:Icon(
                      IconBroken.Location,
                    ),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                    icon:Icon(
                      IconBroken.Setting,
                    ),
                  label: 'Setting',
                ),
              ],

          ),
        );
      },
    );
  }
}




















// ConditionalBuilder(
// condition:SocialCubit.get(context).model !=null,
// builder: ((context)
// {
// var model =SocialCubit.get(context).model;
// return Column(
// children:
// [
// if(FirebaseAuth.instance.currentUser!.emailVerified ==false)
// Container(
//
// color: Colors.amber.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children:
// [
// Icon(Icons.info_outline,
// ),
// SizedBox(width: 15.0,),
// Expanded(
// child: Text(
// 'Please verified your Email'),
// ),
// SizedBox(width: 15.0,),
// defaulttextbutton(
// text: 'send',
// onpress: () {
// FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value)
// {
// ShowToast(text: 'check your mail', state: ToastStates.SUCCESS,);
// });
// },
// ),
// ],
// ),
//
//
// ),
// ),
// SizedBox(height: 15.0,),
// CircleAvatar(
// backgroundColor: Colors.yellow,
// maxRadius: 30.0,
// child: IconButton(
//
// onPressed: ()
// {
// Signout(context);
// },
// icon: Icon(Icons.logout),
// iconSize: 30.0,
// color: Colors.black,
// ),
// ),
//
// ],
// );
// }),
//
// fallback: (context)=>Center(child: CircularProgressIndicator()),
// ),