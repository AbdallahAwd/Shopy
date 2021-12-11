import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/charge/charge.dart';
import 'package:shop/modules/prices/price.dart';
import 'package:shop/modules/req_screen/req_screen.dart';
import 'package:shop/modules/search_screen/search_screen.dart';
import 'package:shop/modules/settings/settings.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/logIn/login_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<LogInCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final user = LogInCubit.get(context).user;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              '${getLang(context, "title")}',
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 22 , fontFamily: 'Cairo'),
            ),
            elevation: 5.0,
            titleSpacing: 20,
            actions: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () 
                    {
                      navigateTo(context, SearchScreen());
                    },
                    icon: const Icon(Icons.search),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        navigateTo(context, PriceScreen());
                      },
                      child: buildStack(
                          context: context,
                          text: '${getLang(context, "1")}',
                          imageName: 'money.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();

                        navigateTo(context, ChargeScreen());
                      },
                      child: buildStack(
                          context: context,
                          text: '${getLang(context, "2")}',
                          imageName: 'charge.png')),
                  const SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                    onTap: ()
                    {
                      HapticFeedback.lightImpact();
                      navigateTo(context, ReqScreen());
                    },
                    child: buildStack(
                        context: context,
                        text: '${getLang(context, "3")}',
                        imageName: 'requirements.png'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(user.displayName==null ? 'Name' : user.displayName),
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: Container(
              color: HomeCubit.get(context).isDark ? Colors.black : Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        height: 250,
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsetsDirectional.only(top: 60, start: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(user.photoURL == null ? '' : user.photoURL),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              user.displayName == null ? 'Name' :  user.displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 17, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.email == null ? 'abdallahawad4@gmail.com' : user.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTileBuilder(
                    text: '${getLang(context, "1")}',
                    context: context,
                    onTab: () {
                      Navigator.pop(context);
                      HapticFeedback.selectionClick();
                      navigateTo(context, PriceScreen());
                    },
                    IconWidget: const CircleAvatar(
                      backgroundImage: AssetImage('assets/money.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTileBuilder(
                    text: '${getLang(context, "2")}',
                    context: context,
                    onTab: ()
                    {
                      Navigator.pop(context);
                      HapticFeedback.selectionClick();
                      navigateTo(context, ChargeScreen());
                    },
                    IconWidget: const CircleAvatar(
                      backgroundImage: AssetImage('assets/charge.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  ListTileBuilder(
                    text: '${getLang(context, "3")}',
                    context: context,
                    onTab: () {
                      Navigator.pop(context);
                      HapticFeedback.selectionClick();
                      navigateTo(context, ReqScreen());
                    },
                    IconWidget: const CircleAvatar(
                      backgroundImage: AssetImage('assets/requirements.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTileBuilder(
                    text: '${getLang(context, "settings")}',
                    context: context,
                    onTab: ()
                    {
                      Navigator.pop(context);
                      HapticFeedback.selectionClick();
                      navigateTo(context, SettingsScreen());
                      },
                    IconWidget:  Icon(Icons.settings , color: HomeCubit.get(context).isDark ? Colors.white : Colors.black,),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListTileBuilder(
                    text: '${getLang(context, "logout")}',
                    context: context,
                    onTab: ()
                    {
                      LogInCubit.get(context).logOut();
                    },
                    IconWidget:  Icon(Icons.logout , color: HomeCubit.get(context).isDark ? Colors.white : Colors.black,),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
