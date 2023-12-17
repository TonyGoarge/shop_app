import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:shop_app/Shop%20App/Screens/search/search_Screen.dart';
import 'package:shop_app/Shop%20App/login/shop_login_screen.dart';

class ShopLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state){},
      builder: (context,state)
      {
        var cubit=ShopCubit.get(context);
       return Scaffold(
         appBar: AppBar(
           title:Text(
             'Salla',
           ),
           actions: [
             IconButton(icon:Icon(Icons.search),
               onPressed:()
               {
                NavigatorTo(context, SearchScreen(),);
               },
             ),
           ],
         ),
         body: cubit.bottomScreens[cubit.currentindex],
         bottomNavigationBar:
         BottomNavigationBar(
          onTap: (index)
           {
             cubit.ChangeBottom(index);
           },
           currentIndex: cubit.currentindex,
           items: 
           [
             BottomNavigationBarItem(
               icon: Icon(Icons.home,),
             label: 'Home',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.apps,),
             label: 'Cateogries',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.favorite,),
             label: 'Favrities',
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.settings,),
             label: 'Settings',
             ),

           ],
         ),
       );
      },
    );
  }
}
