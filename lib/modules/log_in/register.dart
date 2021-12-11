import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/log_in/welcome_screen.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/component.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<LogInCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 380, horizontal: 15),
                      child: Text('Register', style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 30),)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 450, horizontal: 15),
                    child: defaultTextFormFeild(
                        controller: nameController,
                        pre: Icons.person,
                        HintText: 'Name',
                        KeyType: TextInputType.text,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 520, horizontal: 15),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 590),
                    child: defaultTextFormFeild(
                        controller: passwordController,
                        pre: Icons.password_outlined,
                        HintText: 'Password',
                        KeyType: TextInputType.visiblePassword,
                        suff: LogInCubit
                            .get(context)
                            .eyeIcon,
                        isObscure: LogInCubit
                            .get(context)
                            .isAppear,
                        suffPress: () {
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
                  condition: state is! RegisterLoadingState,
                    builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 680),
                        child: defaultButton(onPress: () {
                          if(formKey.currentState.validate())
                          {
                            LogInCubit.get(context).registerAuth(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text ,
                              context: context,
                            );
                          }
                        }, text: 'register',),
                    ),
                    fallback: (context)=>const Padding(
                      padding:  EdgeInsets.symmetric(horizontal:0 , vertical: 680),
                      child:  LinearProgressIndicator(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 730, horizontal: 15),
                    child: Row(
                      children: [
                        Text('Already have one?', style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.blue[900]),),
                        TextButton(onPressed: () {
                          navigateTo(context, WelcomeScreen());
                        }, child: Text(' LOG IN', style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.blue[900]),),
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
