import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shop_app/News%20App/Components/Component.dart';
import 'package:shop_app/News%20App/Cubit/Cubit.dart';
import 'package:shop_app/News%20App/Cubit/States.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return ScreenTypeLayout(
          mobile: Builder(builder:(context)
          {
            NewsCubit.get(context).setDesktop(false);
            return articleBuilder(list, context);
          }),
          desktop: Builder(
            builder: (context)
            {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: articleBuilder(list, context),
                  ),
                  if(list.isNotEmpty )
                    Expanded(
                        child: Container(
                          height: double.infinity,
                          color: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              '${list[NewsCubit.get(context).selectedbusinessitem]['description']}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        )),
                ],
              );
            },
          ),

          breakpoints:
              ScreenBreakpoints(desktop: 600.0, watch: 300.0, tablet: 300.0),
        );
      },
    );
  }
}
