import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Components/Constant.dart';
import 'package:shop_app/News%20App/Network/end_points.dart';
import 'package:shop_app/News%20App/Network/remote/dio.helper.dart';
import 'package:shop_app/Shop%20App/Screens/search/Cubit/searchstates.dart';
import 'package:shop_app/Shop%20App/models/search_model.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchIntialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  late SearchModel model;
  void search (String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
      url:SEARCH,
      token: token,

      data: {
        'text':text,
      },
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}