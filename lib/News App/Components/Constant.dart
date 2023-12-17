// https://newsapi.org/v2/everything?q=tesla&apiKey=de05bd04e2fa43ada6eca1b40602cb1a


import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';
import 'package:shop_app/Shop%20App/login/shop_login_screen.dart';
import 'package:shop_app/Shop%20App/login/social_loginscreen2.dart';
import 'package:shop_app/Social%20App/Screens/social_login/social_loginscreen.dart';

void signout(context)
{
  CachHelper.removeData(key: 'token').then((value) {
    NavigatorandFinish(context, ShopLoginScreen(),);
  });
}

void Signout(context)
{
  CachHelper.removeData(key: 'uId').then((value) {
    NavigatorandFinish(context, SocialLoginScreen(),);
  });
}

void printfulltext(String? text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) =>print(match.group(0)));
}

String? token=CachHelper.getData(key: 'token');
String? uId=CachHelper.getData(key: 'uId');
String? id=uId;

// TextButton(onPressed:(){CachHelper.removeData(key: 'token').then((value) {
// NavigatorandFinish(context, ShopLoginScreen(),);
// });} , child: Text('LougOut',
// ),);



//       Column(
//       children: [
//         Row(
//           children:[
//             Text(
//               'Dark Mode',
//               style:Theme.of(context).textTheme.bodyText1,
//             ),
//             Spacer(),
//
//             SwitcherButton(onColor: Colors.pink,
//                 onChange:(value) {
//                   DarkCubit.get(context).changeAppMode();
//                 }),
//           ],
//
//         ) ,
//         SizedBox(height: 20.0,),
// TextButton(
//   onPressed: ()
// {
//   Signout(context);
// }, child: Text('Sign out'),)
//       ]
//     );
//   }