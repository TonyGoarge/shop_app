import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Social%20App/Screens/social_login/cubit/states.dart';



class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit():super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin
      ({
    required String email,
    required String password,
      }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email
      , password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=false;
  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialChangePasswordvisibilityState());
  }

}

