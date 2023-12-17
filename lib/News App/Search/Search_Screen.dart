
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Cubit/Cubit.dart';
import 'package:shop_app/News%20App/Cubit/States.dart';

class SearchScreen extends StatelessWidget {

var searchcontroller=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
     return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){

          var list=NewsCubit.get(context).Search;
      return Scaffold(
        appBar: AppBar(),
        body:Column(
          children:
          [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: defaultformfield(
                prefix:Icons.search ,
                controller:searchcontroller ,
                type: TextInputType.text,
                label: 'Search',
                onChanged: (value)
                {
                    NewsCubit.get(context).getsearchdata(value);
                },
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Expanded(child: articleBuilder(list, context,isSearch:true,),),
          ],
        ),
      );
    },
    );
  }
}
