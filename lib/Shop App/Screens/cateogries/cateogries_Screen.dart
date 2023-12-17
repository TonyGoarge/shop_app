
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:shop_app/Shop%20App/Screens/cateogriesdetail.dart';
import 'package:shop_app/Shop%20App/models/Categories_Model.dart';


class CateogriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,index){},
      builder: (context,index)
      {
      return  InkWell(
        onTap: ()
        {
          NavigatorTo(context,CateogriesDetail());

        },
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index)=>MyDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,),
      );
      },
    );

  }

  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
         Image(
          image:NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(

          Icons.arrow_forward_ios,),

      ],
    ),
  );
}
