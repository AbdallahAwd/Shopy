import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/req_model.dart';
import 'package:shop/shared/Cubit/req_cubit/req_states.dart';

class ReqCubit extends Cubit<ReqStates>
{
  ReqCubit() : super(initialState());

  static ReqCubit get(context) => BlocProvider.of(context);

  bool checkedValue = false;
  void changeCheckBox(newValue)
  {
    checkedValue = newValue;
    emit(CheckState());
  }
  ReqModel reqModel;

  void addEldawliaItem({
  @required String product,
  @required String quantity,

})
  {
    reqModel = ReqModel(
      product: product,
      quantity: quantity,
      checkedValues: false,
    );
    FirebaseFirestore.instance.collection('req').doc('eldawlia').collection('Eldawlia').add(reqModel.toMap()).then((value)
    {
      emit(AddDataSuccess());
    }).catchError((onError){
      emit(AddDataError());
    });
  }
  List <ReqModel> req = [];
  List <String> reqId = [];
  void listenData()
  {
    emit(ListenDataLoading());
    FirebaseFirestore.instance.collection('req').doc('eldawlia').collection('Eldawlia').snapshots().listen((event) {
      req = [];
      reqId = [];
      for(var element in event.docs)
        {
          reqId.add(element.id);
          req.add(ReqModel.fromJson(element.data()));
        }
      emit(ListenDataSuccess());
    });
  }

  void delete(String itemId) async
  {
    emit(DeleteDataLoading());
   await FirebaseFirestore.instance.collection('req').doc('eldawlia').collection('Eldawlia').doc(itemId).delete().then((value) {
     // for(int i = 0 ; i <= 1000 ; i++)
     //   {
     //     print(i);
     //   }
     emit(DeleteDataSuccess());
    }).catchError((onError){
     emit(DeleteDataError());
    });
  }

  void updateList(
    String itemId,
    newValue, String productText,String quantityText

 )
  {
    reqModel = ReqModel(
      checkedValues: newValue,
      product: productText,
      quantity: quantityText
    );
     FirebaseFirestore.instance.collection('req').doc('eldawlia').collection('Eldawlia').doc(itemId).update(reqModel.toMap()).then((value)
     {
       emit(UpdateDataSuccess());
     }).catchError((onError){
       emit(UpdateDataError());

     });
  }

  void addHamadaReq({
  @required product,
  @required quantity,

})
  {
    reqModel = ReqModel(
      quantity: quantity,
      product: product,
      checkedValues: false,
    );
    FirebaseFirestore.instance.collection('Hamada').doc('hamada').collection('Hamada').add(reqModel.toMap()).then((value) {
      emit(HamadaDataSuccess());
    }).catchError((onError){
      emit(HamadaDataError());
    });
  }

  List<ReqModel> hamada = [];
  List<String> hamadaId = [];

  void listenHamadaData()
  {
    FirebaseFirestore.instance.collection('Hamada').doc('hamada').collection('Hamada').snapshots().listen((event) {
      hamadaId = [];
      hamada = [];
      for(var element in event.docs)
        {
          hamadaId.add(element.id);
          hamada.add(ReqModel.fromJson(element.data()));
        }
      emit(ListenDataSuccess());
    });
  }

  void updataHamada({
  @required String hamadaId,
  @required String product,
  @required String quantity,
  @required bool newValue,
  }) async
  {
    reqModel = ReqModel(
      checkedValues: newValue,
      product: product,
      quantity: quantity,
    );
   await FirebaseFirestore.instance.collection('Hamada').doc('hamada').collection('Hamada').doc(hamadaId).update(reqModel.toMap()).then((value) {
      emit(UpdateDataSuccess());
    }).catchError((onError){
      emit(UpdateDataError());
    });
  }

  void deleteHamadaItem(hamadaId) async
  {
    emit(DeleteDataLoading());

    await FirebaseFirestore.instance.collection('Hamada').doc('hamada').collection('Hamada').doc(hamadaId).delete().then((value) {
      emit(DeleteDataSuccess());
    }).catchError((onError){
      emit(DeleteDataError());

    });
  }


  void addAdel({
  @required product,
  @required quantity,
})
  {
    reqModel = ReqModel(
      product: product,
      quantity: quantity,
      checkedValues: false,
    );
    FirebaseFirestore.instance.collection('Adel').doc('adel').collection('Adel').add(reqModel.toMap()).then((value) {
      emit(AddDataSuccess());
    }).catchError((onError){
      emit(AddDataError());
    });
  }
  List<ReqModel> adel = [];
  List<String> adelId = [];

  void listenAdel()
  {
    FirebaseFirestore.instance.collection('Adel').doc('adel').collection('Adel').snapshots().listen((event) {
      adel = [];
      adelId = [];
      for(var element in event.docs)
        {
          adelId.add(element.id);
          adel.add(ReqModel.fromJson(element.data()));
        }
      emit(ListenDataSuccess());
    });
  }

  void deleteAdel(String adelId) async
  {
    emit(DeleteDataLoading());
    await FirebaseFirestore.instance.collection('Adel').doc('adel').collection('Adel').doc(adelId).delete().then((value) {
      emit(DeleteDataSuccess());
    }).catchError((onError){
      emit(DeleteDataError());
    });
  }

  void updateAdel({
  @required String product,
  @required String quantity,
  @required String adelId,
  @required bool newValue,
}) async
  {
    reqModel = ReqModel(
      checkedValues: newValue,
      quantity: quantity,
      product: product,
    );
   await FirebaseFirestore.instance.collection('Adel').doc('adel').collection('Adel').doc(adelId).update(reqModel.toMap()).then((value) {
      emit(UpdateDataSuccess());
    }).catchError((onError){
      emit(UpdateDataError());
    });
  }

  void addQady({
  @required product,
  @required quantity,
})
  {
    reqModel = ReqModel(
      product: product,
      quantity: quantity,
      checkedValues: false,
    );

    FirebaseFirestore.instance.collection('Qady').doc('qady').collection('Qady').add(reqModel.toMap()).then((value) {
      emit(AddDataSuccess());
    }).catchError((onError){
      emit(AddDataError());
    });
  }

  List<ReqModel> qady = [];
  List<String> qadyId = [];

  void ListenQady()
  {
    FirebaseFirestore.instance.collection('Qady').doc('qady').collection('Qady').snapshots().listen((event) {
      qady = [];
      qadyId = [];
      for(var element in event.docs)
        {
          qadyId.add(element.id);
          qady.add(ReqModel.fromJson(element.data()));
        }
      emit(ListenDataSuccess());
    });
  }

  void deleteQady(String qadyId)
  {
    emit(DeleteDataLoading());
    FirebaseFirestore.instance.collection('Qady').doc('qady').collection('Qady').doc(qadyId).delete().then((value) {
      emit(DeleteDataSuccess());
    }).catchError((onError){
      emit(DeleteDataError());
    });
  }

  void updateQady({
  @required product,
  @required quantity,
  @required newValue,
  @required qadyId,
})
  {
    reqModel = ReqModel(
      checkedValues: newValue,
      quantity: quantity,
      product: product,
    );
    FirebaseFirestore.instance.collection('Qady').doc('qady').collection('Qady').doc(qadyId).update(reqModel.toMap()).then((value) {
      emit(UpdateDataSuccess());
    }).catchError((onError){
      emit(UpdateDataError());
    });
  }



  void addSawah({
    @required product,
    @required quantity,
  })
  {
    reqModel = ReqModel(
      product: product,
      quantity: quantity,
      checkedValues: false,
    );

    FirebaseFirestore.instance.collection('Sawah').doc('sawah').collection('Sawah').add(reqModel.toMap()).then((value) {
      emit(AddDataSuccess());
    }).catchError((onError){
      emit(AddDataError());
    });
  }

  List<ReqModel> sawah = [];
  List<String> sawahId = [];

  void ListenSawah()
  {
    FirebaseFirestore.instance.collection('Sawah').doc('sawah').collection('Sawah').snapshots().listen((event) {
      sawah = [];
      sawahId = [];
      for(var element in event.docs)
      {
        sawahId.add(element.id);
        sawah.add(ReqModel.fromJson(element.data()));
      }
      emit(ListenDataSuccess());
    });
  }

  void deleteSawah(String sawahId)
  {
    emit(DeleteDataLoading());
    FirebaseFirestore.instance.collection('Sawah').doc('sawah').collection('Sawah').doc(sawahId).delete().then((value) {
      emit(DeleteDataSuccess());
    }).catchError((onError){
      emit(DeleteDataError());
    });
  }

  void updateSawah({
    @required product,
    @required quantity,
    @required newValue,
    @required sawahId,
  })
  {
    reqModel = ReqModel(
      checkedValues: newValue,
      quantity: quantity,
      product: product,
    );
    FirebaseFirestore.instance.collection('Sawah').doc('sawah').collection('Sawah').doc(sawahId).update(reqModel.toMap()).then((value) {
      emit(UpdateDataSuccess());
    }).catchError((onError){
      emit(UpdateDataError());
    });
  }
}