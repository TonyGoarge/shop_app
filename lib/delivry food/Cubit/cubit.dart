import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/delivry%20food/Cubit/state.dart';
import 'package:shop_app/delivry%20food/screen/CardScreen.dart';
import 'package:shop_app/delivry%20food/screen/ProfileScreen.dart';
import 'package:shop_app/delivry%20food/screen/chatscreen.dart';
import 'package:shop_app/delivry%20food/screen/homescreen.dart';

class foodCubit extends Cubit<foodStates>
{
  foodCubit():super(foodInitialState());


  static foodCubit get(context)=>BlocProvider.of(context);
  int currentindex=0;




  List<Widget>bottomScreens=
  [
    HomeScreen(),
    ProfileScreen(),
    CardScreen(),
    ChatScreen(),

  ];

  void ChangeBottom(int index)
  {
    currentindex=index;
    emit(foodChangeBottomNavState());
  }


}