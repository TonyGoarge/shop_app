import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Network/end_points.dart';
import 'package:shop_app/News%20App/Network/remote/dio.helper.dart';
import 'package:shop_app/Shop%20App/login/cubit/states.dart';
import 'package:shop_app/Shop%20App/models/login_model.dart';



class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
 late ShopLoginModel loginModel;
  void userLogin
      ({
    required String email,
    required String password,
      })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
    url: LOGIN,                       //End point
    data:
    {
      'email':email,
      'password':password,
    },
).then((value)
{
  print (value.data);
loginModel=ShopLoginModel.fromJson(value.data);


  print (value.data['massage']);
  emit(ShopLoginSuccessState(loginModel));
}).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));

    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=false;
  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopChangePasswordvisibilityState());
  }




}

