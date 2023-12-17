import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Social%20App/Screens/social_register/cubit/states.dart';
import 'package:shop_app/Social%20App/models/social_user_model.dart';




class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit():super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister
      ({
    required String name,
    required String email,
    required String phone,
    required String password,


      })
  {
    emit(SocialRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,)
      .then((value)
  {

    userCreate(
      name: name,
      email: email,
      phone:phone,

      uId: value.user!.uid,


    );
  }
  ).catchError((error)
  {
    emit(SocialRegisterErrorState(error.toString()));

  });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,

})

  {
    SocialUserModel model=SocialUserModel(
      name:name,
      email:email,
      phone:phone,
      uId:uId,
      bio:'write your bio ...',
      image:'https://scontent.fcai19-6.fna.fbcdn.net/v/t39.30808-6/329198178_682127243594542_9182108374722058472_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=3395wFNWyW8AX_A2ha2&_nc_ht=scontent.fcai19-6.fna&oh=00_AfA7zRcW4EiS90Bu27vTJnhkT7OnC1o1LE_PRna4qJAiMg&oe=6568D8E4',
      cover:'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.6435-9/116748293_2793899730838427_4670485397086931017_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=300f58&_nc_ohc=z8sZXtfcmdYAX-R5Zg9&_nc_ht=scontent.fcai19-6.fna&oh=00_AfCAvoHqu9ddGb3QrFrneT7YD7-qwGOQP2NEHXQvhBza3A&oe=658BC22A',
      isEmailVerified: false,
    );

FirebaseFirestore.instance
    .collection('users')
    .doc(uId)                          //عشان هشتغل علي uId
    .set(model.toMap())
    .then((value) {
      emit(SocialCreateUserSuccessState());
}).catchError((error){
  print(error.toString());
  emit(SocialCreateUserErrorState(error.toString()));

});
  }


  IconData suffix= Icons.visibility_outlined;
  bool isPassword=false;
  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordvisibilityState());
  }

}

