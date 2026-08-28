import 'package:equatable/equatable.dart';

enum PanicStatus {
  triggered,
  acknowledged,
  resolved,
  falseAlarm,
}

class PanicAlert extends Equatable {
  final String id;
  final String userId;
  final String? serviceId;
  final double? latitude;
  final double? longitude;
  final String? address;
  final PanicStatus status;
  final DateTime triggeredAt;
  final DateTime? acknowledgedAt;
  final DateTime? resolvedAt;
  final String? notes;
  final List<String> emergencyContactsNotified;

  const PanicAlert({
    required this.id,
    required this.userId,
    this.serviceId,
    this.latitude,
    this.longitude,
    this.address,
    required this.status,
    required this.triggeredAt,
    this.acknowledgedAt,
    this.resolvedAt,
    this.notes,
    this.emergencyContactsNotified = const [],
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        serviceId,
        latitude,
        longitude,
        address,
        status,
        triggeredAt,
        acknowledgedAt,
        resolvedAt,
        notes,
        emergencyContactsNotified,
      ];
}