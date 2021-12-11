import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop/models/prices_model.dart';
import 'package:shop/modules/edit_price/edit_price.dart';
import 'package:shop/shared/Cubit/Home/home_cubit.dart';
import 'package:shop/shared/Cubit/Home/home_states.dart';
import 'package:shop/shared/compnents/app_local.dart';
import 'package:shop/shared/compnents/component.dart';

class SearchScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<HomeCubit , HomeStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              controller: searchController,
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
              decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: 'Cairo'),
                hintText: '${getLang(context, 'search')}',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(icon:const Icon(Icons.check),onPressed: ()
                {

                  HomeCubit.get(context).getSearchDate(product: searchController.text);
                },),
              ),
              onFieldSubmitted: (value)
              {

                HomeCubit.get(context).getSearchDate(product: searchController.text);
              },
            ),
          ),
          body: ConditionalBuilder(
            condition: HomeCubit
                .get(context)
                .searchPrices.isNotEmpty || HomeCubit
                .get(context)
                .searchPrices == null,
            builder: (context) =>
                ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      listViewUnit(context, HomeCubit.get(context).searchPrices[index]  , index),
                  separatorBuilder: (context, index) =>
                  const Divider(
                    height: 1,
                  ),
                  itemCount: HomeCubit
                      .get(context)
                      .searchPrices
                      .length,
                ),
            fallback: (context) =>
                Center(child: Text('${getLang(context , 'noItems')}' , style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22 , fontFamily: 'Cairo'),)),
          ),
        );
      },
    );
  }
}
Widget listViewUnit(context, PriceModel priceModel  , index) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: SizedBox(
        height: 80,
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            IconSlideAction(
              caption: '${getLang(context , 'edit')}',
              color: Colors.indigo,
              icon: Icons.edit_attributes_rounded,
              onTap: () {
                navigateTo(context, EditPriceScreen(priceModel , index));
              },
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
                caption: '${getLang(context , 'delete')}',
                color: Colors.red,
                icon: Icons.delete,
                onTap: ()
                {
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
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${priceModel.price} L.E',
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