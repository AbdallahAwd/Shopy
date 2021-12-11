import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/models/prices_model.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/Home/home_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class EditPriceScreen extends StatelessWidget {
  PriceModel editModel;
  dynamic index;
  var dateController = TextEditingController();
  var priceController = TextEditingController();
  var productController = TextEditingController();

  EditPriceScreen(this.editModel, this.index);

  @override
  Widget build(BuildContext context) {
    productController.text = editModel.product;
    priceController.text = editModel.price;
    dateController.text = editModel.dateTime;
    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state)
      {
        if(state is UploadEditImageLoading)
          {
            snackBar(context, text: '${getLang(context, 'snackBar2')}' , color: Colors.yellow);
          }
        if(state is GetPriceDataSuccess)
          {
            Navigator.pop(context);
          }

      },
      builder: (context , state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${getLang(context , 'editProduct')}',
              style:
              Theme
                  .of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: 22),
            ),
            elevation: 1.0,
            actions: [
              TextButton(onPressed: () {
                HomeCubit.get(context).uploadEditImage(
                    itemId: HomeCubit.get(context).itemId[index],
                    dateTime: dateController.text,
                    price: priceController.text,
                    product: productController.text
                );
              }, child:  Text('${getLang(context , 'update')}'))
            ],
            leading: null,
          ),
          body: SizedBox(
            width: double.infinity,
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: HomeCubit.get(context).productImageUpdate == null ? NetworkImage(editModel.image) : FileImage(HomeCubit.get(context).productImageUpdate),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    color: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          defaultTextFormFeild(
                            context: context,
                              controller: productController,
                              pre: Icons.shopping_cart,
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

                              controller: priceController,
                              pre: Icons.attach_money,
                              HintText: '${getLang(context , '1')}',
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
                              HintText: '${getLang(context , 'date')}',
                              KeyType: TextInputType.datetime,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'This Field required';
                                }
                                return null;
                              },
                              onTab: () {
                                dateController.text =
                                    '$Now at $formattedTime'.toString();
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              HomeCubit.get(context).updateProductImage();
                            },
                            child: Row(
                              children:  [
                                const Icon(Icons.image),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text('  ${getLang(context , 'addImage')}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
