import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/Home/home_states.dart';
import 'package:shop/shared/compnents/app_local.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${getLang(context, 'settings')}',
              style: Theme
                  .of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: 22, fontFamily: 'Cairo',),
            ),
            elevation: 1.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 5.0,
              color: HomeCubit
                 .get(context)
                   .isDark ? HexColor('#222226') : Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(

                    leading:  Icon(Icons.dark_mode , color: HomeCubit.get(context).isDark ? Colors.white : Colors.black,),
                    title: Text('${getLang(context, 'dark')}', style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontFamily: 'Cairo'),),
                    trailing: Switch(
                      activeColor: Colors.teal,
                      value: HomeCubit
                          .get(context)
                          .isDark,
                      onChanged: (value)
                      {
                        HomeCubit.get(context).saveDark();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [

                        Icon(Icons.language_outlined , color: HomeCubit.get(context).isDark ? Colors.white : Colors.black,),
                        const SizedBox(width: 40,),

                        Text('${getLang(context, 'Lang')}' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),),
                        const Spacer(),

                        drop(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drop (context) => DropdownButton<String>(
    dropdownColor: HomeCubit.get(context).isDark ? Colors.black : Colors.white,
    style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
    value: HomeCubit.get(context).dropdownValue,
    onChanged: (String newValue)
    {
      HomeCubit.get(context).saveLang(newValue);
    },
    hint: Text('${getLang(context, 'Lang')}' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo' , fontSize: 15),),
    items: <String>['العربيه', 'English']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}
