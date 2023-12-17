// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/News%20App/Components/Component.dart';
// import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
// import 'package:shop_app/Shop%20App/Screens/Shop_Layout.dart';
// import 'package:shop_app/Shop%20App/login/cubit/cubit.dart';
// import 'package:shop_app/Shop%20App/register/register_screen.dart';
// import 'package:shop_app/Social%20App/Screens/social_layout.dart';
// import 'package:shop_app/Social%20App/Screens/social_login/cubit/cubit.dart';
//
// import 'package:shop_app/Social%20App/Screens/social_login/cubit/states.dart';
// import 'package:shop_app/Social%20App/Screens/social_register/register_screen.dart';
//
//
// class StoreLoginScreen extends StatelessWidget {
//   final formkey = GlobalKey<FormState>();
//   var emailcontroller = TextEditingController();
//   var passwordcontroller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => SocialLoginCubit(),
//         child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
//         listener: (context,state)
//         {
//           if(state is SocialLoginErrorState)
//             {
//               ShowToast(text: state.error, state: ToastStates.ERROR,);
//             }
//           if(state is SocialLoginSuccessState)
//             {
//               CachHelper.saveData(
//                 key: 'uId', value: state.uId,).then((value)
//               {
//
//                 NavigatorandFinish(context, ShopLayout(),);
//                 ShowToast(text: state.uId, state: ToastStates.SUCCESS,);
//
//               });
//             }
//         },
//         builder: (context,state){
//           return Scaffold(
//             backgroundColor: Colors.transparent,
//             extendBodyBehindAppBar: true,
//             appBar: AppBar(
//               systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarBrightness: Brightness.light,
//               statusBarColor: Colors.transparent,
//               statusBarIconBrightness: Brightness.light,
//             ),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             ),
//             body: Stack(
//               alignment: AlignmentDirectional.bottomCenter,
//               children: [
//               Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage('images/onboard_4.jpg'),fit: BoxFit.cover
//                   )
//               ),
//             ),
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Form(
//                     key: formkey,
//
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                           border: Border.all(),
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(40.0),
//                             topLeft: Radius.circular(40.0),
//                           )),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children:
//                         [
//                           // Image(
//                           //     image: AssetImage('images/onboard_4.jpg'),
//                           //   width: 800.0,
//                           //   height: 200.0,
//                           //   fit: BoxFit.cover,
//                           // ),
//                           SizedBox(
//                             height: 15.0,
//                           ),
//                           Text(
//                               'LOGIN',
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .headline4!
//                                   .copyWith
//                                 (color: Colors.black,)
//
//                           ),
//                           Text(
//                               'Login now to make deals',
//                               style: Theme
//                                   .of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith //copywith دي بستخدمها عشان اعدل علي
//                                 (color: Colors.grey,)
//
//                           ),
//                           SizedBox(
//                             height: 30.0,
//                           ),
//
//                           defaultformfield(
//                             controller: emailcontroller,
//                             type: TextInputType.emailAddress,
//                             label: 'Email Address',
//                             onSubmit: (value) {
//                               if (formkey.currentState!.validate())
//                               {
//                                 SocialLoginCubit.get(context).userLogin(
//                                   email: emailcontroller.text,
//                                   password: passwordcontroller.text,
//                                 );
//                               }
//                             },
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please Enter Your Email';
//                               }
//                               return null;
//                             },
//                             prefix: Icons.email_outlined,
//                           ),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           defaultformfield(
//                             controller: passwordcontroller,
//                             type: TextInputType.visiblePassword,
//                             suffix:SocialLoginCubit.get(context).suffix,
//                             obscureText: SocialLoginCubit.get(context).isPassword,
//                             suffixPressed: ()
//                             {
//                               SocialLoginCubit.get(context).ChangePasswordVisibility();
//                             },
//
//
//                             onSubmit: (value) {
//                               if (formkey.currentState!.validate())
//                               {
//                                 SocialLoginCubit.get(context).userLogin(
//                                     email: emailcontroller.text,
//                                     password: passwordcontroller.text);
//                               }
//
//                             },
//                             validate: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Password is too short';
//                               }
//                               return null;
//                             },
//                             label: 'Password',
//                             prefix: Icons.lock_outline,
//
//                           ),
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           ConditionalBuilder(
//                               condition: state is! SocialLoginLoadingState,
//                               builder: (context)=>
//
//
//                                   defaultbotton(
//                                     text: "login",
//                                     function: ()
//                                     {
//                                       if (formkey.currentState!.validate())
//                                       {
//                                         SocialLoginCubit.get(context).userLogin(
//                                           email: emailcontroller.text,
//                                           password: passwordcontroller.text,
//                                         );
//                                       }
//                                     },
//
//                                     width: double.infinity,
//                                     toUpperCase: true,
//                                     radius: 10.0,
//                                   ),
//
//
//                               fallback: (context)=>Center(child: CircularProgressIndicator(),)),
//                           SizedBox(
//                             height: 15.0,
//                           ),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children:
//                               [
//                                 Text(
//                                   'Dont\'t have an account?',
//                                 ),
//
//                                 defaulttextbutton(
//                                     toUpperCase: false,
//                                     text: 'Register',
//                                     onpress: ()
//                                     {
//                                       NavigatorandFinish(
//                                         context, ShopRegisterScreen(),);
//                                     }
//                                     ),
//
//                               ]
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
