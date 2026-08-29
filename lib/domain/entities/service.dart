import 'package:equatable/equatable.dart';

enum ServiceStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

class Service extends Equatable {
  final String id;
  final String clientId;
  final String providerId;
  final String title;
  final String description;
  final double price;
  final ServiceStatus status;
  final DateTime createdAt;
  final DateTime? scheduledDate;
  final DateTime? completedAt;
  final String? address;
  final String? clientNotes;
  final String? providerNotes;
  final List<String> photos;
  final bool isPaid;
  final double commissionRate; // 20% default

  const Service({
    required this.id,
    required this.clientId,
    required this.providerId,
    required this.title,
    required this.description,
    required this.price,
    required this.status,
    required this.createdAt,
    this.scheduledDate,
    this.completedAt,
    this.address,
    this.clientNotes,
    this.providerNotes,
    this.photos = const [],
    this.isPaid = false,
    this.commissionRate = 0.20,
  });

  double get commissionAmount => price * commissionRate;
  double get providerAmount => price - commissionAmount;

  @override
  List<Object?> get props => [
        id,
        clientId,
        providerId,
        title,
        description,
        price,
        status,
        createdAt,
        scheduledDate,
        completedAt,
        address,
        clientNotes,
        providerNotes,
        photos,
        isPaid,
        commissionRate,
      ];
}