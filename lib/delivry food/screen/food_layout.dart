

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:shop_app/delivry%20food/Cubit/cubit.dart';
import 'package:shop_app/delivry%20food/Cubit/state.dart';

import '../../News App/Styles/iconBroken.dart';

class foodLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<foodCubit,foodStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit=foodCubit.get(context);
        return Scaffold(

          body: cubit.bottomScreens[cubit.currentindex],
          bottomNavigationBar:
          BottomNavyBar(
            onItemSelected: (index)
            {
              cubit.ChangeBottom(index);
            },
            selectedIndex: cubit.currentindex,
            items:
            [

        BottomNavyBarItem(
        icon: Icon(Icons.home_filled),
      title: Text('Home',
        style: TextStyle(color: (Colors.black),),),
        activeColor:Colors.green,
          inactiveColor: Colors.greenAccent[200],

        ),
        BottomNavyBarItem(
        icon: Icon(Icons.person),
      title: Text('Profile',
      style: TextStyle(color: (Colors.black),),),

          activeColor:Colors.green,
          inactiveColor: Colors.greenAccent[200],

        ),
        BottomNavyBarItem(
        icon: Icon(Icons.shopping_cart),
      title: Text(
      'Cart',
      style: TextStyle(color: (Colors.black),),),

          activeColor:Colors.green,
          inactiveColor: Colors.greenAccent[200],
        ),
        BottomNavyBarItem(
        icon: Icon(IconBroken.Chat),
      title: Text(
        'Chat',
        style: TextStyle(color: (Colors.black),),),

          activeColor:Colors.green,
          inactiveColor: Colors.greenAccent[200],

        ),

            ],
          ),
        );
      },
    );
  }
}
