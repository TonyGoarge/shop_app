import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';
import 'package:shop_app/Shop%20App/Screens/search/search_Screen.dart';
import 'package:shop_app/Shop%20App/models/Home_Model.dart';

import '../../News App/Components/Component.dart';



class CateogriesDetail extends StatelessWidget {

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

          body: ConditionalBuilder(
        condition: ShopCubit.get(context).homemodel != null ,
        builder: (context) => productbuilder(ShopCubit.get(context).homemodel!,context),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
        ),


        );
      },
    );
  }

  Widget productbuilder(HomeModel model,context) =>
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
                  SizedBox(
                    height: 20.0,),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith( decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double,),
                  ),
                  SizedBox(
                    height: 10.0,),
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
                  SizedBox(
                    width: 5.0,),
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
