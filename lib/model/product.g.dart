// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    productImagePath: json['productImagePath'] as String,
    productName: json['productName'] as String,
    productPrice: json['productPrice'] as String,
    productProducer: json['productProducer'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productImagePath': instance.productImagePath,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'productProducer': instance.productProducer,
    };
