import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/Social%20App/Cubit/staets.dart';
import 'package:shop_app/Social%20App/Screens/chats/chats_screen.dart';
import 'package:shop_app/Social%20App/Screens/feeds/feeds_screen.dart';
import 'package:shop_app/Social%20App/Screens/notification/notification.dart';
import 'package:shop_app/Social%20App/models/post_model.dart';
import 'package:shop_app/Social%20App/models/social_user_model.dart';

import '../Screens/search/search_screen.dart';
import '../Screens/settings/settings_screen.dart';
import '../Screens/users/users_screen.dart';
import '../models/message_model.dart';
import '../new_post/new_post_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{

  SocialCubit():super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? usermodel;
void getUserData()
{
  emit(SocialGetUserLoadinglState());
FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .get()
    .then((value)
{
  print (value.data());
  usermodel=SocialUserModel.fromjson(value.data()!);
  emit(SocialGetUserSuccessState());
}).catchError((error) {
  print(error.toString());
  emit(SocialGetUserErrorState(error.toString()));
});

}


int currentindex=0;
List<Widget>screens=[
  FeedsScreen(),
  ChatsScreen(),
  NewPostScreen(),
  UsersScreen(),
  SettingsScreen(),

];
List<String> titles=
    [
      'Home',
      'Chat',
      'Post',
      'Users',
      'Setting',
    ];
void changeBottomNav(int index)
{
  if(index ==1)
    {
      getUsers();
    }
  if (index == 2) {
    emit(SocialNewPostState());
  } else
  {

    currentindex = index;

    emit(SocialChangeBottomNavState());
  }
}



  File? profileimage;
  var picker = ImagePicker();

  Future<void> getprofileimage()
  async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      profileimage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }

  }



File? coverimage;

  Future<void> getcoverimage()
  async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      coverimage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }

  }

void uploadProfileImage({                                                      //هنا بيعمل update لل image و ملوش دعوة بالمعلومات
  required String name,
  required String phone,
  required String bio,
})
{
  emit(SocialUserUpdateLoadingState());
  firebase_storage.FirebaseStorage.instance
      .ref()
      .child('user/${Uri.file(profileimage!.path).pathSegments.last}')
      .putFile(profileimage!)
      .then((value) 
  {
    value.ref.getDownloadURL().then((value)
    {
      // emit(SocialUploadProfileImageSuccessState());
      print (value);
      updateUser(
        name: name,
        phone: phone,
        bio: bio,
        image: value,
      );
    }).catchError((error)
    {
      emit(SocialUploadProfileImageErrorState());
    });
  }).catchError((error)
  {
    emit(SocialUploadProfileImageErrorState());

  });
}


void uploadCoverImage({                                                    //هنا بيعمل update لل cover و ملوش دعوة بالمعلومات
  required String name,
  required String phone,
  required String bio,
})
{
  emit(SocialUserUpdateLoadingState());

  firebase_storage.FirebaseStorage.instance
      .ref()
      .child('user/${Uri.file(coverimage!.path).pathSegments.last}')
      .putFile(coverimage!)
      .then((value)
  {
    value.ref.getDownloadURL().then((value)
    {
      //emit(SocialUploadCoverImageSuccessState());
      print (value);
      updateUser(
          name: name,
          phone: phone,
          bio: bio,
        cover: value,
      );
    }).catchError((error)
    {
      emit(SocialUploadCoverImageErrorState());
    });
  }).catchError((error)
  {
    emit(SocialUploadCoverImageErrorState());

  });
}


void updateUser({                                                 //كدا بعمل update للمعلومات و بقوله يرجع image=قيمهم القديمة , cover =قيمهم القديمة
  required String name,
  required String phone,
  required String bio,
  String ? image,
  String ? cover,
})
{
  // emit(SocialUserUpdateErrorState());
  // if(coverimage != null)
  //   {
  //     uploadCoverImage();
  //   }else if(profileimage !=null)
  //     {
  //       uploadProfileImage();
  //     }else if (coverimage != null &&profileimage !=null )
  //       {
  //
  //       } else
        {
          SocialUserModel model=SocialUserModel(
            name:name,
            email: usermodel!.email,
            phone:phone,
            uId: usermodel!.uId,
            bio:bio,
             image:image??usermodel!.image,
            cover: cover??usermodel!.cover,
            isEmailVerified: false,
          );

          FirebaseFirestore.instance
              .collection('users')
              .doc(usermodel!.uId)
              .update(model.toMap())
              .then((value)
          {

            getUserData();
          })
              .catchError((error)
          {
            emit(SocialUserUpdateErrorState());
          });
        }
        }

  File? postimage;

  Future<void> getpostimage()
  async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      postimage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }

  }

  void removepostimage()
  {
    postimage=null;
    emit(SocialRemovePostImageState());
  }

  void uploadpostimage({
    required String datetime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        print (value);
        createpost(
            datetime: datetime,
            text: text,
            postimage: value);

      }).catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());

    });
  }


  void createpost({

    required String datetime,
    required String text,
     String? postimage,
  })
  {

    {
      emit(SocialCreatePostLoadingState());

      PostModel model=PostModel(
        name:usermodel!.name,
        uId: usermodel!.uId,
        image:usermodel!.image,
        datetime: datetime,
        text: text,
        postimage: postimage??'',
      );

      FirebaseFirestore.instance
          .collection('posts')
          .add(model.toMap())
          .then((value)
      {
          emit(SocialCreatePostSuccessState());
      })
          .catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    }
  }

List<PostModel>posts=[];
List<String>postsId=[];
List<int>likes=[];
  void getposts()
  {
    emit(SocialGetPostLoadinglState());
FirebaseFirestore.instance
    .collection('posts')
    .get()
    .then((value)
{

  value.docs.forEach((element)
  {
    element.reference.collection('likes').get().then((value)
    {
      likes.add(value.docs.length);
      postsId.add(element.id);
      posts.add(PostModel.fromjson(element.data()));
    });

  });
  emit(SocialGetPostSuccessState());
})
    .catchError((error)
{
  emit(SocialGetPostErrorState(error.toString()));
});
  }


void likePosts(String postId)
{
FirebaseFirestore.instance
    .collection('posts')                          //make like on posts
    .doc(postId)                                 //get posts id
    .collection('likes')                        //make new collection for like
    .doc(usermodel!.uId)                       //my id to make like
    .set({
  'like':true,
})
    .then((value)
{
  emit(SocialLikePostSuccessState());
})
    .catchError((error)
{
  emit(SocialLikePostErrorState(error.toString()));
});
}


List<SocialUserModel>users =[];


  void getUsers()
  {
if(users.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {

      value.docs.forEach((element)
      {
        if(element.data()['uId']!=usermodel!.uId)               //كدا هيجيب كل users معادا انااااا
        {
          users.add(SocialUserModel.fromjson(element.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
    }

    void sendMessage({                            //محتاج 4 حاجات  / senderId / ReciverId /  DateTime / Text
      required String receiverId,
      required String datetime,
      required String text,
})
    {
      MessageModel model = MessageModel(
        senderId:usermodel?.uId,
        receiverId: receiverId,
        datetime: datetime,
        text:text,
      );

      //هودي عندي انا
      FirebaseFirestore.instance
          .collection('users')             //في collection users
        .doc(usermodel?.uId)               // انا
      .collection('chat')                 // هعمل chat
      .doc(receiverId)                     //مع mohamed(recever)
      .collection('messages')
      .add(model.toMap())
      .then((value) =>
      {
        emit(SocialSendMessageSuccessState()),
      })
      .catchError((error)
      {
        emit(SocialSendMessageErrorState());
      });


      // هودي عند mohamed
      FirebaseFirestore.instance
          .collection('users')             //في collection users
          .doc(receiverId)               // انا
          .collection('chat')                 // هعمل chat
          .doc(usermodel?.uId)                     //مع mohamed(recever)
          .collection('messages')
          .add(model.toMap())
          .then((value) =>
      {
        emit(SocialSendMessageSuccessState()),
      })
          .catchError((error)
      {
        emit(SocialSendMessageErrorState());
      });
    }

    List<MessageModel>messages=[];
    void getMessages({
      required String receiverId,
})
    {
      FirebaseFirestore.instance
          .collection('users')
          .doc(usermodel?.uId)                                 //انااااا
          .collection('chat')
          .doc(receiverId)                                     //mohamed ..اللي بكلمه
          .collection('messages')
      .orderBy('datetime')
          .snapshots()
          .listen((event)                                 //listen بيجيب masssegs كلها منن الاول
      {
        messages= [];                                   // هنا صفرة list
        event.docs.forEach((element)
        {
            messages.add(MessageModel.fromjson(element.data()));
        });
         emit(SocialGetMessageSuccessState());
      });
    }

}
