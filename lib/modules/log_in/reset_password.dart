import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/log_in/log_in.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/component.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var codeController = TextEditingController();
    return BlocConsumer<LogInCubit , LoginStates>(
          listener:(context , state)
          {
            if(state is OTBSendSuccessState)
              {
                snackBar(context, text: 'send to your email');

              }
            else if(state is OTBSendErrorState )
              {
                snackBar(context, text: 'Check your email!!' , color: Colors.red);
              }
            else if (state is OTBVerifySuccessState)
              {
                snackBar(context, text: 'Verified  ✅');
               navigateTo(context, LogInScreen(key: key,));
              }
            else if(state is OTBVerifyErrorState)
              {
                snackBar(context, text: 'Check the code again ❌' , color: Colors.red);
              }

          } ,
          builder:(context , state)
          {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state is RegisterSuccessState ? 'Email verification' : 'Reset Password' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20),),
                        const  SizedBox(height: 5,),
                        Text('Write down their your email then we will send you a massage with a verification code' , style: Theme.of(context).textTheme.caption.copyWith(fontSize: 15),),
                        const  SizedBox(height: 25,),
                        defaultTextFormFeild(
                          controller: emailController,
                          pre: Icons.email,
                          HintText: 'email',
                          KeyType: TextInputType.emailAddress,
                          suff: Icons.send,
                          suffPress: ()
                            {
                              LogInCubit.get(context).sendEmail(emailController.text);
                            }
                        ),
                        const  SizedBox(height: 15,),
                        defaultTextFormFeild(
                          controller: codeController,
                          pre: Icons.code,
                          HintText: 'Code',
                          KeyType: TextInputType.number,
                        ),

                        const  SizedBox(height: 20,),
                        defaultButton(
                            onPress: ()
                            {
                              LogInCubit.get(context).verifyOTB(emailController.text , codeController.text);

                            },
                            text: 'Verify'
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } ,
    );
  }
}
