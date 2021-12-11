abstract class LoginStates{}

class initialState extends LoginStates{}

class ChangeEye extends LoginStates{}
/// Auth states
class LogInLoadingState extends LoginStates{}
class LogInSuccessState extends LoginStates{}
class GoogleSignInSuccess extends LoginStates{}

class RegisterLoadingState extends LoginStates{}
class RegisterSuccessState extends LoginStates{}
class SendRepassword extends LoginStates{}

class OTBVerifySuccessState extends LoginStates{}
class OTBVerifyErrorState extends LoginStates{}
class OTBSendSuccessState extends LoginStates{}
class OTBSendErrorState extends LoginStates{}
