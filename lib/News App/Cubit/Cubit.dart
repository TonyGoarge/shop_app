

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/News%20App/Network/remote/dio.helper.dart';
import 'package:shop_app/News%20App/Screens/Business.dart';
import 'package:shop_app/News%20App/Screens/Sciences.dart';
import 'package:shop_app/News%20App/Screens/Sports.dart';

import 'States.dart';


class NewsCubit extends Cubit<NewsStates> {

  NewsCubit() : super(NewsIntialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem>bottomnavigation =
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),


  ];

  List<Widget>screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
    //   Settings_Screen(),
  ];

  void Changeindex(index) {
    currentIndex = index;
if(index==1)
  getSportsData();
if(index==2)
  getSciencesData();
    emit(NewsbottomnavbarState());
  }

  List<dynamic> business = [];
  // List<bool> businessSelectedItem = [];
  int selectedbusinessitem = 0;
  bool isDesktop =false;

  void setDesktop(bool value)
  {
    isDesktop = value;
    emit(NewsSetDesktoptate());
  }

  void getBusinessData()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country': 'us',
        'category': 'business',
        'apiKey': 'f9719cdb9dd94ea499f35af179fc1e7c',
      },
    ).then((value) {
      // print(value.data.toString());
      business = value.data['articles'];
      // business.forEach((element) {
      //   businessSelectedItem.add(false);
      // });
      print(business);
      emit(NewsGetBusinessSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void SelectBusiness(index)
  {
    // for (int i = 0 ; i< businessSelectedItem.length ;i++)
    //   {
    //     if(i ==index) {
    //       businessSelectedItem[i] = true;
    //     } else {
    //       businessSelectedItem[i] = false;
    //     }
    //   }

    selectedbusinessitem = index;
    emit(NewsSelectedBusinessItemState());
  }




  List<dynamic> Sports = [];

  void getSportsData()

  {
    if(Sports.length==0)
      {
        emit(NewsGetSportsLoadingState());
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'us',
            'category': 'sports',
            'apiKey': 'f9719cdb9dd94ea499f35af179fc1e7c',
          },
        ).then((value) {
          // print(value.data.toString());
          Sports = value.data['articles'];
          print(Sports);
          emit(NewsGetSportsSuccesState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }
    else{
      emit(NewsGetSportsSuccesState());
    }

  }



  List<dynamic> Sciences = [];

  void getSciencesData()
  {
    if(Sciences.length==0)
      {
        emit(NewsGetSciencesLoadingState());
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'us',
            'category': 'science',
            'apiKey': 'f9719cdb9dd94ea499f35af179fc1e7c',
          },
        ).then((value) {
          // print(value.data.toString());
          Sciences = value.data['articles'];
          print(Sciences);
          emit(NewsGetSciencesSuccesState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSciencesErrorState(error.toString()));
        });
      }
    else{
      emit(NewsGetSciencesSuccesState());

    }

      }



  List<dynamic> Search = [];

  void getsearchdata(String value)
  {
    Search = [];

      DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q': '$value',
          'apiKey': 'f9719cdb9dd94ea499f35af179fc1e7c',
        },
      ).then((value)
      {
        // print(value.data.toString());
        Search = value.data['articles'];
        print(Search);
        emit(NewsGetSearchSuccesState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
    }









  }



