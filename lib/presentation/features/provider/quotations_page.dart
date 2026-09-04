// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mariavai_services/core/firebase/firestore_service.dart';
// import 'package:mariavai_services/domain/entities/service.dart';
//
// class QuotationsPage extends StatefulWidget {
//   const QuotationsPage({super.key});
//
//   @override
//   State<QuotationsPage> createState() => _QuotationsPageState();
// }
//
// class _QuotationsPageState extends State<QuotationsPage> {
//   final _firestoreService = FirestoreService();
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         children: [
//           TabBar(
//             tabs: const [
//               Tab(text: 'Disponíveis'),
//               Tab(text: 'Aceitos'),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 _AvailableQuotations(),
//                 _AcceptedQuotations(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _AvailableQuotations extends StatelessWidget {
//   _AvailableQuotations();
//
//   final _firestoreService = FirestoreService();
//
//   @override
//   Widget build(BuildContext context) {
//     // Simulação - em produção, filtrar por providerId = null e status = quotation
//     return StreamBuilder<List<Service>>(
//       stream: _firestoreService.getProviderServices('current_provider_id'), // TODO: Get from auth
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text('Erro: ${snapshot.error}'));
//         }
//
//         final services = snapshot.data ?? [];
//         final availableQuotations = services
//             .where((s) => s.status == ServiceStatus.quotation && s.providerId.isEmpty)
//             .toList();
//
//         if (availableQuotations.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.inbox,
//                   size: 64,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Nenhuma solicitação disponível',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: availableQuotations.length,
//           itemBuilder: (context, index) {
//             final service = availableQuotations[index];
//             return _QuotationCard(service: service);
//           },
//         );
//       },
//     );
//   }
// }
//
// class _AcceptedQuotations extends StatelessWidget {
//   _AcceptedQuotations();
//
//   final _firestoreService = FirestoreService();
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Service>>(
//       stream: _firestoreService.getProviderServices('current_provider_id'), // TODO: Get from auth
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(child: Text('Erro: ${snapshot.error}'));
//         }
//
//         final services = snapshot.data ?? [];
//         final acceptedQuotations = services
//             .where((s) => s.status == ServiceStatus.quotation && s.providerId.isNotEmpty)
//             .toList();
//
//         if (acceptedQuotations.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.assignment_turned_in,
//                   size: 64,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Nenhuma solicitação aceita',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: acceptedQuotations.length,
//           itemBuilder: (context, index) {
//             final service = acceptedQuotations[index];
//             return _QuotationCard(service: service, isAccepted: true);
//           },
//         );
//       },
//     );
//   }
// }
//
// class _QuotationCard extends StatelessWidget {
//   final Service service;
//   final bool isAccepted;
//
//   const _QuotationCard({
//     required this.service,
//     this.isAccepted = false,
//   });
//
//   Color _getStatusColor() {
//     switch (service.status) {
//       case ServiceStatus.quotation:
//         return isAccepted ? Colors.green : Colors.orange;
//       case ServiceStatus.pending:
//         return Colors.blue;
//       case ServiceStatus.inProgress:
//         return Colors.purple;
//       case ServiceStatus.completed:
//         return Colors.green;
//       case ServiceStatus.cancelled:
//         return Colors.red;
//     }
//   }
//
//   String _getStatusText() {
//     switch (service.status) {
//       case ServiceStatus.quotation:
//         return isAccepted ? 'Aceito' : 'Disponível';
//       case ServiceStatus.pending:
//         return 'Pendente';
//       case ServiceStatus.inProgress:
//         return 'Em andamento';
//       case ServiceStatus.completed:
//         return 'Concluído';
//       case ServiceStatus.cancelled:
//         return 'Cancelado';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     service.title,
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Chip(
//                   label: Text(_getStatusText()),
//                   backgroundColor: _getStatusColor(),
//                   labelStyle: const TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             if (service.clientNotes != null)
//               Text(
//                 service.clientNotes!,
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             const SizedBox(height: 8),
//             Text(
//               service.description,
//               style: GoogleFonts.poppins(fontSize: 14),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                 const SizedBox(width: 4),
//                 Expanded(
//                   child: Text(
//                     service.address ?? 'Endereço não informado',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (service.scheduledDate != null) ...[
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//                   const SizedBox(width: 4),
//                   Text(
//                     'Data: ${service.scheduledDate!.day}/${service.scheduledDate!.month}/${service.scheduledDate!.year}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//             if (service.price > 0) ...[
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(Icons.attach_money, size: 16, color: Colors.green),
//                   const SizedBox(width: 4),
//                   Text(
//                     'Valor estimado: R\$ ${service.price.toStringAsFixed(2)}',
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[700],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//             const SizedBox(height: 16),
//             if (!isAccepted)
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () => _acceptQuotation(context),
//                       icon: const Icon(Icons.check_circle),
//                       label: const Text('Aceitar Serviço'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: () => _viewDetails(context),
//                       icon: const Icon(Icons.info_outline),
//                       label: const Text('Detalhes'),
//                     ),
//                   ),
//                 ],
//               )
//             else
//               ElevatedButton.icon(
//                 onPressed: () => _viewDetails(context),
//                 icon: const Icon(Icons.work),
//                 label: const Text('Iniciar Serviço'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   foregroundColor: Colors.white,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _acceptQuotation(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Aceitar Serviço'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Você está aceitando o serviço:'),
//             const SizedBox(height: 8),
//             Text(
//               service.title,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text('Valor estimado: R\$ ${service.price.toStringAsFixed(2)}'),
//             const SizedBox(height: 8),
//             Text('Comissão (20%): R\$ ${service.commissionAmount.toStringAsFixed(2)}'),
//             const Divider(height: 16),
//             Text(
//               'Valor a receber: R\$ ${service.providerAmount.toStringAsFixed(2)}',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green[700],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancelar'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               // TODO: Implementar aceitação no Firestore
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Serviço aceito com sucesso!'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             child: const Text('Confirmar'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _viewDetails(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Detalhes do Serviço'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 service.title,
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               const SizedBox(height: 16),
//               const Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Text(service.description),
//               const SizedBox(height: 16),
//               if (service.address != null) ...[
//                 const Text('Endereço:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text(service.address!),
//                 const SizedBox(height: 16),
//               ],
//               if (service.scheduledDate != null) ...[
//                 const Text('Data desejada:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('${service.scheduledDate!.day}/${service.scheduledDate!.month}/${service.scheduledDate!.year}'),
//                 const SizedBox(height: 16),
//               ],
//               if (service.price > 0) ...[
//                 const Text('Valor estimado:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('R\$ ${service.price.toStringAsFixed(2)}'),
//                 const SizedBox(height: 8),
//                 const Text('Comissão (20%):', style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text('R\$ ${service.commissionAmount.toStringAsFixed(2)}'),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Valor a receber: R\$ ${service.providerAmount.toStringAsFixed(2)}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green[700],
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Fechar'),
//           ),
//         ],
//       ),
//     );
//   }
// }