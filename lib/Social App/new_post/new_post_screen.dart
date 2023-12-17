import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Styles/iconBroken.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Cubit/staets.dart';

class NewPostScreen extends StatelessWidget {
var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65.0),
            child: defaultAppBar(
                context: context,
                title: 'Create Post',
                actions: [
                  defaulttextbutton(
                    onpress: ()
                    {
                      final now = DateTime.now();

                      if(SocialCubit.get(context).postimage==null)
                        {
                          SocialCubit.get(context).createpost(
                              datetime: now.toString(),
                              text: textController.text,
                          );
                        }else{
                        SocialCubit.get(context).uploadpostimage(
                            datetime: now.toString(),
                      text: textController.text,
                        );
                      }
                    },
                    text: 'Post',
                  )
                ]),
          ),

          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 18.0,
                      backgroundImage:NetworkImage(
                          '${SocialCubit.get(context).usermodel!.image}') ,
                    ),
                    SizedBox(
                      width: 15.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Row(
                            children: [
                              Text(
                                'Tony George',
                                style: TextStyle(
                                    height: 1.4
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what\'s on your mind ?',
                      border: InputBorder.none,

                    ),

                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                if(SocialCubit.get(context).postimage !=null)
                Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(SocialCubit.get(context).postimage!) as ImageProvider,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).removepostimage();

                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 20.0,
                            color:Colors.white ,
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: ()
                      {
                        SocialCubit.get(context).getpostimage();
                      },
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.center ,
                            children:
                            [
                              Icon(
                                IconBroken.Image,),
                              SizedBox(
                                width: 5.0,),
                              Text(
                                'Add Photo',)
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.center ,

                            children:
                            [

                              Text(
                                '# Tags',)
                            ],
                          ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        );
      },
    );
  }
}
