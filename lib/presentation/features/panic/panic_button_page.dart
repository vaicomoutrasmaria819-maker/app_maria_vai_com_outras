import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mariavai_services/core/firebase/firestore_service.dart';
import 'package:mariavai_services/domain/entities/panic_alert.dart';

class PanicButtonPage extends StatefulWidget {
  const PanicButtonPage({super.key});

  @override
  State<PanicButtonPage> createState() => _PanicButtonPageState();
}

class _PanicButtonPageState extends State<PanicButtonPage> {
  bool _isTriggered = false;
  bool _isLoading = false;
  String? _currentLocation;
  DateTime? _triggeredAt;
  // MVP: Firestore desabilitado
  // final FirestoreService _firestoreService = FirestoreService();
  final String _userId = 'current_user_id'; // TODO: Get from auth

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation =
          '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
    });
  }

  Future<void> _callEmergencyServices() async {
    const emergencyNumber = '190'; // Brazil emergency number
    await FlutterPhoneDirectCaller.callNumber(emergencyNumber);
  }

  Future<void> _sendLocationToContacts() async {
    // In a real app, this would send SMS/WhatsApp to emergency contacts
    // with the current location and panic alert
    setState(() => _isLoading = true);

    await _getCurrentLocation();

    // Simulate sending alert
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Localização enviada: $_currentLocation'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _triggerPanic() async {
    setState(() {
      _isTriggered = true;
      _triggeredAt = DateTime.now();
    });

    // Get current location
    await _getCurrentLocation();

    // Create panic alert in Firestore
    if (_currentLocation != null) {
      final locationParts = _currentLocation!.split(',');
      final latitude = double.tryParse(locationParts[0].trim());
      final longitude = double.tryParse(locationParts[1].trim());

      final alert = PanicAlert(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _userId,
        latitude: latitude,
        longitude: longitude,
        status: PanicStatus.triggered,
        triggeredAt: DateTime.now(),
        emergencyContactsNotified: [],
      );

      try {
        // MVP: Firestore desabilitado
        // await _firestoreService.createPanicAlert(alert);
        print('MVP: Alerta de pânico não salvo no Firebase (desabilitado)');
      } catch (e) {
        print('Erro ao criar alerta no Firestore: $e');
      }
    }

    // Send location to contacts
    _sendLocationToContacts();

    // Call emergency services
    _callEmergencyServices();
  }

  void _resetPanic() {
    setState(() {
      _isTriggered = false;
      _triggeredAt = null;
      _currentLocation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Botão de Pânico'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _isTriggered
                ? [Colors.red[900]!, Colors.red[700]!]
                : [Colors.pink[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isTriggered ? Icons.warning : Icons.security,
                    size: 100,
                    color: _isTriggered ? Colors.white : Colors.red[700],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _isTriggered ? 'ALERTA ACIONADO!' : 'Botão de Pânico',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: _isTriggered ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  if (_isTriggered) ...[
                    Text(
                      'Acionado às ${_triggeredAt != null ? _triggeredAt!.toLocal().toString().split('.')[0] : ""}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_currentLocation != null)
                      Text(
                        'Localização: $_currentLocation',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 24),
                    if (_isLoading)
                      const CircularProgressIndicator(color: Colors.white)
                    else
                      ElevatedButton.icon(
                        onPressed: _resetPanic,
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Desativar Alerta'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red[700],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                  ] else ...[
                    Text(
                      'Toque o botão abaixo em caso de emergência',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    GestureDetector(
                      onTap: _triggerPanic,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.red[600]!, Colors.red[800]!],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.crisis_alert,
                                size: 60,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'SOS',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Icon(Icons.info_outline, color: Colors.blue),
                            const SizedBox(height: 8),
                            Text(
                              'Ao acionar o botão:',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('• Seu local será compartilhado'),
                            const Text(
                              '• Contatos de emergência serão avisados',
                            ),
                            const Text(
                              '• Serviços de emergência serão chamados',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
