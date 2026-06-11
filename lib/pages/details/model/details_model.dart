class DetailsModel {
  final String productCode;
  final String productImage;
  final String productColor;
  final String productSize;
  final double unitPrice;
  final double shipping;
  final int quantity;

  DetailsModel({
    required this.productCode,
    required this.productImage,
    required this.productColor,
    required this.productSize,
    required this.unitPrice,
    required this.shipping,
    required this.quantity,
  });

  DetailsModel copyWith({
    String? productCode,
    String? productImage,
    String? productColor,
    String? productSize,
    double? unitPrice,
    double? shipping,
    int? quantity,
  }) {
    return DetailsModel(
      productCode: productCode ?? this.productCode,
      productImage: productImage ?? this.productImage,
      productColor: productColor ?? this.productColor,
      productSize: productSize ?? this.productSize,
      unitPrice: unitPrice ?? this.unitPrice,
      shipping: shipping ?? this.shipping,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productCode': productCode,
      'productImage': productImage,
      'productColor': productColor,
      'productSize': productSize,
      'unitPrice': unitPrice,
      'shipping': shipping,
      'quantity': quantity,
    };
  }

  factory DetailsModel.fromMap(Map<String, dynamic> map) {
    return DetailsModel(
      productCode: map['productCode'] ?? '',
      productImage: map['productImage'] ?? '',
      productColor: map['productColor'] ?? '',
      productSize: map['productSize'] ?? '',
      unitPrice: (map['unitPrice'] ?? 0).toDouble(),
      shipping: (map['shipping'] ?? 0).toDouble(),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
}
