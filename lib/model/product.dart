import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String productImagePath;
  final String productName;
  final String productPrice;
  final String productProducer;

  Product(
      {this.productImagePath,
      this.productName,
      this.productPrice,
      this.productProducer});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return 'Product{productImagePath: $productImagePath,'
        ' productName: $productName, productPrice: $productPrice, '
        'productProducer: $productProducer}';
  }
}
