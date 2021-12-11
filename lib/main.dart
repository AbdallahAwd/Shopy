import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/log_in/welcome_screen.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/Home/home_states.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge.dart';
import 'package:shop/shared/Cubit/logIn/login_cubit.dart';
import 'package:shop/shared/Cubit/req_cubit/req_cubit.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/constants.dart';
import 'package:shop/shared/networking/lacal/cache_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'block_observer.dart';
import 'layout/layout.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  String uId = await CacheHelper.getData(key: 'uId');
  bool isDark = await CacheHelper.getData(key: 'isDark');
  String lang = await CacheHelper.getData(key: 'lang');
  runApp(  MyApp(uId , isDark , lang));
}

class MyApp extends StatelessWidget {
  String uId;
  String lang;
  bool isDark;
  MyApp(this.uId , this.isDark , this.lang, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) =>  LogInCubit(),) ,
        BlocProvider(
        create: (BuildContext context) =>  HomeCubit()..saveDark(value: isDark)..saveLang(lang),),
        BlocProvider(
        create: (BuildContext context) =>  ChargeCubit(),),
        BlocProvider(
        create: (BuildContext context) =>  ReqCubit(),),
      ],
      child: BlocConsumer<HomeCubit , HomeStates>(
        listener: (context , state){},
        builder: (context , state)
        {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shopy',
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
              Locale('ar', ''), // Arabic, no country code
            ],
            locale:HomeCubit.get(context).language(),
            localeResolutionCallback: (currentLang , supportLang)
            {
              if(currentLang != null)
              {
                for(Locale locale in supportLang)
                {
                  if(locale.languageCode == currentLang.languageCode)
                  {
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: HomeCubit.get(context).isDark ?  ThemeMode.dark : ThemeMode.light,
            home:  WelcomeScreen(),
          );
        },
      ),
    );
  }
  Widget startWidget()
  {
    if(uId != null)
      {
        return MyHomePage();
      }
    else
      {
        return WelcomeScreen();
      }
  }

}

