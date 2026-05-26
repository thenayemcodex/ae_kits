class ProductModel {
  final String id;
  final String category;
  final String productCode;
  final String productName;
  final List<String> productImages;
  final List<String> productColors;
  final double unitValue;
  final double offerValue;
  final String productDescription;
  final List<String> sizes;
  final List<Map<String, dynamic>> reviews;
  final String stock;

  ProductModel({
    required this.id,
    required this.category,
    required this.productCode,
    required this.productName,
    required this.productImages,
    required this.productColors,
    required this.unitValue,
    required this.offerValue,
    required this.productDescription,
    required this.sizes,
    required this.reviews,
    required this.stock,
  });

  ProductModel copyWith({
    String? id,
    String? category,
    String? productCode,
    String? productName,
    List<String>? productImages,
    List<String>? productColors,
    double? unitValue,
    double? offerValue,
    String? productDescription,
    List<String>? sizes,
    List<Map<String, dynamic>>? reviews,
    String? stock,
  }) {
    return ProductModel(
      id: id ?? this.id,
      category: category ?? this.category,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      productImages: productImages ?? this.productImages,
      productColors: productColors ?? this.productColors,
      unitValue: unitValue ?? this.unitValue,
      offerValue: offerValue ?? this.offerValue,
      productDescription: productDescription ?? this.productDescription,
      sizes: sizes ?? this.sizes,
      reviews: reviews ?? this.reviews,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'productCode': productCode,
      'productName': productName,
      'productImages': productImages,
      'productColors': productColors,
      'unitValue': unitValue,
      'offerValue': offerValue,
      'productDescription': productDescription,
      'sizes': sizes,
      'reviews': reviews,
      'stock': stock,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      category: map['category'] ?? '',
      productCode: map['productCode'] ?? '',
      productName: map['productName'] ?? '',

      productImages: (map['productImages'] as List? ?? [])
          .whereType<String>()
          .toList(),

      productColors: (map['productColors'] as List? ?? [])
          .whereType<String>()
          .toList(),

      unitValue: (map['unitValue'] is num)
          ? (map['unitValue'] as num).toDouble()
          : double.tryParse(map['unitValue'].toString()) ?? 0.0,

      offerValue: (map['offerValue'] is num)
          ? (map['offerValue'] as num).toDouble()
          : double.tryParse(map['offerValue'].toString()) ?? 0.0,

      productDescription: map['productDescription'] ?? '',

      sizes: (map['sizes'] as List? ?? [])
          .whereType<String>()
          .toList(),

      reviews: (map['reviews'] as List? ?? [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),

      stock: map['stock']?.toString() ?? '',
    );
  }
}