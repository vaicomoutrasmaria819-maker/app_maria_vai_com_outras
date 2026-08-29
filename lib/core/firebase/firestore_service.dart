import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mariavai_services/domain/entities/user.dart' as domain;
import 'package:mariavai_services/domain/entities/service.dart' as domain;
import 'package:mariavai_services/domain/entities/payment.dart' as domain;
import 'package:mariavai_services/domain/entities/panic_alert.dart' as domain;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Coleções
  static const String usersCollection = 'users';
  static const String servicesCollection = 'services';
  static const String paymentsCollection = 'payments';
  static const String panicAlertsCollection = 'panic_alerts';

  // ===== USUÁRIOS =====
  
  // Criar usuário
  Future<void> createUser(domain.User user) async {
    await _firestore.collection(usersCollection).doc(user.id).set({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'role': user.role.name,
      'gender': user.gender?.name,
      'photoUrl': user.photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'isActive': user.isActive,
    });
  }

  // Obter usuário por ID
  Future<domain.User?> getUserById(String userId) async {
    final doc = await _firestore.collection(usersCollection).doc(userId).get();
    if (!doc.exists) return null;

    return _mapDocumentToUser(doc);
  }

  // Stream de usuário
  Stream<domain.User?> userStream(String userId) {
    return _firestore
        .collection(usersCollection)
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? _mapDocumentToUser(doc) : null);
  }

  // Atualizar usuário
  Future<void> updateUser(domain.User user) async {
    await _firestore.collection(usersCollection).doc(user.id).update({
      'name': user.name,
      'phone': user.phone,
      'photoUrl': user.photoUrl,
      'isActive': user.isActive,
    });
  }

  // Listar usuários por role
  Stream<List<domain.User>> getUsersByRole(domain.UserRole role) {
    return _firestore
        .collection(usersCollection)
        .where('role', isEqualTo: role.name)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapDocumentToUser).toList());
  }

  // ===== SERVIÇOS =====

  // Criar serviço
  Future<void> createService(domain.Service service) async {
    await _firestore.collection(servicesCollection).doc(service.id).set({
      'clientId': service.clientId,
      'providerId': service.providerId,
      'title': service.title,
      'description': service.description,
      'price': service.price,
      'status': service.status.name,
      'createdAt': FieldValue.serverTimestamp(),
      'scheduledDate': service.scheduledDate,
      'completedAt': service.completedAt,
      'address': service.address,
      'clientNotes': service.clientNotes,
      'providerNotes': service.providerNotes,
      'photos': service.photos,
      'isPaid': service.isPaid,
      'commissionRate': service.commissionRate,
    });
  }

  // Obter serviço por ID
  Future<domain.Service?> getServiceById(String serviceId) async {
    final doc = await _firestore.collection(servicesCollection).doc(serviceId).get();
    if (!doc.exists) return null;

    return _mapDocumentToService(doc);
  }

  // Stream de serviços do cliente
  Stream<List<domain.Service>> getClientServices(String clientId) {
    return _firestore
        .collection(servicesCollection)
        .where('clientId', isEqualTo: clientId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapDocumentToService).toList());
  }

  // Stream de serviços do prestador
  Stream<List<domain.Service>> getProviderServices(String providerId) {
    return _firestore
        .collection(servicesCollection)
        .where('providerId', isEqualTo: providerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapDocumentToService).toList());
  }

  // Atualizar status do serviço
  Future<void> updateServiceStatus(String serviceId, domain.ServiceStatus status) async {
    await _firestore.collection(servicesCollection).doc(serviceId).update({
      'status': status.name,
      if (status == domain.ServiceStatus.completed) 'completedAt': FieldValue.serverTimestamp(),
    });
  }

  // Atualizar serviço
  Future<void> updateService(domain.Service service) async {
    await _firestore.collection(servicesCollection).doc(service.id).update({
      'title': service.title,
      'description': service.description,
      'price': service.price,
      'address': service.address,
      'clientNotes': service.clientNotes,
      'providerNotes': service.providerNotes,
      'photos': service.photos,
      'isPaid': service.isPaid,
    });
  }

  // ===== PAGAMENTOS =====

  // Criar pagamento
  Future<void> createPayment(domain.Payment payment) async {
    await _firestore.collection(paymentsCollection).doc(payment.id).set({
      'serviceId': payment.serviceId,
      'amount': payment.amount,
      'commissionAmount': payment.commissionAmount,
      'status': payment.status.name,
      'method': payment.method.name,
      'createdAt': FieldValue.serverTimestamp(),
      'processedAt': payment.processedAt,
      'transactionId': payment.transactionId,
      'qrCodePix': payment.qrCodePix,
      'boletoUrl': payment.boletoUrl,
    });
  }

  // Stream de todos os pagamentos (para admin)
  Stream<List<domain.Payment>> getAllPayments() {
    return _firestore
        .collection(paymentsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapDocumentToPayment).toList());
  }

  // ===== ALERTAS DE PÂNICO =====

  // Criar alerta de pânico
  Future<void> createPanicAlert(domain.PanicAlert alert) async {
    await _firestore.collection(panicAlertsCollection).doc(alert.id).set({
      'userId': alert.userId,
      'serviceId': alert.serviceId,
      'latitude': alert.latitude,
      'longitude': alert.longitude,
      'address': alert.address,
      'status': alert.status.name,
      'triggeredAt': FieldValue.serverTimestamp(),
      'acknowledgedAt': alert.acknowledgedAt,
      'resolvedAt': alert.resolvedAt,
      'notes': alert.notes,
      'emergencyContactsNotified': alert.emergencyContactsNotified,
    });
  }

  // Stream de alertas de pânico (para admin)
  Stream<List<domain.PanicAlert>> getPanicAlerts() {
    return _firestore
        .collection(panicAlertsCollection)
        .orderBy('triggeredAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_mapDocumentToPanicAlert).toList());
  }

  // Atualizar status do alerta
  Future<void> updatePanicAlertStatus(String alertId, domain.PanicStatus status) async {
    final updateData = <String, dynamic>{'status': status.name};
    
    if (status == domain.PanicStatus.acknowledged) {
      updateData['acknowledgedAt'] = FieldValue.serverTimestamp();
    } else if (status == domain.PanicStatus.resolved || status == domain.PanicStatus.falseAlarm) {
      updateData['resolvedAt'] = FieldValue.serverTimestamp();
    }
    
    await _firestore.collection(panicAlertsCollection).doc(alertId).update(updateData);
  }

  // ===== MAPEAMENTOS =====

  domain.User _mapDocumentToUser(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return domain.User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      role: _parseUserRole(data['role']),
      gender: _parseGender(data['gender']),
      photoUrl: data['photoUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
    );
  }

  domain.Service _mapDocumentToService(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return domain.Service(
      id: doc.id,
      clientId: data['clientId'] ?? '',
      providerId: data['providerId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      status: _parseServiceStatus(data['status']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      scheduledDate: data['scheduledDate'] != null 
          ? (data['scheduledDate'] as Timestamp).toDate() 
          : null,
      completedAt: data['completedAt'] != null 
          ? (data['completedAt'] as Timestamp).toDate() 
          : null,
      address: data['address'],
      clientNotes: data['clientNotes'],
      providerNotes: data['providerNotes'],
      photos: List<String>.from(data['photos'] ?? []),
      isPaid: data['isPaid'] ?? false,
      commissionRate: (data['commissionRate'] ?? 0.20).toDouble(),
    );
  }

  domain.Payment _mapDocumentToPayment(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return domain.Payment(
      id: doc.id,
      serviceId: data['serviceId'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      commissionAmount: (data['commissionAmount'] ?? 0.0).toDouble(),
      status: _parsePaymentStatus(data['status']),
      method: _parsePaymentMethod(data['method']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      processedAt: data['processedAt'] != null 
          ? (data['processedAt'] as Timestamp).toDate() 
          : null,
      transactionId: data['transactionId'],
      qrCodePix: data['qrCodePix'],
      boletoUrl: data['boletoUrl'],
    );
  }

  domain.PanicAlert _mapDocumentToPanicAlert(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return domain.PanicAlert(
      id: doc.id,
      userId: data['userId'] ?? '',
      serviceId: data['serviceId'],
      latitude: data['latitude']?.toDouble(),
      longitude: data['longitude']?.toDouble(),
      address: data['address'],
      status: _parsePanicStatus(data['status']),
      triggeredAt: (data['triggeredAt'] as Timestamp).toDate(),
      acknowledgedAt: data['acknowledgedAt'] != null 
          ? (data['acknowledgedAt'] as Timestamp).toDate() 
          : null,
      resolvedAt: data['resolvedAt'] != null 
          ? (data['resolvedAt'] as Timestamp).toDate() 
          : null,
      notes: data['notes'],
      emergencyContactsNotified: List<String>.from(data['emergencyContactsNotified'] ?? []),
    );
  }

  // Parsers de enums
  domain.UserRole _parseUserRole(String? role) {
    switch (role) {
      case 'client': return domain.UserRole.client;
      case 'provider': return domain.UserRole.provider;
      case 'admin': return domain.UserRole.admin;
      default: return domain.UserRole.client;
    }
  }

  domain.Gender _parseGender(String? gender) {
    switch (gender) {
      case 'female': return domain.Gender.female;
      case 'male': return domain.Gender.male;
      case 'other': return domain.Gender.other;
      case 'preferNotToSay': return domain.Gender.preferNotToSay;
      default: return null;
    }
  }

  domain.ServiceStatus _parseServiceStatus(String? status) {
    switch (status) {
      case 'quotation': return domain.ServiceStatus.quotation;
      case 'pending': return domain.ServiceStatus.pending;
      case 'inProgress': return domain.ServiceStatus.inProgress;
      case 'completed': return domain.ServiceStatus.completed;
      case 'cancelled': return domain.ServiceStatus.cancelled;
      default: return domain.ServiceStatus.quotation;
    }
  }

  domain.PaymentStatus _parsePaymentStatus(String? status) {
    switch (status) {
      case 'pending': return domain.PaymentStatus.pending;
      case 'processing': return domain.PaymentStatus.processing;
      case 'completed': return domain.PaymentStatus.completed;
      case 'failed': return domain.PaymentStatus.failed;
      case 'refunded': return domain.PaymentStatus.refunded;
      default: return domain.PaymentStatus.pending;
    }
  }

  domain.PaymentMethod _parsePaymentMethod(String? method) {
    switch (method) {
      case 'creditCard': return domain.PaymentMethod.creditCard;
      case 'debitCard': return domain.PaymentMethod.debitCard;
      case 'pix': return domain.PaymentMethod.pix;
      case 'boleto': return domain.PaymentMethod.boleto;
      default: return domain.PaymentMethod.pix;
    }
  }

  domain.PanicStatus _parsePanicStatus(String? status) {
    switch (status) {
      case 'triggered': return domain.PanicStatus.triggered;
      case 'acknowledged': return domain.PanicStatus.acknowledged;
      case 'resolved': return domain.PanicStatus.resolved;
      case 'falseAlarm': return domain.PanicStatus.falseAlarm;
      default: return domain.PanicStatus.triggered;
    }
  }
}