abstract class NewsStates{}

class NewsIntialState extends NewsStates{}

class NewsbottomnavbarState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccesState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates
{
  final String error;

  NewsGetBusinessErrorState(this.error);

}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccesState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates
{
  final String error;

  NewsGetSportsErrorState(this.error);


}


class NewsGetSciencesLoadingState extends NewsStates{}

class NewsGetSciencesSuccesState extends NewsStates{}

class NewsGetSciencesErrorState extends NewsStates
{
  final String error;

  NewsGetSciencesErrorState(this.error);

}

class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccesState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates
{
  final String error;

  NewsGetSearchErrorState(this.error);

}






class AppChangeModeState extends NewsStates{}

