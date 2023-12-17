import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Network/end_points.dart';
import 'package:shop_app/News%20App/Network/remote/dio.helper.dart';
import 'package:shop_app/Shop%20App/models/login_model.dart';
import 'package:shop_app/Shop%20App/register/cubit/states.dart';



class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
 late ShopLoginModel loginModel;
  void userRegister
      ({
    required String name,
    required String email,
    required String phone,
    required String password,

      })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
    url: REGISTER,                       //End point
    data:
    {

      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
    },
).then((value) 
{
  print (value.data);
  loginModel=ShopLoginModel.fromJson(value.data);


  print (value.data['massage']);
  emit(ShopRegisterSuccessState(loginModel));
}).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));

    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=false;
  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordvisibilityState());
  }

}

