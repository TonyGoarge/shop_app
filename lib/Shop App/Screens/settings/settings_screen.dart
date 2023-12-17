import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/Cubit/DarkMode.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:switcher_button/switcher_button.dart';

class SettingsScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  var nameController=TextEditingController();
var emailController=TextEditingController();
var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state)
    {
      if (state is ShopSuccessUpdateUserDataState)
      {
        if (state.usermodel.status == true)
        {
          print(state.usermodel.message);
          ShowToast
            (
            text: state.usermodel.message.toString(),
            state: ToastStates.SUCCESS,
          );
        }

      else
      {
        print(state.usermodel.message);
        ShowToast
          (
          text: state.usermodel.message.toString(),
          state: ToastStates.ERROR,
        );
      }
      }

       },

      builder: (context,state) {
       var model=ShopCubit.get(context).usermodel;
       nameController.text=model!.data!.name.toString();
       emailController.text=model.data!.email.toString();
       phoneController.text=model.data!.phone.toString();
       return ConditionalBuilder(

         condition:ShopCubit.get(context).usermodel !=null,
         builder:(context)=>Padding(
         padding: const EdgeInsets.all(20.0),
         child: SingleChildScrollView(
           child: Form(
             key:formkey ,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children:
               [
                if(state is ShopLoadingUpdateUserDataState)
                  LinearProgressIndicator(),
                 Padding(
                   padding: const EdgeInsets.only(left:30.0,right: 30.0),
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Column(
                             children: [
                               CircleAvatar(
                                 backgroundColor: Colors.yellow,
                                 maxRadius: 30.0,
                                 child: IconButton(

                                   onPressed: ()
                                    {
                                     signout(context);
                                     },
                                   icon: Icon(Icons.logout),
                                   iconSize: 30.0,
                                   color: Colors.black,
                                 ),
                               ),
                                Text(
                           'SGIN OUT',
                           style:Theme.of(context).textTheme.bodyText1,

                           textAlign: TextAlign.center,
                         ),

                             ],
                           ),

                            Spacer(),
                           Column(
                             children: [
                               CircleAvatar(
                                 backgroundColor: Colors.yellow,
                                 maxRadius: 30.0,
                                 child: IconButton(

                                   onPressed: ()
                                    {
                                      if (formkey.currentState!.validate())
                                      {
                                        ShopCubit.get(context).UpdateUserData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                        );
                                      }

                                     },
                                   icon: Icon(Icons.person),
                                   iconSize: 30.0,
                                   color: Colors.black,
                                 ),
                               ),

                               Text(
                                       'UPDATE',
                                       style:Theme.of(context).textTheme.bodyText1,

                                       textAlign: TextAlign.center,
                                     ),
                             ],
                           ),


                         ],
                       ),

                     ],
                   ),
                 ),
                 SizedBox(height: 30.0,),
                 defaultformfield(
                     controller: nameController,
                     type: TextInputType.name,
                     label: 'Name',
                     prefix: Icons.person,
                     validate: (value)
                     {
                       if(value.isEmpty)
                       {
                         return 'Name Must Not be Empty';
                       }
                       return null;
                     }
                 ),
                 SizedBox(height: 20.0,),

                 defaultformfield(
                     controller: emailController,
                     type: TextInputType.emailAddress,
                     label: 'Email Address',
                     prefix: Icons.email,
                     validate: (value)
                     {
                       if(value.isEmpty)
                       {
                         return 'Email Must Not be Empty';
                       }
                       return null;
                     }
                 ),
                 SizedBox(height: 20.0,),
                 defaultformfield(
                     controller: phoneController,
                     type: TextInputType.phone,
                     label: 'Phone',
                     prefix: Icons.phone,
                     validate: (value)
                     {
                       if(value.isEmpty)
                       {
                         return 'phone Must Not be Empty';
                       }
                       return null;
                     }
                 ),
                 SizedBox(height: 20.0,),
                 // Row(
                 //   children:[
                 //     Text(
                 //         'Dark Mode',
                 //       style:Theme.of(context).textTheme.bodyText1,
                 //     ),
                 //     Spacer(),
                 //
                 //     IconButton(
                 //       icon: Icon(Icons.brightness_4_outlined),
                 //       onPressed: ()
                 //       {
                 //         DarkCubit.get(context).changeAppMode();
                 //
                 //         },
                 //     ),
                 //   ],
                 //
                 // ) ,
                 Row(
                   children:[
                     Text(
                         'Dark Mode',
                       style:Theme.of(context).textTheme.bodyText1,
                     ),
                     Spacer(),

                     SwitcherButton(onColor: Colors.pink,
                         onChange:(value) {
                           DarkCubit.get(context).changeAppMode();
                         }),
                   ],

                 ) ,
               ],
             ),
           ),
         ),
       ),
         fallback: (context)=>Center(child: CircularProgressIndicator()),
       );
      },
    );

  }
}
