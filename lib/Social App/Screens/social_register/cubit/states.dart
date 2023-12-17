
abstract class SocialRegisterStates{}
class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterChangePasswordvisibilityState extends SocialRegisterStates{}
class SocialRegisterErrorState extends SocialRegisterStates
{
  SocialRegisterErrorState(error);

}



class SocialCreateUserSuccessState extends SocialRegisterStates {}

class SocialCreateUserErrorState extends SocialRegisterStates
{
  SocialCreateUserErrorState(error);

}





