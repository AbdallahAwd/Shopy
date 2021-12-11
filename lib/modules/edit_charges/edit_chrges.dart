import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/models/charges_model.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge.dart';
import 'package:shop/shared/Cubit/charge_cubit/charge_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class EditChargesScreen extends StatelessWidget {

  ChargeModel model;
  int id;

  EditChargesScreen(this.model, this.id);

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    priceController.text = model.price.toString();
    descriptionController.text = model.description;
    nameController.text = model.name;
    dateController.text = model.dateTime;
    return BlocConsumer<ChargeCubit, ChargeStates>(
      listener: (context, state)
      {
        if(state is UpdateDateSuccess)
        {
          Navigator.pop(context);
          id = null;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${getLang(context, 'edit')}',
              style: Theme
                  .of(context)
                  .textTheme
                  .caption
                  .copyWith(fontSize: 22 , fontFamily: 'Cairo'),
            ),
            elevation: 1.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  color: HomeCubit.get(context).isDark ? HexColor('#3B3D4E') : Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: descriptionController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: priceController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                          controller: dateController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.date_range),
                          ),
                        ),
                        const SizedBox(height: 15,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultButton(onPress: () {
                      ChargeCubit.get(context).updateData(
                          updatedItemId: ChargeCubit.get(context).chargesId[id],
                          name: nameController.text,
                          description: descriptionController.text,
                          price: double.parse(priceController.text),
                          date: dateController.text,
                      );

                    }, text: '${getLang(context, 'update')}', width: 120.0),
                    const SizedBox(width: 10,),
                    SizedBox(
                        width: 120,
                        child: OutlinedButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text('${getLang(context, 'Cancel')} ',style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo' , color: Colors.amber),))),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
