import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/News%20App/Styles/iconBroken.dart';
import 'package:shop_app/Shop%20App/Screens/Shop_Layout.dart';
import 'package:shop_app/Shop%20App/login/cubit/cubit.dart';
import 'package:shop_app/Shop%20App/register/cubit/cubit.dart';
import 'package:shop_app/Shop%20App/register/cubit/states.dart';

import '../login/shop_login_screen.dart';

class ShopRegisterScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state)
        {
          if(state is ShopRegisterSuccessState)
          {
            if(state.registerModel.status==true)
            {
              print(state.registerModel.message);
              print(state.registerModel.data!.token);

              CachHelper.saveData(
                key: 'token', value: state.registerModel.data!.token,).then((value)
              {
                token=state.registerModel.data!.token;  //عشان ممكن ال old token ميتعملوش kill فيحصل error لاكن بالسطر دا انا كدا ببعت ال token الجديد كل مرة ب login
                NavigatorandFinish(context, ShopLayout(),);
              });
            }
            else
            {

              print(state.registerModel.message);
              ShowToast(
                text:state.registerModel.message.toString() ,
                state:ToastStates.ERROR,

              );

            }
          }
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(

              leading:
                IconButton(onPressed: ()
                {
                  NavigatorandFinish(context, ShopLoginScreen(),);
                },
                    icon: Icon(IconBroken.Arrow___Left)),

            ),
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
                            'REGISTER',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4!
                                .copyWith
                              (color: Colors.black,)

                        ),
                        Text(
                            'Register now to browser our hot offers',
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
                          controller: namecontroller,
                          type: TextInputType.name,
                          label: 'User Name',
                          onSubmit: (value)
                          {

                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          prefix: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        defaultformfield(
                          controller: emailcontroller,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          onSubmit: (value)
                          {

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
                          controller: phonecontroller,
                          type: TextInputType.phone,
                          label: 'Phone +012',
                          onSubmit: (value)
                          {


                          },
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfield(
                          controller: passwordcontroller,
                          type: TextInputType.visiblePassword,
                          suffix:ShopRegisterCubit.get(context).suffix,
                          obscureText: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            ShopRegisterCubit.get(context).ChangePasswordVisibility();
                          },


                          onSubmit: (value)
                          {


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
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context)=> defaultbotton(
                                  text: "Submit",
                                  function: ()
                                  {
                                    if (formkey.currentState!.validate()){
                                      ShopRegisterCubit.get(context).userRegister(
                                        name: namecontroller.text,
                                        email: emailcontroller.text,
                                        phone:phonecontroller.text,
                                        password: passwordcontroller.text,
                                      );
                                    }
                                  },

                                  width: double.infinity,
                                  toUpperCase: true,
                                  radius: 5.0,
                              background: defaultboardColor,
                                ),


                            fallback: (context)=>Center(child: CircularProgressIndicator(),)),

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
