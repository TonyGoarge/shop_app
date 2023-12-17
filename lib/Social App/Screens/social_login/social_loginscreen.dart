import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Screens/social_layout.dart';
import 'package:shop_app/Social%20App/Screens/social_login/cubit/cubit.dart';

import 'package:shop_app/Social%20App/Screens/social_login/cubit/states.dart';
import 'package:shop_app/Social%20App/Screens/social_register/register_screen.dart';

import '../../../News App/Components/Constant.dart';


class SocialLoginScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

      create: (BuildContext context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
            {
              ShowToast(text: state.error, state: ToastStates.ERROR,);
            }
          if(state is SocialLoginSuccessState)
            {
              CachHelper.saveData(
                key: 'uId', value: state.uId,).then((value)
              {
                uId = state.uId ;
                SocialCubit.get(context).getUserData();
                NavigatorandFinish(context, sociallayout(),);
              });
            }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Image(
                            image: AssetImage('images/onboard_5.png')),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            'LOGIN',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4!
                                .copyWith
                              (color: Colors.black,)

                        ),
                        Text(
                            'Login now to communicate with friends',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith //copywith دي بستخدمها عشان اعدل علي
                              (color: Colors.grey,)

                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultformfield(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          onSubmit: (value) {
                            if (formkey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                              );
                            }
                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfield(
                          controller: passwordcontroller,
                          type: TextInputType.visiblePassword,
                          suffix:SocialLoginCubit.get(context).suffix,
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).ChangePasswordVisibility();
                          },


                          onSubmit: (value) {
                            if (formkey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }

                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,

                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context)=>


                                defaultbotton(
                                  text: "login",
                                  function: ()
                                  {
                                    if (formkey.currentState!.validate())
                                    {
                                      SocialLoginCubit.get(context).userLogin(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                      );
                                    }
                                  },

                                  width: double.infinity,
                                  toUpperCase: true,
                                  radius: 10.0,
                                ),


                            fallback: (context)=>Center(child: CircularProgressIndicator(),)),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Text(
                                'Don\'t have an account?',
                              ),

                              defaulttextbutton(
                                  toUpperCase: false,
                                  text: 'Register',
                                  onpress: ()
                                  {
                                    NavigatorandFinish(
                                      context, SocialRegisterScreen(),);
                                  }
                                  ),

                            ]
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
