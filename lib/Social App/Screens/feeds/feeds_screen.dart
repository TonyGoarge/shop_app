import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Styles/Colors.dart';
import 'package:shop_app/News%20App/Styles/iconBroken.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Cubit/staets.dart';
import 'package:shop_app/Social%20App/models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  var commentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).usermodel !=null,   //length>0 = isNotEmpty
          builder: (context)=> SingleChildScrollView(
            child: Column(
              children:
              [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children:
                      [
                        Image.network(
                          'https://img.freepik.com/free-psd/business-networking-technology-template-psd-poster_53876-138246.jpg',
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Error loading image');
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ]

                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:(context,index)=>  buildpostitem (SocialCubit.get(context).posts[index],context,index),
                  itemCount: SocialCubit.get(context).posts.length,
                  separatorBuilder: (context,index)=>SizedBox(height: 8.0),
                ),
                SizedBox(
                  height: 8.0,),

              ],
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
  Widget buildpostitem (PostModel model,context,index)=> Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
          horizontal: 8.0
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row(
              children:
              [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:NetworkImage(
                      '${model.image}',
                  ),
                ),
                SizedBox(
                  width: 15.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        children:
                        [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                                height: 1.4,
                              fontSize: 17.0,

                            ),
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                         Icon(Icons.check_circle,
                         color: defaultColor,
                         size: 16.0,

                         )
                        ],
                      ),
                      Text(
                        '${model.datetime}',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          height: 1.4,
                        ),



                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.more_horiz,
                  size: 18.0,)),

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
                width: double.infinity,
              ),
            ),
            Text(
              '${model.text}',
            style:Theme.of(context).textTheme.subtitle1,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 5.0,
            //     top: 5.0,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children:
            //       [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                   '#Software',
            //                   style: Theme.of(context).textTheme.caption?.copyWith(
            //                     color: defaultColor,
            //                   )
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                   '#Software',
            //                   style: Theme.of(context).textTheme.caption?.copyWith(
            //                     color: defaultColor,
            //                   )
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               child: Text(
            //                   '#Software_development',
            //                   style: Theme.of(context).textTheme.caption?.copyWith(
            //                     color: defaultColor,
            //                   )
            //               ),
            //             ),
            //           ),
            //         ),
            //
            //
            //
            //
            //       ],
            //     ),
            //   ),
            // ),
            if(model.postimage!='')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15.0,),
              child: Container(
                width: double.infinity,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image:DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${model.postimage}'
                    ),
                  ),
                ),
              ),
            ),              //posts
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(

                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 18.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: ()
                      {
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),              //numbers ofLikes & comment
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                height: 1.0,
                color: Colors.grey[300],
                width: double.infinity,
              ),
            ),              // Write comment
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage:NetworkImage(
                              '${SocialCubit.get(context).usermodel!.image}') ,
                        ),
                        SizedBox(
                          width: 15.0,),
                        Text(
                          'Write a comment....',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                            height: 1.4,
                          ),
                        ),

                      ],
                    ),
                    onTap: ()

                    {

                    },
                  ),
                ),
                InkWell(
                  child: Row(

                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    SocialCubit.get(context).likePosts(SocialCubit.get(context).postsId[index]);

                  },
                ),
                SizedBox(width: 10.0,),
                InkWell(
                  child: Row(

                    children: [
                      Icon(
                        IconBroken.Send,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,),
                      Text(
                        'Share',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ],
            ),



          ],
        ),
      )
  );
}
