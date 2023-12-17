// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../Cubit/cubit.dart';
// import '../../Cubit/staets.dart';
//
// class chatscreen extends StatelessWidget {
//   const chatscreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit,SocialStates>(
//       listener: (context,state){},
//       builder: (context,state){
//         return ConditionalBuilder(
//           condition: true,//SocialCubit.get(context).users.length>0,
//           builder: (context)=>ListView.separated(
//             physics: BouncingScrollPhysics(),
//             itemBuilder: (context,index)=>buildChatItem(context),//SocialCubit.get(context).users[index]),
//             separatorBuilder: (context, index)=> MyDivider(),
//             itemCount: 2,//SocialCubit.get(context).users.length,
//           ),
//           fallback: (context)=>Center(child: CircularProgressIndicator()),
//         );
//
//       },
//
//     );
//   }
//
//   Widget buildChatItem (context)=> InkWell(
//     onTap: ()
//     {
//       NavigatorTo(context, ChatGPT());
//     },
//     child: Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           Row(
//             children:
//             [
//               CircleAvatar(
//                   radius: 25.0,
//                   backgroundImage: NetworkImage(
//                       'https://blog.routinehub.co/content/images/2023/02/openAI-chat-gpt-1.jpg'
//                   )
//               ),
//               SizedBox(
//                 width: 15.0,),
//               Text(
//                 'Chat GPT 3.0',
//                 style: TextStyle(
//                   height: 1.4,
//                   fontSize: 17.0,
//
//                 ),
//               ),
//
//             ],
//
//
//           ),
//           SizedBox(
//             height: 20.0,),
//           Row(
//             children:[
//               Text(
//                 'Dark Mode',
//                 style:Theme.of(context).textTheme.bodyText1,
//               ),
//               Spacer(),
//               SwitcherButton(onColor: Colors.pink,
//                   onChange:(value) {
//                     DarkCubit.get(context).changeAppMode();
//                   }),
//             ],
//
//           ) ,
//           SizedBox(
//             height: 20.0,),
//           TextButton(
//             onPressed: ()
//             {
//               Signout(context);
//             }, child: Text('Sign out'),),
//         ],
//       ),
//
//     ),
//   );
//
// }
//
// }
// }
