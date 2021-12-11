import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/layout.dart';
import 'package:shop/modules/log_in/log_in.dart';
import 'package:shop/modules/log_in/register.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/component.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit , LoginStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          backgroundColor: Colors.blue[800],

          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator());
                }
              else if(snapshot.hasError)
                {
                  return const Center(child: Text('There\'s an Error'));
                }
              else if (snapshot.hasData)
                {
                  return MyHomePage();
                }
              else
                {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[300]),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[300]),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MaterialButton(
                            onPressed: () {
                              navigateTo(context, LogInScreen(key: key,));
                            },
                            color: Colors.white,
                            child: Text(
                              'LOGIN',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.blue[800]),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () {
                              LogInCubit.get(context).googleLogin();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage('assets/G.png'),
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Google',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
          ),
        );
      },
    );
  }
}
