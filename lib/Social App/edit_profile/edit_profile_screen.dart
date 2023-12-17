import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Styles/iconBroken.dart';
import 'package:shop_app/Social%20App/Cubit/cubit.dart';
import 'package:shop_app/Social%20App/Cubit/staets.dart';

class EditProfileScreen extends StatelessWidget
{

var namecontroller=TextEditingController();
var phonecontroller=TextEditingController();
var biocontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder: (context,state)
      {
      var userModel=SocialCubit.get(context).usermodel;
      var profileImage=SocialCubit.get(context).profileimage;
      var coverImage=SocialCubit.get(context).coverimage;
      namecontroller.text=userModel!.name!;
      phonecontroller.text=userModel!.phone!;
      biocontroller.text=userModel!.bio!;

      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65.0),
            child: defaultAppBar(
                title: 'Edit Profile',
                context: context,
                actions: [
                  defaulttextbutton(
                    text: 'Update',
                    onpress: ()
                    {
                    SocialCubit.get(context).updateUser
                      (
                        name: namecontroller.text,
                        phone: phonecontroller.text,
                        bio: biocontroller.text
                    );
                    },
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                ]),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    SizedBox(
                  height: 10.0,
                ),
                  Container(
                    height: 180.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(4.0),
                                      bottomRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: coverImage ==null ? NetworkImage(
                                          '${userModel?.cover}'
                                      ) :  FileImage(coverImage) as ImageProvider,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getcoverimage();

                                  },
                                  icon: CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  ),
                                ),
                              ]),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null ? NetworkImage(
                                  '${userModel.image}',
                                ) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getprofileimage();
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).profileimage!=null || SocialCubit.get(context).coverimage!=null)
                  Row(
                    children: 
                    [
                      if(SocialCubit.get(context).profileimage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultbotton(
                              text: 'upload profile ',
                              function: ()
                              {
                                SocialCubit.get(context).uploadProfileImage(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    bio: biocontroller.text);
                              },
                            ),
                            if (state is SocialUserUpdateLoadingState)
                              SizedBox(
                              height: 5.0,
                            ),
                            if (state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),

                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if(SocialCubit.get(context).coverimage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultbotton(
                              text: 'upload cover ',
                              function: ()
                              {
                                SocialCubit.get(context).uploadCoverImage(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    bio: biocontroller.text);
                              },

                            ),
                            if (state is SocialUserUpdateLoadingState)
                              SizedBox(
                              height: 5.0,
                            ),
                            if (state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),

                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileimage!=null || SocialCubit.get(context).coverimage!=null)

                    SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(
                      controller: namecontroller,
                      validate:(value)
                      {
                        if(value.isEmpty)
                          {
                            return 'Name must not be empty';
                          }
                        return null;
                      },
                      type: TextInputType.name,
                      label: 'Name',
                      prefix: IconBroken.User,

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(
                    controller: phonecontroller,
                    validate:(value)
                    {
                      if(value.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    type: TextInputType.name,
                    label: 'Phone',
                    prefix: IconBroken.Call,

                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(
                      controller: biocontroller,
                      validate:(value)
                      {
                        if(value.isEmpty)
                          {
                            return 'Bio must not be empty';
                          }
                        return null;
                      },
                      type: TextInputType.name,
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

