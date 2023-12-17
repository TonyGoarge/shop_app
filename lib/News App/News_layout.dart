
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Components/Component.dart';
import 'Cubit/Cubit.dart';
import 'Cubit/DarkMode.dart';
import 'Cubit/States.dart';
import 'Search/Search_Screen.dart';



class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<NewsCubit,NewsStates>(
      listener: ( context, state) {},
      builder: ( context, Object? state) {
        var cubit = NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title:  Text(
                'News App'
            ),
              actions: [
          IconButton(
          icon: Icon(Icons.search),
          onPressed: ()
          {
            NavigatorTo(context, SearchScreen(),);
          },
        ),
          IconButton(
          icon: Icon(Icons.brightness_4_outlined),
          onPressed: ()
          {
            DarkCubit.get(context).changeAppMode();
          },
        ),
        ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.Changeindex(index);
            },
            items:cubit.bottomnavigation ,

          ),
        );
      },
    );
  }
}
