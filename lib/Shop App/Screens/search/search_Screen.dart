import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/Shop%20App/Screens/search/Cubit/searchcubit.dart';
import 'package:shop_app/Shop%20App/Screens/search/Cubit/searchstates.dart';

class SearchScreen extends StatelessWidget {
var formkey=GlobalKey<FormState>();
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body:Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [

                    defaultformfield(
                        controller: searchController,
                        type: TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search,
                      onSubmit: (String text)
                        {
                          SearchCubit.get(context).search(text);
                        },
                      validate: ( value)
                        {
                          if(value.isEmpty)
                            {
                              return 'Enter Text To Search';
                            }
                          return null;
                        }
                         
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState ==true)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context,index)=>buildProductItem(SearchCubit.get(context).model.data!.data![index],context,isOldprice: false),
                            separatorBuilder: (context,index)=>MyDivider(),
                            itemCount:10,
                          ),
                        ),



                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
