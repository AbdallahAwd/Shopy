import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/charges_model.dart';

import 'charge_states.dart';

class ChargeCubit extends Cubit<ChargeStates>
{
  ChargeCubit() : super(InitialState());

  static ChargeCubit get(context) => BlocProvider.of(context);


  ChargeModel chargeModel;
  void addChargeItem({
  @required String name,
  @required String description,
  @required double price,
  @required String dateTime,
  })
  {
    chargeModel = ChargeModel(
      dateTime: dateTime,
      price: price,
      name: name,
      description: description,
    );
    FirebaseFirestore.instance.collection('charge').add(chargeModel.toMap()).then((value) {
      emit(AddDateSuccess());
    }).catchError((onError){
      emit(AddDateError());
    });
  }
  //اي لسته هتملاها من الفيربيز لازم تفضيها قبل متخش ف اللوب
  //Not to doublicate the List Items
  List<ChargeModel> charges =[];
  List<String> chargesId =[];

  void getChargeDate()
  {
    FirebaseFirestore.instance.collection('charge').orderBy("name").snapshots().listen((event)
    {
      charges = [];
      chargesId =[];
      for(var element in event.docs)
        {
          chargesId.add(element.id);
          charges.add(ChargeModel.fromJson(element.data()));
        }
      emit(GetDateSuccess());
    });
  }

  void deleteItem({
  @required String deletedItem,
})async
  {
   await FirebaseFirestore.instance.collection('charge').doc(deletedItem).delete().then((value) {
      emit(DeleteDateSuccess());
    }).catchError((onError){
     emit(DeleteDateError());
   });
  }
  void updateData({
    @required String updatedItemId,
    @required String name,
    @required String description,
    @required double price,
    @required String date,
}) async
  {
    chargeModel = ChargeModel(
      description: description,
      name: name,
      price: price,
      dateTime: date,
    );

    await FirebaseFirestore.instance.collection('charge').doc(updatedItemId).update(chargeModel.toMap()).then((value) {
      emit(UpdateDateSuccess());
    }).catchError((onError){
      emit(UpdateDateError());
    });
  }

  List<ChargeModel> searchItems = [];
  void searchData({
  @required String data,
}) async
  {
     await FirebaseFirestore.instance.collection('charge').where("name" , isGreaterThanOrEqualTo: data).orderBy("name").get().then((value) {
       searchItems = [];
       for(var element in value.docs)
         {
           searchItems.add(ChargeModel.fromJson(element.data()));
         }
       emit(SearchDateSuccess());
     }).catchError((onError){
       emit(SearchDateError());
     });

  }

  void deleteByField(data)
  {
    //Dart
    FirebaseFirestore.instance.collection('charge').where("name" , isEqualTo: data).get().then((value) {
      for (DocumentSnapshot ds in value.docs)
      {
        ds.reference.delete();
      }
      emit(DeleteDateSuccess());
    }).catchError((onError){
      emit(DeleteDateError());
    });
  }

  List prices = [];
  double sum = 0.0;
  void getAllPrices(data)
  {
    FirebaseFirestore.instance.collection('charge').where("name" , isEqualTo: data).get().then((value) {
      prices = [];
      for(var element in value.docs)
        {
          prices.add(element.get("price"));
        }
      emit(GetPricesDateSuccess());
      sum = 0.0;
     prices.forEach((element) {
       sum+= element;
     });
      print(sum);
    }).catchError((onError)
    {
      print('Errorrrrrrrrrr $onError');
      emit(GetPricesDateError());
    });
  }
  bool isShown = false;
  void toggleText()
  {
    isShown = !isShown;
    emit(GetPricesDateSuccess2());
  }

}