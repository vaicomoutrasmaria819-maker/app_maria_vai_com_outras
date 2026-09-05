import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProviderHomePage extends StatefulWidget {
  const ProviderHomePage({super.key});

  @override
  State<ProviderHomePage> createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ProviderJobsPage(),
    const ProviderQuotationsPage(),
    const ProviderEarningsPage(),
    const ProviderProfilePage(),
  ];

  // Mock data for quotations
  final List<Map<String, dynamic>> _availableServices = [
    {
      'id': '1',
      'title': 'Reparo de encanamento',
      'client': 'Maria Silva',
      'address': 'Rua das Flores, 123',
      'description': 'Vazamento na cozinha precisa de reparo urgente',
      'estimatedValue': 150.00,
      'status': 'pending',
      'date': '2024-01-15',
    },
    {
      'id': '2',
      'title': 'Instalação elétrica',
      'client': 'Ana Costa',
      'address': 'Av. Brasil, 456',
      'description': 'Preciso instalar pontos de luz na sala',
      'estimatedValue': 200.00,
      'status': 'pending',
      'date': '2024-01-16',
    },
  ];

  final List<Map<String, dynamic>> _acceptedServices = [
    {
      'id': '3',
      'title': 'Pintura de parede',
      'client': 'Julia Santos',
      'address': 'Rua São Paulo, 321',
      'description': 'Pintura de sala e quartos',
      'quotationValue': 450.00,
      'status': 'accepted',
      'date': '2024-01-10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maria Vai - Prestador',
          style: TextStyle(fontSize: isMobile ? 18 : 20),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.emergency),
            onPressed: () => context.push('/panic'),
            tooltip: 'Botão de Pânico',
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Trabalhos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Orçamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Ganhos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class ProviderJobsPage extends StatelessWidget {
  const ProviderJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Pendentes'),
              Tab(text: 'Em Andamento'),
              Tab(text: 'Concluídos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                const _JobsList(status: 'pending'),
                const _JobsList(status: 'in_progress'),
                const _JobsList(status: 'completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JobsList extends StatelessWidget {
  final String status;

  const _JobsList({required this.status});

  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'Pendente';
      case 'in_progress':
        return 'Em Andamento';
      case 'completed':
        return 'Concluído';
      default:
        return '';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _acceptJob(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Serviço aceito com sucesso!')),
    );
  }

  void _completeJob(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Serviço concluído com sucesso!')),
    );
  }

  void _requestPayment(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cobrança enviada ao cliente!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing
    final padding = isMobile ? 12.0 : 16.0;
    final cardPadding = isMobile ? 12.0 : 16.0;
    final titleFontSize = isMobile ? 16.0 : 18.0;
    final textFontSize = isMobile ? 12.0 : 14.0;
    final buttonPadding = isMobile ? 8.0 : 12.0;

    return ListView.builder(
      padding: EdgeInsets.all(padding),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: isMobile ? 8.0 : 12.0),
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Serviço #${index + 1}',
                        style: GoogleFonts.poppins(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!isMobile) ...[
                      Chip(
                        label: Text(_getStatusText(status)),
                        backgroundColor: _getStatusColor(status),
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusText(status),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: isMobile ? 6 : 8),
                Text(
                  'Cliente: Maria Silva',
                  style: TextStyle(fontSize: textFontSize),
                ),
                SizedBox(height: isMobile ? 2 : 4),
                Text(
                  'Endereço: Rua das Flores, 123',
                  style: TextStyle(fontSize: textFontSize),
                ),
                SizedBox(height: isMobile ? 2 : 4),
                Text(
                  'Valor: R\$ 150,00',
                  style: TextStyle(fontSize: textFontSize),
                ),
                SizedBox(height: isMobile ? 8 : 12),
                Wrap(
                  spacing: buttonPadding,
                  runSpacing: buttonPadding,
                  alignment: WrapAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => context.push(
                        '/chat?currentUserId=provider_1&otherUserId=client_1&otherUserName=Maria Silva',
                      ),
                      icon: const Icon(Icons.chat),
                      tooltip: 'Chat com cliente',
                    ),
                    if (status == 'pending')
                      ElevatedButton.icon(
                        onPressed: () => _acceptJob(context),
                        icon: Icon(Icons.check, size: isMobile ? 16 : 20),
                        label: Text(
                          'Aceitar',
                          style: TextStyle(fontSize: isMobile ? 12 : 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 12,
                          ),
                        ),
                      ),
                    if (status == 'in_progress') ...[
                      ElevatedButton.icon(
                        onPressed: () => _completeJob(context),
                        icon: Icon(Icons.done_all, size: isMobile ? 16 : 20),
                        label: Text(
                          'Concluir',
                          style: TextStyle(fontSize: isMobile ? 12 : 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 12,
                          ),
                        ),
                      ),
                      SizedBox(width: buttonPadding),
                      ElevatedButton.icon(
                        onPressed: () => _requestPayment(context),
                        icon: Icon(Icons.payment, size: isMobile ? 16 : 20),
                        label: Text(
                          'Cobrar',
                          style: TextStyle(fontSize: isMobile ? 12 : 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Classes mockadas apenas para evitar erros de compilação pelas páginas do BottomNavigationBar
class ProviderQuotationsPage extends StatefulWidget {
  const ProviderQuotationsPage({super.key});

  @override
  State<ProviderQuotationsPage> createState() => _ProviderQuotationsPageState();
}

class _ProviderQuotationsPageState extends State<ProviderQuotationsPage> {
  // Mock data will be accessed from parent
  List<Map<String, dynamic>> get _availableServices =>
      (context.findAncestorStateOfType<_ProviderHomePageState>())
          ?._availableServices ??
      [];
  List<Map<String, dynamic>> get _acceptedServices =>
      (context.findAncestorStateOfType<_ProviderHomePageState>())
          ?._acceptedServices ??
      [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Disponíveis'),
              Tab(text: 'Aceitos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _AvailableServicesList(
                  services: _availableServices,
                  isMobile: isMobile,
                  onAccept: (service) => _acceptService(context, service),
                  onQuote: (service) => _generateQuotation(context, service),
                ),
                _AcceptedServicesList(
                  services: _acceptedServices,
                  isMobile: isMobile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _acceptService(BuildContext context, Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aceitar Serviço'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cliente: ${service['client']}'),
            const SizedBox(height: 8),
            Text('Serviço: ${service['title']}'),
            const SizedBox(height: 8),
            Text('Endereço: ${service['address']}'),
            const SizedBox(height: 8),
            Text(
              'Valor estimado: R\$ ${service['estimatedValue'].toStringAsFixed(2)}',
            ),
            const Divider(height: 16),
            const Text(
              'Ao aceitar, você poderá gerar um orçamento detalhado.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
              final parentState = context
                  .findAncestorStateOfType<_ProviderHomePageState>();
              parentState?.setState(() {
                parentState._availableServices.remove(service);
                parentState._acceptedServices.add({
                  ...service,
                  'status': 'accepted',
                  'quotationValue': service['estimatedValue'],
                });
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Serviço aceito! Agora gere o orçamento.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Aceitar'),
          ),
        ],
      ),
    );
  }

  void _generateQuotation(BuildContext context, Map<String, dynamic> service) {
    final quotationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gerar Orçamento'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cliente: ${service['client']}'),
              const SizedBox(height: 8),
              Text('Serviço: ${service['title']}'),
              const SizedBox(height: 16),
              const Text('Descrição do orçamento:'),
              TextField(
                controller: quotationController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Descreva os detalhes do orçamento...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Valor estimado: R\$ ${service['estimatedValue'].toStringAsFixed(2)}',
              ),
              const SizedBox(height: 8),
              Text(
                'Comissão (20%): R\$ ${(service['estimatedValue'] * 0.2).toStringAsFixed(2)}',
              ),
              const Divider(height: 16),
              Text(
                'Valor a receber: R\$ ${(service['estimatedValue'] * 0.8).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
                  content: Text('Orçamento enviado ao cliente!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enviar Orçamento'),
          ),
        ],
      ),
    );
  }
}

class _AvailableServicesList extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final bool isMobile;
  final Function(Map<String, dynamic>) onAccept;
  final Function(Map<String, dynamic>) onQuote;

  const _AvailableServicesList({
    required this.services,
    required this.isMobile,
    required this.onAccept,
    required this.onQuote,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: isMobile ? 48 : 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum serviço disponível',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _ServiceCard(
          service: service,
          isMobile: isMobile,
          onAccept: () => onAccept(service),
          onQuote: () => onQuote(service),
        );
      },
    );
  }
}

class _AcceptedServicesList extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final bool isMobile;

  const _AcceptedServicesList({required this.services, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_turned_in,
              size: isMobile ? 48 : 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum serviço aceito',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _ServiceCard(
          service: service,
          isMobile: isMobile,
          isAccepted: true,
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;
  final bool isMobile;
  final bool isAccepted;
  final VoidCallback? onAccept;
  final VoidCallback? onQuote;

  const _ServiceCard({
    required this.service,
    required this.isMobile,
    this.isAccepted = false,
    this.onAccept,
    this.onQuote,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 12.0 : 16.0;
    final fontSize = isMobile ? 14.0 : 16.0;
    final smallFontSize = isMobile ? 12.0 : 14.0;

    return Card(
      margin: EdgeInsets.only(bottom: isMobile ? 8.0 : 12.0),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    service['title'],
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isAccepted ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isAccepted ? 'Aceito' : 'Disponível',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 6 : 8),
            Text(
              'Cliente: ${service['client']}',
              style: TextStyle(
                fontSize: smallFontSize,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: isMobile ? 4 : 6),
            Text(
              'Endereço: ${service['address']}',
              style: TextStyle(
                fontSize: smallFontSize,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: isMobile ? 4 : 6),
            Text(
              service['description'],
              style: TextStyle(
                fontSize: smallFontSize,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: isMobile ? 16 : 20,
                  color: Colors.green,
                ),
                SizedBox(width: isMobile ? 4 : 8),
                Text(
                  'Valor estimado: R\$ ${service['estimatedValue']?.toStringAsFixed(2) ?? service['quotationValue']?.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 12 : 16),
            if (!isAccepted)
              Wrap(
                spacing: isMobile ? 8 : 12,
                runSpacing: isMobile ? 8 : 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: onAccept,
                    icon: Icon(Icons.check_circle, size: isMobile ? 16 : 20),
                    label: Text(
                      'Aceitar',
                      style: TextStyle(fontSize: isMobile ? 12 : 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 8 : 12,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: onQuote,
                    icon: Icon(Icons.description, size: isMobile ? 16 : 20),
                    label: Text(
                      'Orçamento',
                      style: TextStyle(fontSize: isMobile ? 12 : 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16,
                        vertical: isMobile ? 8 : 12,
                      ),
                    ),
                  ),
                ],
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Orçamento já enviado ao cliente'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                icon: Icon(Icons.check, size: isMobile ? 16 : 20),
                label: Text(
                  'Orçamento Enviado',
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: isMobile ? 8 : 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProviderEarningsPage extends StatelessWidget {
  const ProviderEarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing
    final padding = isMobile ? 12.0 : 16.0;
    final cardPadding = isMobile ? 16.0 : 24.0;
    final spacing = isMobile ? 16.0 : 24.0;
    final balanceFontSize = isMobile ? 28.0 : 36.0;
    final titleFontSize = isMobile ? 18.0 : 20.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo Disponível',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  SizedBox(height: isMobile ? 6 : 8),
                  Text(
                    'R\$ 1.250,00',
                    style: GoogleFonts.poppins(
                      fontSize: balanceFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: spacing),
          Text(
            'Resumo de Ganhos',
            style: GoogleFonts.poppins(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spacing * 0.67),
          Card(
            child: ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.green),
              title: Text(
                'Este Mês',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              subtitle: Text(
                '15 serviços concluídos',
                style: TextStyle(fontSize: isMobile ? 12 : 14),
              ),
              trailing: Text(
                'R\$ 1.800,00',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.blue),
              title: Text(
                'Total Histórico',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              subtitle: Text(
                '48 serviços concluídos',
                style: TextStyle(fontSize: isMobile ? 12 : 14),
              ),
              trailing: Text(
                'R\$ 5.760,00',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance, color: Colors.orange),
              title: Text(
                'Comissões Pagas',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              subtitle: Text(
                '20% sobre cada serviço',
                style: TextStyle(fontSize: isMobile ? 12 : 14),
              ),
              trailing: Text(
                'R\$ 1.440,00',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) =>
//     const Center(child: Text('Tela de Ganhos'));

class ProviderProfilePage extends StatelessWidget {
  const ProviderProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: isMobile ? 40 : 50,
                  child: Icon(Icons.person, size: isMobile ? 40 : 50),
                ),
                SizedBox(height: isMobile ? 16 : 32),
                Text(
                  'Ana Costa',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Prestadora de Serviços',
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: isMobile ? 8 : 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: isMobile ? 16 : 20,
                    ),
                    SizedBox(width: isMobile ? 4 : 8),
                    Text(
                      '4.8',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 16),
                    Text(
                      '(45 avaliações)',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 12 : 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 16 : 32),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star),
              title: Text(
                'Minhas Avaliações',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push(
                  '/ratings?providerId=provider_1&providerName=Ana Costa',
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.work_outline),
              title: Text(
                'Meus Serviços',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to services
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(
                'Disponibilidade',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to availability
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Configurações',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              onTap: () {
                context.go('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
