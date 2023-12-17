import 'package:shop_app/Shop%20App/models/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
 final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}
class ShopChangePasswordvisibilityState extends ShopLoginStates{}
class ShopLoginErrorState extends ShopLoginStates
{
  final String error;
  ShopLoginErrorState(this.error);
}