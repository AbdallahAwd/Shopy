import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/models/prices_model.dart';
import 'package:shop/shared/Cubit/Home/home_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shop/shared/networking/lacal/cache_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void saveDark({bool value})
  {
    if(value != null)
    isDark = value;
    else
      isDark = !isDark;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
    emit(DarkState());
    });
  }
  String dropdownValue;
  void saveLang(String value)
  {
    dropdownValue = value;
    CacheHelper.saveData(key: 'lang', value: dropdownValue).then((value) {
      emit(LangState());
    });
  }

  Locale language()
  {
    if(dropdownValue == null)
    {

      return null;
    }
    else if(dropdownValue == 'العربيه')
    {

      return const Locale('ar', '');
    }
    else
    {

      return const Locale('en', '');
    }

  }






  final user = FirebaseAuth.instance.currentUser;

  File productImage;

  var picker = ImagePicker();

  Future<void> getProductImage() async {
    emit(GetImageProductLoadingState());
    final productImagePicker =
        await picker.pickImage(source: ImageSource.gallery);
    if (productImagePicker != null) {
      productImage = File(productImagePicker.path);
      emit(GetImageProductSuccessState());
    } else {
      emit(GetImageProductErrorState());
    }
  }

  void uploadDate({
    @required String dateTime,
    @required String product,
    @required String price,
  }) {
    emit(UploadPriceImageLoading());
    if (productImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('price/${Uri.file(productImage.path).pathSegments.last}')
          .putFile(productImage)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          addDate(
              image: value, dateTime: dateTime, product: product, price: price);
        }).catchError((onError) {
          emit(UploadPriceImageError());
        });
      }).catchError((onError) {
        emit(UploadPriceImageError());
      });
    } else {
      addDate(
        image: null,
        dateTime: dateTime,
        product: product,
        price: price,
      );
    }
  }

  PriceModel priceModel;

  void addDate({
    @required String image,
    @required String dateTime,
    @required String product,
    @required String price,
  }) {
    priceModel = PriceModel(
      image: image ??
          'https://ph-test-11.slatic.net/p/1bdef0b5837fe56734fd7d7d93a83ee5.png',
      dateTime: dateTime,
      price: price,
      product: product,
    );
    FirebaseFirestore.instance
        .collection('price')
        .add(priceModel.toMap())
        .then((value) {
      emit(PutPriceDataSuccess());
    }).catchError((onError) {
      emit(PutPriceDataError());
    });
  }
  //اي لسته هتملاها من الفيربيز لازم تفضيها قبل متخش ف اللوب
  List<PriceModel> prices = [];
  List<String> itemId = [];

  void getPriceData() {
    FirebaseFirestore.instance.collection('price').snapshots().listen((event) {
      prices = [];
      itemId = [];

      for (var element in event.docs) {
        itemId.add(element.id);
        prices.add(PriceModel.fromJson(element.data()));
      }
      emit(GetPriceDataSuccess());
    });
  }

  CollectionReference items = FirebaseFirestore.instance.collection('price');

  Future<void> deleteItems(String itemId) async =>
      await items
        .doc(itemId)
        .delete()
        .then((value) => emit(DeletePriceDataSuccess()))
        .catchError((error) => emit(DeletePriceDataSuccess()));

  File productImageUpdate;

  var updatePicker = ImagePicker();

  Future<void> updateProductImage() async {
    emit(GetImageProductLoadingState());
    final productImageUpdatePicker =
        await updatePicker.pickImage(source: ImageSource.gallery);
    if (productImageUpdatePicker != null) {
      productImageUpdate = File(productImageUpdatePicker.path);
      emit(UpdateImageProductSuccessState());
    } else {
      emit(UpdateImageProductErrorState());
    }
  }

  void updateItem({
    @required String itemId,
    String image,
    @required String dateTime,
    @required String price,
    @required String product,
  }) {
    priceModel = PriceModel(
      image: image ??
          'https://ph-test-11.slatic.net/p/1bdef0b5837fe56734fd7d7d93a83ee5.png',
      dateTime: dateTime,
      price: price,
      product: product,
    );
    FirebaseFirestore.instance
        .collection('price')
        .doc(itemId)
        .update(priceModel.toMap())
        .then((value) {
      emit(UpdatePriceDataSuccess());
    }).catchError((onError) {
      emit(UpdatePriceDataError());
    });
  }
  uploadEditImage({
    @required String itemId,
    @required String dateTime,
    @required String price,
    @required String product,
  })
  {
    emit(UploadEditImageLoading());
    if(productImageUpdate != null) {
      firebase_storage.FirebaseStorage.instance
        .ref()
        .child('price/${Uri.file(productImageUpdate.path).pathSegments.last}')
        .putFile(productImageUpdate).then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateItem(
          image: value,
          product: product,
          price: price,
          dateTime: dateTime,
          itemId: itemId,
        );
        emit(UploadEditImageSuccess());
      }).catchError((onError){
        emit(UploadEditImageError());
      });
    }).catchError((onError){
      emit(UploadEditImageError());
    });
    }
    else {
      updateItem(
        product: product,
        price: price,
        dateTime: dateTime,
        itemId: itemId,
      );
    }
  }
  List<PriceModel> searchPrices = [];

  getSearchDate({
    @required String product,
  }) async {
    FirebaseFirestore.instance
        .collection('price')
        .where("product", isGreaterThanOrEqualTo: product)
        .get()
        .then((value) {
          searchPrices = [];
          for (var element in value.docs) {
            searchPrices.add(PriceModel.fromJson(element.data()));
            emit(SearchPriceDataSuccess());
          }
        })
        .catchError((onError) {
          emit(SearchPriceDataError());
        });
  }
}
