import 'package:equatable/equatable.dart';

enum MessageType {
  text,
  image,
  location,
}

class Message extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final bool isRead;
  final String? serviceId; // Opcional: relacionado a um serviço específico

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.serviceId,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        content,
        type,
        createdAt,
        isRead,
        serviceId,
      ];
}