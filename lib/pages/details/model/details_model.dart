class DetailsModel {
  final String id;
  final String productCode;
  final String productImage;
  final String productColor;
  final String productSize;
  final int quantity;

  DetailsModel({
    required this.id,
    required this.productCode,
    required this.productImage,
    required this.productColor,
    required this.productSize,
    required this.quantity,
  });

  DetailsModel copyWith({
    String? id,
    String? productCode,
    String? productImage,
    String? productColor,
    String? productSize,
    int? quantity,
  }) {
    return DetailsModel(
      id: id ?? this.id,
      productCode: productCode ?? this.productCode,
      productImage: productImage ?? this.productImage,
      productColor: productColor ?? this.productColor,
      productSize: productSize ?? this.productSize,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productCode': productCode,
      'productImage': productImage,
      'productColor': productColor,
      'productSize': productSize,
      'quantity': quantity,
    };
  }

  factory DetailsModel.fromMap(Map<String, dynamic> map) {
    return DetailsModel(
      id: map['id'] ?? '',
      productCode: map['productCode'] ?? '',
      productImage: map['productImage'] ?? '',
      productColor: map['productColor'] ?? '',
      productSize: map['productSize'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
}
