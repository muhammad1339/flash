import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'component/rounded_button.dart';
import 'component/rounded_field.dart';
import 'model/product.dart';

class AddProductPage extends StatefulWidget {
  static String pageName = 'add_product';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File _image;
  String _productName;
  String _productPrice;
  String _productProducer;
  final Firestore _fireStore = Firestore.instance;

  void getAllProducts() async {
    Stream<QuerySnapshot> snapshots =
        _fireStore.collection('products').snapshots();
    await for (var snapshot in snapshots) {
      for (var product in snapshot.documents) {
        print(Product.fromJson(product.data).toString());
      }
    }
  }

  void addProduct(Product product) async {
    DocumentReference documentReference = await _fireStore
        .collection('products')
        .add({'product': product.toJson()});
    print(documentReference.path);
  }

  void uploadImage(File imagePath) async {
    final StorageReference storageReference =
        FirebaseStorage().ref().child('images/${DateTime.now()}');
    print(await storageReference.getPath());
    final StorageUploadTask uploadTask = storageReference.putFile(imagePath);

    final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      print('EVENT ${event.type}');
    });

// Cancel your subscription when done.
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.path);
    streamSubscription.cancel();
    setState(() {
      addProduct(Product(
        productImagePath: storageTaskSnapshot.ref.path,
        productName: _productName,
        productPrice: _productPrice,
        productProducer: _productProducer,
      ));
    });
  }

  Future getImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print(image);
      setState(() {
        _image = image;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _image == null
                      ? Text('No image selected,Click To Select.')
                      : Image.file(
                          _image,
                          width: 120.0,
                          height: 120.0,
                        ),
                ),
              ),
              RoundedField(
                isPassword: false,
                label: 'Product Name',
                onChanged: (text) {
                  _productName = text;
                  print(_productName);
                },
              ),
              RoundedField(
                isPassword: false,
                label: 'Product Price',
                onChanged: (text) {
                  _productPrice = text;
                },
              ),
              RoundedField(
                isPassword: false,
                label: 'Product Producer',
                onChanged: (text) {
                  _productProducer = text;
                },
              ),
              RoundedButton(
                text: 'UPLOAD PRODUCT',
                onPress: () {
//                  uploadImage(_image);
                  getAllProducts();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
