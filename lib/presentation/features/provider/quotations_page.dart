import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariavai_services/domain/entities/service.dart';

class QuotationsPage extends StatefulWidget {
  const QuotationsPage({super.key});

  @override
  State<QuotationsPage> createState() => _QuotationsPageState();
}

class _QuotationsPageState extends State<QuotationsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Disponíveis'),
              Tab(text: 'Aceitos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [_AvailableQuotations(), _AcceptedQuotations()],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvailableQuotations extends StatelessWidget {
  const _AvailableQuotations();

  // Simulação de requisição assíncrona com dados mocados
  Future<List<Service>> _getMockedAvailableServices() async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simula delay de rede
    return [
      Service(
        id: '1',
        title: 'Limpeza Residencial Completa',
        description: 'Necessito de uma limpeza geral detalhada em apartamento de 2 quartos, incluindo lavagem de banheiros e organização da cozinha.',
        clientNotes: 'Focar na higienização dos vidros da varanda.',
        status: ServiceStatus.quotation,
        providerId: '',
        address: 'Av. Paulista, 1000 - Bela Vista, São Paulo - SP',
        scheduledDate: DateTime(2026, 9, 10),
        price: 200.0,
        clientId: '',
        createdAt: DateTime(2026, 9, 10),
      ),
      Service(
        id: '2',
        title: 'Manutenção de Jardim',
        description: 'Corte de grama e poda de pequenas árvores em condomínio residencial fechado.',
        clientNotes: 'Trazer ferramentas próprias para poda.',
        status: ServiceStatus.quotation,
        providerId: '',
        address: 'Alameda das Flores, 450 - Tamboré, Barueri - SP',
        scheduledDate: DateTime(2026, 9, 12),
        price: 350.0,
        commissionAmount: 70.0,
        providerAmount: 280.0,
        clientId: '',
        createdAt: DateTime(2026, 9, 10),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
      future: _getMockedAvailableServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        final availableQuotations = snapshot.data ?? [];

        if (availableQuotations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma solicitação disponível',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: availableQuotations.length,
          itemBuilder: (context, index) {
            final service = availableQuotations[index];
            return _QuotationCard(service: service);
          },
        );
      },
    );
  }
}

class _AcceptedQuotations extends StatelessWidget {
  const _AcceptedQuotations();

  // Simulação de requisição assíncrona com dados mocados
  Future<List<Service>> _getMockedAcceptedServices() async {
    await Future.delayed(
      const Duration(milliseconds: 600),
    ); // Simula delay de rede
    return [
      Service(
        id: '3',
        title: 'Organização de Closet',
        description: 'Organização profissional de armários e gaveteiros em quarto de casal utilizando técnicas de otimização de espaço.',
        clientNotes: 'Necessário levar organizadores se possível.',
        status: ServiceStatus.quotation,
        providerId: 'current_provider_id',
        address: 'Rua Augusta, 2500 - Cerqueira César, São Paulo - SP',
        scheduledDate: DateTime(2026, 9, 8),
        price: 180.0,
        commissionAmount: 36.0,
        providerAmount: 144.0,
        clientId: '',
        createdAt: DateTime(2026, 9, 10),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
      future: _getMockedAcceptedServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        final acceptedQuotations = snapshot.data ?? [];

        if (acceptedQuotations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_turned_in,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma solicitação aceita',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: acceptedQuotations.length,
          itemBuilder: (context, index) {
            final service = acceptedQuotations[index];
            return _QuotationCard(service: service, isAccepted: true);
          },
        );
      },
    );
  }
}

class _QuotationCard extends StatelessWidget {
  final Service service;
  final bool isAccepted;

  const _QuotationCard({required this.service, this.isAccepted = false});

  Color _getStatusColor() {
    switch (service.status) {
      case ServiceStatus.quotation:
        return isAccepted ? Colors.green : Colors.orange;
      case ServiceStatus.pending:
        return Colors.blue;
      case ServiceStatus.inProgress:
        return Colors.purple;
      case ServiceStatus.completed:
        return Colors.green;
      case ServiceStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText() {
    switch (service.status) {
      case ServiceStatus.quotation:
        return isAccepted ? 'Aceito' : 'Disponível';
      case ServiceStatus.pending:
        return 'Pendente';
      case ServiceStatus.inProgress:
        return 'Em andamento';
      case ServiceStatus.completed:
        return 'Concluído';
      case ServiceStatus.cancelled:
        return 'Cancelado';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    service.title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(_getStatusText()),
                  backgroundColor: _getStatusColor(),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (service.clientNotes != null)
              Text(
                service.clientNotes!,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            const SizedBox(height: 8),
            Text(
              service.description,
              style: GoogleFonts.poppins(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    service.address ?? 'Endereço não informado',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            if (service.scheduledDate != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Data: ${service.scheduledDate!.day}/${service.scheduledDate!.month}/${service.scheduledDate!.year}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
            if (service.price > 0) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.attach_money, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Valor estimado: R\$ ${service.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            if (!isAccepted)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _acceptQuotation(context),
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Aceitar Serviço'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _viewDetails(context),
                      icon: const Icon(Icons.info_outline),
                      label: const Text('Detalhes'),
                    ),
                  ),
                ],
              )
            else
              ElevatedButton.icon(
                onPressed: () => _viewDetails(context),
                icon: const Icon(Icons.work),
                label: const Text('Iniciar Serviço'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _acceptQuotation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aceitar Serviço'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Você está aceitando o serviço:'),
            const SizedBox(height: 8),
            Text(
              service.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Valor estimado: R\$ ${service.price.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              'Comissão (20%): R\$ ${service.commissionAmount.toStringAsFixed(2)}',
            ),
            const Divider(height: 16),
            Text(
              'Valor a receber: R\$ ${service.providerAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Serviço aceito com sucesso! (Modo MVP)'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _viewDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalhes do Serviço'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descrição:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(service.description),
              const SizedBox(height: 16),
              if (service.address != null) ...[
                const Text(
                  'Endereço:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(service.address!),
                const SizedBox(height: 16),
              ],
              if (service.scheduledDate != null) ...[
                const Text(
                  'Data desejada:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${service.scheduledDate!.day}/${service.scheduledDate!.month}/${service.scheduledDate!.year}',
                ),
                const SizedBox(height: 16),
              ],
              if (service.price > 0) ...[
                const Text(
                  'Valor estimado:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('R\$ ${service.price.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                const Text(
                  'Comissão (20%):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('R\$ ${service.commissionAmount.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                Text(
                  'Valor a receber: R\$ ${service.providerAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
