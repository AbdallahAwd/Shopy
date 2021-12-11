import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/models/charges_model.dart';
import 'package:shop/modules/edit_charges/edit_chrges.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class SearchCharges extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChargeCubit, ChargeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: searchController,
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
                hintText: '${getLang(context, 'search')}',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    ChargeCubit.get(context)
                        .searchData(data: searchController.text);
                  },
                ),
              ),
              onFieldSubmitted: (value) {
                ChargeCubit.get(context)
                    .searchData(data: searchController.text);
              },
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => searchBuilder(
                context, ChargeCubit.get(context).searchItems[index] , index),
            itemCount: ChargeCubit.get(context).searchItems.length,
          ),
          persistentFooterButtons: [
            defaultButton(onPress: ()
            {
              ChargeCubit.get(context).getAllPrices(searchController.text);
              ChargeCubit.get(context).toggleText();
            }, text: ChargeCubit.get(context).isShown ? '${ChargeCubit.get(context).sum}'.toString() :'اضغط لمعرفه الباقي')
          ],
        );
      },
    );
  }
}

Widget searchBuilder(context, ChargeModel model , index) => GestureDetector(
  onLongPress: ()
  {
    HapticFeedback.vibrate();
    ChargeCubit.get(context).deleteItem(deletedItem: ChargeCubit.get(context).chargesId[index]);
  },
  onDoubleTap: ()
  {
    HapticFeedback.vibrate();
    navigateTo(context, EditChargesScreen(model , index));

  },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              child: Card(
                color: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.dateTime,
                      style: Theme.of(context).textTheme.caption,
                    ),

                    const SizedBox(
                      height: 0,
                    ),

                    Text(
                      model.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
                    ),

                    Text(
                      model.description,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(fontFamily: 'Cairo'),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      '${model.price}  ${getLang(context, 'pound')}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 20 , fontFamily: 'Cairo'),
                    ),

                      // Text(model.priceSum.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
