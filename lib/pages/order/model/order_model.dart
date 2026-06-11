import 'package:ae_kits/pages/details/model/details_model.dart';

class OrderModel {
  final String id;
  final double totalPay;
  final String shippingAddress;
  final bool status;
  final String orderProgess;
  final String paymentMethod;
  final String accountNumber;
  final String transactionNumber;
  final String customerNotes;
  final List<DetailsModel> productDetails;

  const OrderModel({
    required this.id,
    required this.totalPay,
    required this.shippingAddress,
    required this.status,
    required this.orderProgess,
    required this.paymentMethod,
    required this.accountNumber,
    required this.transactionNumber,
    required this.customerNotes,
    required this.productDetails,
  });

  OrderModel copyWith({
    String? id,
    double? totalPay,
    String? shippingAddress,
    bool? status,
    String? orderProgess,
    String? paymentMethod,
    String? accountNumber,
    String? transactionNumber,
    String? customerNotes,
    List<DetailsModel>? productDetails,
  }) {
    return OrderModel(
      id: id ?? this.id,
      totalPay: totalPay ?? this.totalPay,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      status: status ?? this.status,
      orderProgess: orderProgess ?? this.orderProgess,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      accountNumber: accountNumber ?? this.accountNumber,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      customerNotes: customerNotes ?? this.customerNotes,
      productDetails: productDetails ?? this.productDetails,
    );
  }
}
