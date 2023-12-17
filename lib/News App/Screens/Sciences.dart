
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Cubit/Cubit.dart';
import 'package:shop_app/News%20App/Cubit/States.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return
      BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var list=NewsCubit.get(context).Sciences;

          return articleBuilder(list,context);
        },
        //MyItemBuilder(list,context);

      );
  }
}
