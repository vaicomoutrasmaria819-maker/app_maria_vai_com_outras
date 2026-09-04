import 'package:equatable/equatable.dart';

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

enum PaymentMethod {
  creditCard,
  debitCard,
  pix,
  boleto,
}

class Payment extends Equatable {
  final String id;
  final String serviceId;
  final double amount;
  final double commissionAmount;
  final double providerAmount;
  final PaymentStatus status;
  final PaymentMethod method;
  final DateTime createdAt;
  final DateTime? processedAt;
  final String? transactionId;
  final String? qrCodePix;
  final String? boletoUrl;

  const Payment({
    required this.id,
    required this.serviceId,
    required this.amount,
    required this.commissionAmount,
    required this.providerAmount,
    required this.status,
    required this.method,
    required this.createdAt,
    this.processedAt,
    this.transactionId,
    this.qrCodePix,
    this.boletoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        serviceId,
        amount,
        commissionAmount,
        providerAmount,
        status,
        method,
        createdAt,
        processedAt,
        transactionId,
        qrCodePix,
        boletoUrl,
      ];
}