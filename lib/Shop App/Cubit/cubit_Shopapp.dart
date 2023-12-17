import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/Network/end_points.dart';
import 'package:shop_app/News%20App/Network/remote/dio.helper.dart';
import 'package:shop_app/Shop%20App/Cubit/States.dart';
import 'package:shop_app/Shop%20App/Screens/cateogries/cateogries_Screen.dart';
import 'package:shop_app/Shop%20App/Screens/chat/chatscreen.dart';
import 'package:shop_app/Shop%20App/models/GetFavoritesModel.dart';

import 'package:shop_app/Shop%20App/models/favoritesmodel.dart';
import 'package:shop_app/Shop%20App/Screens/favorities/favorities_Screen.dart';
import 'package:shop_app/Shop%20App/Screens/products/productsscreen.dart';
import 'package:shop_app/Shop%20App/Screens/settings/settings_screen.dart';
import 'package:shop_app/Shop%20App/models/Categories_Model.dart';
import 'package:shop_app/Shop%20App/models/Home_Model.dart';
import 'package:shop_app/Shop%20App/models/login_model.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentindex=0;




List<Widget>bottomScreens=
[
  ProductsScreen(),
  CateogriesScreen(),
  FavoritiesScreen(),
  SettingsScreen(),

];

  void ChangeBottom(int index)
  {
    currentindex=index;
    emit(ShopChangeBottomNavState());
  }




  HomeModel? homemodel;
  Map<int , bool>Favorites={};

  Future<void> getHomeData()async
  {
    emit(ShopLoadingHomeDataState());
    
   await DioHelper.getData(
        url: HOME,
        token:token,
    ).then((value)
    {
      homemodel=HomeModel.fromjson(value.data);

      // printfulltext(homemodel!.data!.banners[0].image.toString());
      // print(homemodel!.status);

    //to store favorites in Map
      homemodel!.data!.products.forEach((element)
      {
        Favorites.addAll({
          element.id!  : element.inFavorites!,

        });
      });
      print(Favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString(),);

emit(ShopErrorHomeDataState());
    });

  }





  CategoriesModel? categoriesModel;
  Future<void> getCategories()async
  {

   await DioHelper.getData(
        url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString(),);
emit(ShopErrorCategoriesState());
    });

  }

  ChangeFavoritesModel? changefavoritesmodel;
  Future<void>changeFavorites(int productId)
  async
  {

    Favorites[productId]=!Favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id':productId,},
      token: token,
    ).then((value)
    {
      changefavoritesmodel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      print(token.toString());
      if(changefavoritesmodel!.status==false)
        {
          Favorites[productId]=!Favorites[productId]!;
        }else{
        getFavorites();
      }
          emit(ShopSuccessChangeFavoritesState(changefavoritesmodel!));

    }).catchError((error)
    {
      Favorites[productId]=!Favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });

  }


  GetFavoriteModel? getfavoritemodel;
  void getFavorites()
  {
   emit(ShopLoadingGetFavoritesState());
     DioHelper.getData(
      url: FAVORITES,
      token: token
    ).then((value)
    {
      getfavoritemodel=GetFavoriteModel.fromJson(value.data);
      printfulltext(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString(),);
      emit(ShopErrorGetFavoritesState());
    });

  }


  ShopLoginModel? usermodel;
  void getUserData()
  {
   emit(ShopLoadingGetUserDataState());
     DioHelper.getData(
      url: PROFILE,
      token: token
    ).then((value)
    {
      usermodel=ShopLoginModel.fromJson(value.data);
      printfulltext(usermodel!.data!.name);

      emit(ShopSuccessGetUserDataState(usermodel!));
    }).catchError((error)
    {
      print(error.toString(),);
      emit(ShopErrorGetUserDataState());
    });

  }


  void UpdateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
   emit(ShopLoadingUpdateUserDataState());
     DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
       data:{
        'name':name,
        'email':email,
        'phone':phone,
       }
    ).then((value)
    {
      usermodel=ShopLoginModel.fromJson(value.data);
      printfulltext(usermodel!.data!.name);

      emit(ShopSuccessUpdateUserDataState(usermodel!));
    }).catchError((error)
    {
      print(error.toString(),);
      emit(ShopErrorUpdateUserDataState());
    });

  }
}