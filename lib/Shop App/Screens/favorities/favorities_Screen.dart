import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:shop_app/Shop%20App/models/GetFavoritesModel.dart';

class FavoritiesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return  ConditionalBuilder(
          
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context)=> ListView.separated(

            itemBuilder: (context,index)=>buildProductItem(ShopCubit.get(context).getfavoritemodel!.data!.data![index].product,context ),
            separatorBuilder: (context,index)=>MyDivider(),
            itemCount:ShopCubit.get(context).getfavoritemodel!.data!.data!.length,
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
