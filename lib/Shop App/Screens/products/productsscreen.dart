import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:shop_app/Shop%20App/models/Categories_Model.dart';
import 'package:shop_app/Shop%20App/models/Home_Model.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
          {
            if(state.model.status==false)
              {
                ShowToast(text: state.model.message.toString(), state: ToastStates.ERROR,);
              }
          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homemodel != null && ShopCubit.get(context).categoriesModel !=null,
          builder: (context) =>
              productbuilder(ShopCubit.get(context).homemodel!,ShopCubit.get(context).categoriesModel!,context),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productbuilder(HomeModel model,CategoriesModel categoriesModel,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            CarouselSlider(
              items:model.data!.banners.map((e) =>  Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),).toList(),

              options: CarouselOptions(
                height: 150.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                   SizedBox(
                    height: 10.0,),
                   Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,

                        itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data[index]),
                        separatorBuilder:(context,index)=>const SizedBox(width: 10.0,) ,
                        itemCount: categoriesModel.data!.data.length,
                    ),
                  ),
                   SizedBox(
                    height: 20.0,),
                   Text(
                    'New Products',
                     style:Theme.of(context).textTheme.bodyText2,

                   ),
                ],
              ),
            ),
            Container(
              color:Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount:2,
                mainAxisSpacing: 1.0,  //top and bottom
                crossAxisSpacing: 1.0,   //left and right
                childAspectRatio: 1/1.75,//width/height
                children: List.generate(model.data!.products.length,
                 (index) => buildGridProduct(model.data!.products[index],context),
                ),
              ),
            ),
          ],
        ),
      );


  Widget buildCategoryItem(DataModel model)=>Stack(

  alignment: AlignmentDirectional.bottomCenter,
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(70.0),
      child: Image(image:NetworkImage(model.image),
        height:100.0,
        width:100.0,
        fit: BoxFit.cover,

      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(70.0),

      child: Container(
        color:Colors.black.withOpacity(0.8),
        width:100.0,

        child: Text(

            model.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
fontSize: 16.0
            ),
        ),
      ),
    ),
  ],
);

  Widget buildGridProduct(productsModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
            width:double.infinity,
              height: 200.0,
            ),
            if(model.discount!=0)
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: const Text(
                'DISCOUNT',
                style:TextStyle(
                fontSize:10.0,
                  color: Colors.white,
              ),
              ),

            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                  color: Colors.black,
                ),
              ),

              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount !=0)
                  Text(
                    '${model.old_price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration:TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopCubit.get(context).Favorites[model.id]! ? defaultColor : Colors.grey,
                      child: Icon(
                        Icons.favorite,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id!);
                      print(model.id);
                    },

                  ),












                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
