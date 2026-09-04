import 'package:mariavai_services/domain/entities/payment.dart';
import 'package:mariavai_services/domain/entities/service.dart';

class PaymentService {
  // Mock payment service - in production, integrate with Mercado Pago
  static Future<Payment> createPayment({
    required Service service,
    required PaymentMethod method,
  }) async {
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    final commissionAmount = service.commissionAmount;

    return Payment(
      id: 'pay_${DateTime.now().millisecondsSinceEpoch}',
      serviceId: service.id,
      amount: service.price,
      commissionAmount: commissionAmount,
      status: PaymentStatus.completed,
      method: method,
      createdAt: DateTime.now(),
      processedAt: DateTime.now(),
      transactionId: 'txn_${DateTime.now().millisecondsSinceEpoch}',
      qrCodePix: method == PaymentMethod.pix ? '00020126580014br.gov.bcb.pix0136' : null,
      boletoUrl: method == PaymentMethod.boleto ? 'https://mercadopago.com/boleto/12345' : null, providerAmount: 1,
    );
  }

  static Future<String> generatePixQrCode(double amount) async {
    // Mock PIX QR code generation
    await Future.delayed(const Duration(seconds: 1));
    return '00020126580014br.gov.bcb.pix0136${amount.toStringAsFixed(2)}5204000053039865404${amount.toStringAsFixed(2)}5802BR5913MariaVaiServicos6008SaoPaulo62070503***6304ABCD';
  }

  static Future<String> generateBoletoUrl(double amount) async {
    // Mock boleto generation
    await Future.delayed(const Duration(seconds: 1));
    return 'https://mercadopago.com/boleto/${DateTime.now().millisecondsSinceEpoch}?amount=$amount';
  }
}