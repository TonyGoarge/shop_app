import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Network/local/cache_helper.dart';

import 'States.dart';

class DarkCubit extends Cubit<NewsStates> {

  DarkCubit() : super(NewsIntialState());

  static DarkCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else {
      isDark = !isDark;
      CachHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      }


      );
    }
    }
  }
