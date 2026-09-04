// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mariavai_services/core/firebase/firestore_service.dart';
// import 'package:mariavai_services/domain/entities/service.dart';
//
// class QuotationRequestPage extends StatefulWidget {
//   const QuotationRequestPage({super.key});
//
//   @override
//   State<QuotationRequestPage> createState() => _QuotationRequestPageState();
// }
//
// class _QuotationRequestPageState extends State<QuotationRequestPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _estimatedPriceController = TextEditingController();
//
//   final _firestoreService = FirestoreService();
//
//   String _selectedCategory = 'Limpeza';
//   DateTime? _scheduledDate;
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   final List<String> _categories = [
//     'Limpeza',
//     'Cuidados',
//     'Alimentação',
//     'Educação',
//     'Saúde',
//     'Beleza',
//     'Manutenção',
//     'Outros',
//   ];
//
//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _addressController.dispose();
//     _estimatedPriceController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _submitQuotation() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//
//     try {
//       // Simulação - em produção, pegar ID do usuário autenticado
//       final clientId = 'current_user_id'; // TODO: Get from auth
//
//       final service = Service(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         clientId: clientId,
//         providerId: '', // Será preenchido quando uma prestadora aceitar
//         title: _titleController.text.trim(),
//         description: _descriptionController.text.trim(),
//         price: double.tryParse(_estimatedPriceController.text) ?? 0.0,
//         status: ServiceStatus.quotation,
//         createdAt: DateTime.now(),
//         scheduledDate: _scheduledDate,
//         address: _addressController.text.trim(),
//         clientNotes: 'Categoria: $_selectedCategory',
//         commissionRate: 0.20,
//       );
//
//       await _firestoreService.createService(service);
//
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Solicitação de orçamento enviada com sucesso!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//         context.pop();
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Erro ao enviar solicitação: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _selectDate() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().add(const Duration(days: 1)),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//
//     if (picked != null && mounted) {
//       setState(() {
//         _scheduledDate = picked;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Solicitar Orçamento'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Icon(
//                 Icons.request_quote,
//                 size: 64,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Solicitar Profissional Feminina',
//                 style: GoogleFonts.poppins(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Preencha os detalhes do serviço que você precisa',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 32),
//
//               // Categoria
//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 decoration: const InputDecoration(
//                   labelText: 'Categoria do Serviço',
//                   prefixIcon: Icon(Icons.category),
//                   border: OutlineInputBorder(),
//                 ),
//                 items: _categories.map((category) {
//                   return DropdownMenuItem(
//                     value: category,
//                     child: Text(category),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() => _selectedCategory = value!);
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               // Título
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   labelText: 'Título do Serviço',
//                   prefixIcon: Icon(Icons.title),
//                   border: OutlineInputBorder(),
//                   hintText: 'Ex: Limpeza residencial completa',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Informe o título do serviço';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               // Descrição
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Descrição Detalhada',
//                   prefixIcon: Icon(Icons.description),
//                   border: OutlineInputBorder(),
//                   hintText: 'Descreva o serviço que você precisa...',
//                 ),
//                 maxLines: 4,
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Descreva o serviço';
//                   }
//                   if (value.length < 20) {
//                     return 'A descrição deve ter pelo menos 20 caracteres';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               // Endereço
//               TextFormField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(
//                   labelText: 'Endereço Completo',
//                   prefixIcon: Icon(Icons.location_on),
//                   border: OutlineInputBorder(),
//                   hintText: 'Rua, número, bairro, cidade',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Informe o endereço';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               // Data desejada
//               InkWell(
//                 onTap: _selectDate,
//                 child: InputDecorator(
//                   decoration: const InputDecoration(
//                     labelText: 'Data Desejada',
//                     prefixIcon: Icon(Icons.calendar_today),
//                     border: OutlineInputBorder(),
//                   ),
//                   child: Text(
//                     _scheduledDate != null
//                         ? '${_scheduledDate!.day}/${_scheduledDate!.month}/${_scheduledDate!.year}'
//                         : 'Selecione a data',
//                     style: TextStyle(
//                       color: _scheduledDate != null ? Colors.black : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Valor estimado (opcional)
//               TextFormField(
//                 controller: _estimatedPriceController,
//                 decoration: const InputDecoration(
//                   labelText: 'Valor Estimado (R$) - Opcional',
//                   prefixIcon: Icon(Icons.attach_money),
//                   border: OutlineInputBorder(),
//                   hintText: 'Deixe em branco se não sabe',
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     final price = double.tryParse(value);
//                     if (price == null || price <= 0) {
//                       return 'Valor inválido';
//                     }
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//
//               // Informação sobre profissionais femininas
//               Card(
//                 color: Colors.pink[50],
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.woman, color: Colors.pink),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Text(
//                           'Esta solicitação será enviada apenas para profissionais femininas cadastradas na plataforma.',
//                           style: GoogleFonts.poppins(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               if (_errorMessage != null)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Text(
//                     _errorMessage!,
//                     style: const TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _submitQuotation,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: _isLoading
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : const Text(
//                         'Enviar Solicitação de Orçamento',
//                         style: TextStyle(fontSize: 16),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }