import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/component.dart';

class VerifyEmail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit , LoginStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            backgroundColor: Colors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child:defaultButton(onPress: ()
            {
              LogInCubit.get(context).emailVerification();
            }, text: 'Send Email Verification' , ),),
          )
        );
      },
    );
  }
}
