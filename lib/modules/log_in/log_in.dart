import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/log_in/reset_password.dart';
import 'package:shop/modules/log_in/welcome_screen.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/component.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LogInCubit , LoginStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          body: SingleChildScrollView(
            physics:const NeverScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage('assets/logoh.jpg'),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 380 , horizontal: 15),
                      child: Text('LOG IN' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 30),)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 500 , horizontal: 15),
                    child: defaultTextFormFeild(
                      controller: emailController,
                      pre: Icons.email_outlined,
                      HintText: 'Email',
                      KeyType: TextInputType.emailAddress,
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return'This Field required';
                          }
                          return null;
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 575),
                    child: defaultTextFormFeild(
                      controller: passwordController,
                      pre: Icons.password_outlined,
                      HintText: 'Password',
                      KeyType: TextInputType.visiblePassword,
                      suff: LogInCubit.get(context).eyeIcon,
                      isObscure: LogInCubit.get(context).isAppear,
                      suffPress: ()
                      {
                        LogInCubit.get(context).changeEye();
                      },
                        validate: (String value)
                        {
                          if(value.isEmpty)
                          {
                            return'This Field required';
                          }
                          return null;
                        }
                    ),
                  ),
                  ConditionalBuilder(
                    condition:state is! LogInLoadingState ,
                    builder: (context)=> Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 680),
                        child:defaultButton(onPress: ()
                        {

                          if(formKey.currentState.validate())
                          {
                            LogInCubit.get(context).logInAuth
                              (
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );

                          }
                        }, text: 'LOGin' ,)

                    ),
                    fallback: (context) => const Padding(
                      padding:  EdgeInsets.symmetric(horizontal:0 , vertical: 680),
                      child:  LinearProgressIndicator(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 625 , horizontal: 15),
                    child: TextButton(onPressed: ()
                    {
                      navigateTo(context, ResetPassword());
                      LogInCubit.get(context).resetPassword(email: emailController.text);
                    }, child:const Text('Forget Password?')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 730 , horizontal: 15),
                    child: Row(
                      children: [
                        Text('Don\'t  have an account?' , style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.blue[900]),),
                        TextButton(onPressed: ()
                        {
                          navigateTo(context, WelcomeScreen());
                        }, child:Text(' SIGN UP' , style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.blue[900]),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
