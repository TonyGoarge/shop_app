
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/News%20App/Screens/Web%20Screen.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/News%20App/Styles/iconBroken.dart';
import 'package:shop_app/Shop%20App/Cubit/cubit_Shopapp.dart';

Widget BulidArticalItem(articles,context) => InkWell(
  onTap: ()
  {
    NavigatorTo(context, WebViewScreen(articles['url']));
  },

  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120.0,

          width: 120.0,

          decoration: BoxDecoration(



              borderRadius: BorderRadius.circular(10.0),



              image:articles['urlToImage'] !=null ? DecorationImage(



                image: NetworkImage(

                    '${articles['urlToImage']}'

                ),

                fit: BoxFit.cover,

              ): const DecorationImage(

                image: NetworkImage(

                    'https://icon-library.com/images/no-image-available-icon/no-image-available-icon-6.jpg'

                ),

                fit: BoxFit.cover,

              ),

          ),

        ),

        SizedBox(

          width: 13.0,

        ),

        Expanded(



          child: Container(

            height: 120.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                    child: Text('${articles['title']}',

                      style:Theme.of(context).textTheme.bodyText1,

                      maxLines: 3,

                      overflow: TextOverflow.ellipsis,

                    ),

                ),

                Text('${articles['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);






Widget MyDivider()=> Padding(
  padding: const EdgeInsets.only(
    left: 20.0,
    right: 20.0,
  ),
  child: Container(
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list,context, {isSearch=false})=>  ConditionalBuilder(

  condition: list.length>0,
  // condition: state is! NewsGetBusinessLoadingState,
  builder: (context)=>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>BulidArticalItem(list[index],context),
        separatorBuilder: (context,index)=>MyDivider(),
        itemCount:list.length,),
  fallback:(context)=>isSearch? Container():Center(child: CircularProgressIndicator()),
);





Widget defaultformfield({
  required TextEditingController? controller,
  required TextInputType  type,
  String? hintText,
  required String label,
  final FormFieldValidator? validate,
 TextStyle? hintStyle =const TextStyle(
  color: defaultboardColor,
),


Function(String)? onChanged ,
   Function(String)? onSubmit ,
  IconData? suffix,
  VoidCallback? suffixPressed,
  required IconData? prefix,
  VoidCallback? onPressedfun,
  bool obscureText = false,

})=> Material(
  elevation: 0.0,
  borderRadius: BorderRadius.circular(30.0),
  child: Container(
    child:TextFormField(
      controller:controller,
      keyboardType:type,
      onChanged: onChanged,
      onFieldSubmitted:onSubmit,
      onTap: suffixPressed,
      validator: validate,
      obscureText:obscureText,
      style: TextStyle(
          color: Colors.black,
      ),
      cursorColor: defaultboardColor,

      decoration: InputDecoration(
        hintText:label,
        hintStyle:hintStyle,
        // new TextStyle(
        //   color: Colors.blue,
        // ),

        border:OutlineInputBorder(

          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(color: defaultboardColor),
            borderRadius: BorderRadius.circular(30.0)
        ),
        // focusedBorder:OutlineInputBorder(

        //   borderSide:
        //   BorderSide(
        //       color: Colors.grey,width: 1),
        // ),

        prefixIcon: Icon(
          prefix,
        ),

         suffixIcon: Icon(
          suffix,
        ),


      ),
    ),
  ),
);



void  NavigatorTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>  widget,
    )
);

void  NavigatorandFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>  widget,
    ),
    (Route<dynamic>route)=>false
);



Widget noitemshow({

  required List<Map> tasks,

}) =>ConditionalBuilder(

  condition: tasks.length>0,
  fallback: (BuildContext context) =>
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 44.0,),
            Text(
              'no item ,please add some item',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
  builder: (BuildContext context) {
    return ListView.separated(
        itemBuilder: (context,index) =>tasksmodelscreen(tasks[index],context),

        separatorBuilder: (context,index) => Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Container(
            height: 1.0,
            color: Colors.grey,
          ),
        ),
        itemCount: tasks.length);
  },
);

tasksmodelscreen(Map task, BuildContext context) {
}




Widget   defaulttextbutton({
  final VoidCallback? onpress,
  bool toUpperCase=true,
  Color background=Colors.blue,

  required String text,
})=>TextButton(

  onPressed: onpress,
  child: Text(
    toUpperCase?  text.toUpperCase():text,
    style: TextStyle(
      color: background,
    ),
  ),
);



Widget defaultbotton({
  width=double.infinity,
  height=40.0,
  Color background=Colors.blue,
  bool toUpperCase=true,
  final double radius=0.0,
  final VoidCallback? function,
  required String text,
      })=>

    Container(
      width: width,
      height:height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
            toUpperCase?  text.toUpperCase():text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,

      ),

    );

 Widget defaultAppBar({
   BuildContext?context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context!);
    },
    icon: Icon(IconBroken.Arrow___Left_2,),

  ),
  titleSpacing: 0.0,
  title: Text(
    title!
  ),
  actions: actions,
);





void ShowToast(
    {
      required String text,
      required ToastStates state ,
})=>
    Fluttertoast.showToast(

msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor:ChooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0,
    );

enum ToastStates{SUCCESS,ERROR,WARNING}
 Color ChooseToastColor(ToastStates state)
 {
   Color color;
   switch(state)
   {
     case ToastStates.SUCCESS:
       color=Colors.green;
       break;
     case ToastStates.ERROR:
       color=Colors.red;
       break;
     case ToastStates.WARNING:
       color=Colors.amber;
       break;
   }
   return color;
 }



//
// Widget defaultTextButton({
//   required Function function,
//   required String text,
// })=>
//     TextButton(
//       onPressed:function(),
//       child: Text(text.toUpperCase(),),
//     );


Widget buildProductItem( model,context,{bool? isOldprice=true,bool? isImage=true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),

              width:120.0,
              height: 120.0,
            ),
            if(model.discount!=0 && isOldprice!)
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
        SizedBox(
          width: 20.0,),
        Expanded(
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
                ),
              ),
              Spacer(),
              Row(

                children: [
                  Text(
                    model.price.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,),
                  if(model.discount !=0 && isOldprice!)
                    Text(
                      model.oldPrice.toString(),
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
                      backgroundColor: ShopCubit.get(context).Favorites[model.id]!  ? defaultColor : Colors.grey,
                      child: Icon(
                        Icons.favorite,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model!.id!);

                    },

                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);













