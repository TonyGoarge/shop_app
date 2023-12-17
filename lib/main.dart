import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/News_layout.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:shop_app/Shop%20App/Screens/Shop_Layout.dart';
import 'package:shop_app/Shop%20App/login/shop_login_screen.dart';
import 'package:shop_app/Shop%20App/login/social_loginscreen2.dart';
import 'package:shop_app/Shop%20App/register/register_screen.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Screens/chats/Models/provider_model.dart';
import 'package:shop_app/Social%20App/Screens/social_layout.dart';
import 'package:shop_app/Social%20App/Screens/social_login/social_loginscreen.dart';
import 'package:shop_app/delivry%20food/Cubit/cubit.dart';
import 'News App/Cubit/Cubit.dart';
import 'News App/Cubit/DarkMode.dart';
import 'News App/Cubit/States.dart';
import 'News App/Cubit/bloc_observer.dart';
import 'News App/Network/local/cache_helper.dart';
import 'News App/Network/remote/dio.helper.dart';
import 'News App/Styles/Themes.dart';
import 'Shop App/OnBoarding/On_Boarding Screen.dart';
import 'delivry food/screen/food_layout.dart';


Future<void>firebaseMessagingBackGroundHander(RemoteMessage message)async
{

  print('on background message');
  print(message.data.toString());
  ShowToast(text: 'on background message', state: ToastStates.SUCCESS);
}

void main()async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print("///////// "'$token');

  //forground FCM
  FirebaseMessaging.onMessage.listen((event)     //كدا app مفتوح  وانت شغال بالفعل عليه
  {
  print(event.data.toString());
  ShowToast(text: 'on message', state: ToastStates.SUCCESS);
  });

  //when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp .listen((event)   // app مفتوح بس في background
  {
  print(event.data.toString());
  ShowToast(text: 'on message opened app', state: ToastStates.SUCCESS);

  });

  //background  FCM
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroundHander);
  
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  bool? isDark=CachHelper.getData(key:'isDark');
  Widget widget;
  bool? onBoarding=CachHelper.getData(key:'onBoarding');
   // token=CachHelper.getData(key:'token');
   uId=CachHelper.getData(key:'uId');
  // print(token);


//  if(onBoarding !=null)      //كدا انا عديت من boarding
//    {
//      if(token !=null)
//      {
//        widget=ShopLayout();
//      }
//      else
//        {
//        widget=ShopLoginScreen();
//        // widget=StoreLoginScreen();
//        }
//
//    }
//  else
//  {
// widget=OnBoardingScreen();
// }




 if(uId != null)        //    بقوله طول ما انت معاك uid انت في sociallayout حصل مشكل ارجع لل loginscreen
   {
     widget=sociallayout();

   }
 else
   {
     widget=SocialLoginScreen();
   }



  runApp(MyApp(
    isDark: isDark,
    // StartWidget: widget,
    BegainWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{

  // @override
  // void initState(){
  //    super.initState();
  //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //     ShopLoginCubit();
  //   });
  // }
  // constructor
  // build
final bool? isDark;
// final Widget StartWidget;
final Widget BegainWidget;
MyApp({
  this.isDark,
  // required this.StartWidget,
  required this.BegainWidget,
});



  @override
  Widget build(BuildContext context)
  {
    return MultiProvider(
      providers:
      [
        ChangeNotifierProvider(create: (_) => ModelsProvider(),),

      ],
      child: MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context) => NewsCubit()
            ..getBusinessData()
            ..getSportsData()
            ..getSciencesData(),),
          BlocProvider(create: (context)=>DarkCubit()..changeAppMode(
            fromShared:isDark,
          ),),

          BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
          ),
          BlocProvider(create: (context)=>SocialCubit()..getUserData()..getposts()..getUsers(),
            //..getUsers(),
          ),


          // BlocProvider(create: (context)=>foodCubit(),
          // ),
        ],
        child: BlocConsumer<DarkCubit,NewsStates>(
          listener: (context,state){},
          builder: (context,state){
          return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:lightTheme,



              darkTheme:darkTheme,
            // themeMode:ShopDarkCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            themeMode:DarkCubit.get(context).isDark? ThemeMode.dark :ThemeMode.light,
              home:BegainWidget,
            );

          },
        ),
      ),
    );
  }
}