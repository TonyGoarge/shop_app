import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Shop%20App/Screens/Shop_Layout.dart';
import 'package:shop_app/Shop%20App/login/cubit/cubit.dart';
import 'package:shop_app/Shop%20App/login/cubit/states.dart';
import 'package:shop_app/Shop%20App/models/login_model.dart';
import 'package:shop_app/Shop%20App/register/register_screen.dart';


class ShopLoginScreen extends StatelessWidget


{
final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();


    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
            listener: (context, state)
            {
              if(state is ShopLoginSuccessState)
                {
                  if(state.loginModel.status==true)
                    {
                      print(state.loginModel.message);
                      print(state.loginModel.data!.token);

                      CachHelper.saveData(
                        key: 'token', value: state.loginModel.data!.token,).then((value)
                      {
                        token=state.loginModel.data!.token;  //عشان ممكن ال old token ميتعملوش kill فيحصل error لاكن بالسطر دا انا كدا ببعت ال token الجديد كل مرة ب login
                        NavigatorandFinish(context, ShopLayout(),);
                      });
                    }
                  else
                      {

                        print(state.loginModel.message);
                        ShowToast(
                          text:state.loginModel.message.toString() ,
                          state:ToastStates.ERROR,

                        );

                      }
                }
            },
            builder: (context, state) {

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
                              height: 10.0,
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
                                'Login now to browser our hot offers',
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
                                  if (formkey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
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
                              hintStyle:TextStyle(
                                color: defaultboardColor,
                              ),

                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            defaultformfield(

                              controller: passwordcontroller,
                              type: TextInputType.visiblePassword,
                              suffix:ShopLoginCubit.get(context).suffix,
                              obscureText: ShopLoginCubit.get(context).isPassword,
                              suffixPressed: ()
                              {
                                ShopLoginCubit.get(context).ChangePasswordVisibility();
                              },


                              onSubmit: (value) {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
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
                                hintStyle:TextStyle(
                                    color: defaultboardColor,
                                  ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context)=>


                              defaultbotton(
                                text: "login",
                                function: ()
                                {
                                  if (formkey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                    );
                                  }
                                },
                                background:defaultboardColor,
                                width: double.infinity,
                                toUpperCase: true,
                                radius: 5.0,
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
                                   'Don\'t have an account |',
                                   style:Theme.of(context).textTheme.bodyText1,

                                 ),

                                  defaulttextbutton(
                                    toUpperCase: false,
                                      background: defaultboardColor,
                                    text: 'Register',

                                  onpress: (){
                                    NavigatorandFinish(
                                      context, ShopRegisterScreen(),);
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

