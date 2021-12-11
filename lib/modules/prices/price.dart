import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/models/prices_model.dart';
import 'package:shop/modules/edit_price/edit_price.dart';
import 'package:shop/modules/search_screen/search_screen.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/Home/home_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';
class PriceScreen extends StatelessWidget {
  var productController = TextEditingController();
  var priceController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getPriceData();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state)
        {
          if (state is PutPriceDataSuccess)
          {
            productController.clear();
            priceController.clear();
            dateController.clear();
            Navigator.pop(context);
          }
          if (state is UploadPriceImageLoading)
            {
              snackBar(context, text: '${getLang(context, "snackBar1")}' , color: Colors.yellow);
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                '${getLang(context, "1")}',
                style:
                Theme
                    .of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
              ),
              elevation: 1.0,
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context , SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: HomeCubit
                  .get(context)
                  .prices
                  .length > 0,
              builder: (context) =>
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        listViewUnit(context, HomeCubit.get(context).prices[index] , index),
                    separatorBuilder: (context, index) =>
                    const Divider(
                      height: 1,
                    ),
                    itemCount: HomeCubit
                        .get(context)
                        .prices
                        .length,
                  ),
              fallback: (context) =>
               Center(child: Text('${getLang(context, "noItems")}' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22 , fontFamily: 'Cairo'),)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                showAlertDialog(context);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      );
    });
  }

  showAlertDialog(context) {
    // set up the button
    Widget okButton = TextButton(
      child:  Text("${getLang(context, "Add")}" , style: TextStyle(fontFamily: "Cairo"),),
      onPressed: () {
        HomeCubit.get(context).uploadDate(
          price: priceController.text,
          dateTime: dateController.text,
          product: productController.text,
        );
      },
    );
    Widget cancelButton = TextButton(
      child:  Text("${getLang(context, "Cancel")}" , style: TextStyle(fontFamily: "Cairo"),),
      onPressed: () {
        dateController.text = null;
        productController.text = null;
        priceController.text = null;
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      backgroundColor: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
      title:  Center(child: Text("${getLang(context, 'addProduct')}" , style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultTextFormFeild(
              context: context,
              controller: productController,
              pre: Icons.shopping_cart,
              HintText: '${getLang(context, "Product")}',
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
              HintText: '${getLang(context, "1")}',
              KeyType: TextInputType.number,
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
              controller: dateController,
              pre: Icons.calendar_today,
              HintText: '${getLang(context, "date")}',
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
          OutlinedButton(
            onPressed: () {
              HomeCubit.get(context).getProductImage();
            },
            child: Row(
              children:  [
               const Icon(Icons.image),
                const  SizedBox(
                  height: 15,
                ),
                Text('${getLang(context, "addImage")}'),
              ],
            ),
          ),
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
}
Widget listViewUnit(context, PriceModel priceModel ,  index) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: SizedBox(
        height: 80,
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            IconSlideAction(
              caption: '${getLang(context, 'edit')} ',
              color: Colors.indigo,
              icon: Icons.edit_attributes_rounded,
              onTap: () {
                HapticFeedback.lightImpact();
                navigateTo(context, EditPriceScreen(priceModel , index));
              },
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
                caption: '${getLang(context, 'delete')}',
                color: Colors.red,
                icon: Icons.delete,
                onTap: ()
                {
                  HapticFeedback.lightImpact();
                  HomeCubit.get(context).deleteItems(HomeCubit.get(context).itemId[index]);
                }),
          ],
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(priceModel.image),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    priceModel.product,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 18 , fontFamily: 'Cairo'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${priceModel.price} ${getLang(context, 'pound')}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 15),
                  ),
                ],
              ),
              Expanded(
                  child: Text(priceModel.dateTime.toString(),
                      textAlign: TextAlign.end,
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption)),
            ],
          ),
        ),
      ),
    );
