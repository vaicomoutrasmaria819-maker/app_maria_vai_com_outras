import 'package:equatable/equatable.dart';

enum RatingStatus {
  pending,
  completed,
  reported,
}

class Rating extends Equatable {
  final String id;
  final String serviceId;
  final String clientId;
  final String clientName;
  final String providerId;
  final String providerName;
  final double rating; // 1.0 to 5.0
  final String? comment;
  final List<String>? categories; // Professionalism, Quality, Punctuality, etc.
  final DateTime createdAt;
  final RatingStatus status;
  final String? response; // Provider's response to the rating

  const Rating({
    required this.id,
    required this.serviceId,
    required this.clientId,
    required this.clientName,
    required this.providerId,
    required this.providerName,
    required this.rating,
    this.comment,
    this.categories,
    required this.createdAt,
    this.status = RatingStatus.completed,
    this.response,
  });

  @override
  List<Object?> get props => [
        id,
        serviceId,
        clientId,
        clientName,
        providerId,
        providerName,
        rating,
        comment,
        categories,
        createdAt,
        status,
        response,
      ];

  Rating copyWith({
    String? id,
    String? serviceId,
    String? clientId,
    String? clientName,
    String? providerId,
    String? providerName,
    double? rating,
    String? comment,
    List<String>? categories,
    DateTime? createdAt,
    RatingStatus? status,
    String? response,
  }) {
    return Rating(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      providerId: providerId ?? this.providerId,
      providerName: providerName ?? this.providerName,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }
}