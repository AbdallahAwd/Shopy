import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/models/req_model.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/req_cubit/req_cubit.dart';
import 'package:shop/shared/Cubit/req_cubit/req_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class AdelScreen extends StatelessWidget
{

  var productController = TextEditingController();
  var quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          ReqCubit.get(context).listenAdel();
          return BlocConsumer<ReqCubit, ReqStates>(
            listener: (context, state)
            {
              if(state is DeleteDataLoading)
              {
                snackBar(context, text: '${getLang(context , 'snackBar3')}' , color: Colors.red);
              }

            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    '${getLang(context , 'req')}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
                  ),
                  elevation: 1.0,
                ),
                body: ListView.separated(
                    itemBuilder: (context , index) => eldawliaCheckBox(context , ReqCubit.get(context).adel[index] , index),
                    separatorBuilder: (context , index) =>const SizedBox(height: 10,child: Divider(height: 1,),),
                    itemCount:  ReqCubit.get(context).adel.length
                ),
                floatingActionButton:
                FloatingActionButton(
                  heroTag: 1,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showAlertDialog(context);
                  },
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
      child:  Text("${getLang(context , 'Add')}"),
      onPressed: () {
        ReqCubit.get(context).addAdel(
          product: productController.text,
          quantity: quantityController.text,
        );
        productController.clear();
        quantityController.clear();
        Navigator.pop(context);

      },
    );
    Widget cancelButton = TextButton(
      child:  Text("${getLang(context , 'Cancel')}"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
      title:  Center(child: Text("${getLang(context, 'reqProduct')}" , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),)),      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultTextFormFeild(
              context: context,

              controller: productController,
              pre: Icons.shopping_cart_rounded,
              HintText: '${getLang(context , 'Product')}',
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

              controller: quantityController,
              pre: Icons.confirmation_number_outlined,
              HintText: '${getLang(context , 'Q')}',
              KeyType: TextInputType.text,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'This Field required';
                }
                return null;
              }),

        ],
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
  Widget eldawliaCheckBox(context , ReqModel model ,index) =>
      GestureDetector(
        onLongPress: ()
        {
          HapticFeedback.lightImpact();
          ReqCubit.get(context).deleteAdel(ReqCubit.get(context).adelId[index]);
        },
        child: CheckboxListTile(
          title: Text('${model.product} ${getLang(context , 'Q is')} ${model.quantity}', style: Theme
              .of(context)
              .textTheme
              .bodyText1
              .copyWith(fontSize: 18,decoration:ReqCubit
              .get(context)
              .adel[index].checkedValues ? TextDecoration.lineThrough : null , fontFamily: 'Cairo' ),),
          value: ReqCubit
              .get(context)
              .adel[index].checkedValues,
          activeColor:HomeCubit.get(context).isDark ? Colors.white : HexColor('#24252b'),
          checkColor:HomeCubit.get(context).isDark ? HexColor('#24252b') : Colors.white ,
          tileColor:HomeCubit.get(context).isDark ? HexColor('#24252b') : Colors.white ,          onChanged: (newValue)
          {
            ReqCubit.get(context).updateAdel(quantity: model.quantity , product: model.product , newValue: newValue , adelId: ReqCubit.get(context).adelId[index]);
          },
          controlAffinity: ListTileControlAffinity
              .leading, //  <-- leading Checkbox
        ),
      );
}




