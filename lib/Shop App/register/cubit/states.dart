import 'package:shop_app/Shop%20App/models/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates
{
 final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}
class ShopRegisterChangePasswordvisibilityState extends ShopRegisterStates{}
class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;
  ShopRegisterErrorState(this.error);
}