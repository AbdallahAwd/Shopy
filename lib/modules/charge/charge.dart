import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/models/charges_model.dart';
import 'package:shop/modules/edit_charges/edit_chrges.dart';
import 'package:shop/modules/search_charge/search_charge.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class ChargeScreen extends StatelessWidget {
  var priceController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();
  var nameController = TextEditingController();
  var searchController = TextEditingController();
  var searchPricesController = TextEditingController();
  var minusPricesController = TextEditingController();
  var deleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChargeCubit.get(context).getChargeDate();
        return BlocConsumer<ChargeCubit, ChargeStates>(
          listener: (context, state) {
            if (state is AddDateSuccess)
              {
                Navigator.pop(context);
                priceController.clear();
                dateController.clear();
                descriptionController.clear();
                nameController.clear();
              }
          },
          builder: (context, state) {

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '${getLang(context, '2')}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .caption
                      .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
                ) ,
                elevation: 1.0,
                actions: [
                  IconButton(
                    onPressed: ()
                    {
                      navigateTo(context, SearchCharges());
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ConditionalBuilder(
                  condition: ChargeCubit.get(context).charges.isNotEmpty,
                  builder: (context) => GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: ChargeCubit.get(context).charges.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => gridBuilder(context , ChargeCubit.get(context).charges[index] , index),
                  ),
                  fallback: (context) => Center(child: Text('${getLang(context, 'noItems')}' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22 , fontFamily: 'Cairo'),)),
                ),
              ),
              floatingActionButton: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 1,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      showAlertDialog(context);
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 10,),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    heroTag: 3,
                    onPressed: () {
                      HapticFeedback.lightImpact();

                      showAlertDialogToDelete(context);
                    },
                    child: const Icon(Icons.delete , color: Colors.white,),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }

  showAlertDialog(context) {
    // set up the button
    Widget okButton = TextButton(
      child:  Text("${getLang(context, 'Add')}"),
      onPressed: () {
        ChargeCubit.get(context).addChargeItem(
            name: nameController.text,
            description: descriptionController.text,
            price: double.parse(priceController.text),
            dateTime: dateController.text,
        );
      },
    );
    Widget cancelButton = TextButton(
      child:  Text("${getLang(context, 'Cancel')}"),
      onPressed: ()
      {
        priceController.clear();
        dateController.clear();
        descriptionController.clear();
        nameController.clear();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
      title:  Center(child: Text("${getLang(context, 'addCharge')}" , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultTextFormFeild(
              context: context,
                controller: nameController,
                pre: Icons.person,
                HintText: '${getLang(context, 'name')}',
                KeyType: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'This Field required';
                  }
                  return null;
                }),
            const SizedBox(
              height: 15,
            ),
            defaultTextFormFeild(
                context: context,

                controller: descriptionController,
                pre: Icons.description_outlined,
                HintText: '${getLang(context, 'description')}',
                KeyType: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'This Field required';
                  }
                  return null;
                }),
            const SizedBox(
              height: 15,
            ),
            defaultTextFormFeild(
              context: context,

              controller: priceController,
              pre: Icons.attach_money,
              HintText: '${getLang(context, '1')}',
              KeyType: TextInputType.number,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'This Field required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            defaultTextFormFeild(
                context: context,

                controller: dateController,
                pre: Icons.calendar_today,
                HintText: '${getLang(context, 'date')}',
                KeyType: TextInputType.datetime,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'This Field required';
                  }
                  return null;
                },
                onTab: () {
                  dateController.text = '$Now at $formattedTime'.toString();
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogToDelete(context) {
    // set up the button
    Widget okButton = TextButton(
      child:  Text("${getLang(context, 'delete')}"),
      onPressed: () {
        ChargeCubit.get(context).deleteByField(deleteController.text);
        deleteController.clear();
        Navigator.pop(context);
      },
    );
    Widget cancelButton = TextButton(
      child:  Text("${getLang(context, 'Cancel')}"),
      onPressed: ()
      {
        priceController.clear();
        dateController.clear();
        descriptionController.clear();
        nameController.clear();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
      title:  Center(child: Text("${getLang(context, 'DeleteCharge')}" , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultTextFormFeild(
              context: context,
                controller: deleteController,
                pre: Icons.person,
                HintText: '${getLang(context, 'name')}',
                KeyType: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return 'This Field required';
                  }
                  return null;
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Widget gridBuilder(context , ChargeModel model , index) =>
      GestureDetector(
        onLongPress: ()
        {
          HapticFeedback.lightImpact();
          ChargeCubit.get(context).deleteItem(
            deletedItem: ChargeCubit.get(context).chargesId[index]
          );
          index = null;
        },
        onDoubleTap: ()
        {
          navigateTo(context, EditChargesScreen(model , index));
        },
        child: SizedBox(
          height: 180,
          width: 180,
          child: Card(
            color: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.dateTime,
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Text(
                    model.name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
                  ),
                  Text(
                     model.description,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2.copyWith(fontFamily: 'Cairo'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${model.price}  ${getLang(context ,'pound')}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 20 , fontFamily: 'Cairo'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
