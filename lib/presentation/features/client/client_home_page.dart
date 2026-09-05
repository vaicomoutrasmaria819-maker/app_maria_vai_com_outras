import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_theme.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({super.key});

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ClientServicesPage(),
    const ClientOrdersPage(),
    const ClientQuotationsPage(),
    const ClientProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.crisis_alert),
            onPressed: () => context.push('/panic'),
            tooltip: 'Botão de Pânico',
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1A1A1A)
            : AppTheme.primaryWhite,
        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.primaryPink
            : AppTheme.primaryBlack,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Serviços'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Meus Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Orçamentos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewServiceDialog(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          'Novo Serviço',
          style: TextStyle(fontSize: isMobile ? 12 : 14),
        ),
      ),
    );
  }

  void _showNewServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Solicitar Novo Serviço'),
        content: const Text(
          'Funcionalidade de criação de serviço será implementada.',
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

class ClientServicesPage extends StatelessWidget {
  const ClientServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing
    final crossAxisCount = isMobile ? 2 : 3;
    final padding = isMobile ? 12.0 : 16.0;
    final spacing = isMobile ? 16.0 : 24.0;
    final titleFontSize = isMobile ? 20.0 : 24.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Serviços',
            style: GoogleFonts.poppins(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spacing),
          Expanded(
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              children: [
                _ServiceCategoryCard(
                  icon: Icons.plumbing,
                  title: 'Encanamento',
                  color: Colors.blue,
                  isMobile: isMobile,
                ),
                _ServiceCategoryCard(
                  icon: Icons.electrical_services,
                  title: 'Elétrica',
                  color: Colors.orange,
                  isMobile: isMobile,
                ),
                _ServiceCategoryCard(
                  icon: Icons.construction,
                  title: 'Alvenaria',
                  color: Colors.brown,
                  isMobile: isMobile,
                ),
                _ServiceCategoryCard(
                  icon: Icons.layers,
                  title: 'Pisos',
                  color: Colors.grey,
                  isMobile: isMobile,
                ),
                _ServiceCategoryCard(
                  icon: Icons.bathroom,
                  title: 'Banheiro',
                  color: Colors.teal,
                  isMobile: isMobile,
                ),
                _ServiceCategoryCard(
                  icon: Icons.chat,
                  title: 'Chat Suporte',
                  color: Colors.purple,
                  onTap: () => context.push(
                    '/chat?currentUserId=client_1&otherUserId=provider_1&otherUserName=Ana Costa',
                  ),
                  isMobile: isMobile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;
  final bool isMobile;

  const _ServiceCategoryCard({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = isMobile ? 36.0 : 48.0;
    final padding = isMobile ? 12.0 : 16.0;
    final spacing = isMobile ? 8.0 : 12.0;
    final fontSize = isMobile ? 14.0 : 16.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap:
            onTap ??
            () {
              // TODO: Navigate to service providers
            },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: color),
              SizedBox(height: spacing),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientOrdersPage extends StatelessWidget {
  const ClientOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing
    final padding = isMobile ? 12.0 : 16.0;
    final spacing = isMobile ? 12.0 : 16.0;
    final titleFontSize = isMobile ? 20.0 : 24.0;
    final avatarRadius = isMobile ? 20.0 : 24.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meus Pedidos',
            style: GoogleFonts.poppins(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spacing),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: spacing * 0.75),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: avatarRadius,
                      child: Icon(
                        Icons.cleaning_services,
                        size: isMobile ? 20 : 24,
                      ),
                    ),
                    title: Text(
                      'Serviço #${index + 1}',
                      style: TextStyle(fontSize: isMobile ? 14 : 16),
                    ),
                    subtitle: Text(
                      'Status: ${_getStatus(index)}',
                      style: TextStyle(fontSize: isMobile ? 12 : 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_getStatus(index) == 'Concluído')
                          IconButton(
                            icon: Icon(
                              Icons.star,
                              size: isMobile ? 20 : 24,
                              color: Colors.amber,
                            ),
                            onPressed: () {
                              context.push(
                                '/create-rating?serviceId=service_${index + 1}&providerId=provider_1&providerName=Ana Costa&serviceTitle=Serviço #${index + 1}',
                              );
                            },
                            tooltip: 'Avaliar serviço',
                          ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    onTap: () {
                      // TODO: Navigate to order details
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getStatus(int index) {
    switch (index) {
      case 0:
        return 'Em andamento';
      case 1:
        return 'Concluído';
      default:
        return 'Pendente';
    }
  }
}

class ClientQuotationsPage extends StatefulWidget {
  const ClientQuotationsPage({super.key});

  @override
  State<ClientQuotationsPage> createState() => _ClientQuotationsPageState();
}

class _ClientQuotationsPageState extends State<ClientQuotationsPage> {
  // Mock data for quotations
  final List<Map<String, dynamic>> _quotations = [
    {
      'id': '1',
      'title': 'Reparo de encanamento',
      'provider': 'Ana Costa',
      'description': 'Vazamento na cozinha precisa de reparo urgente',
      'estimatedValue': 150.00,
      'status': 'pending',
      'date': '2024-01-15',
    },
    {
      'id': '2',
      'title': 'Instalação elétrica',
      'provider': 'Ana Costa',
      'description': 'Preciso instalar pontos de luz na sala',
      'estimatedValue': 200.00,
      'status': 'accepted',
      'quotationValue': 220.00,
      'date': '2024-01-16',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orçamentos Recebidos',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Expanded(
            child: _quotations.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox,
                          size: isMobile ? 48 : 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: isMobile ? 16 : 24),
                        Text(
                          'Nenhum orçamento recebido',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _quotations.length,
                    itemBuilder: (context, index) {
                      final quotation = _quotations[index];
                      return _QuotationCard(
                        quotation: quotation,
                        isMobile: isMobile,
                        onAccept: () => _acceptQuotation(quotation),
                        onReject: () => _rejectQuotation(quotation),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _acceptQuotation(Map<String, dynamic> quotation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aceitar Orçamento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prestadora: ${quotation['provider']}'),
            const SizedBox(height: 8),
            Text('Serviço: ${quotation['title']}'),
            const SizedBox(height: 8),
            Text(
              'Valor do orçamento: R\$ ${quotation['quotationValue']?.toStringAsFixed(2) ?? quotation['estimatedValue'].toStringAsFixed(2)}',
            ),
            const Divider(height: 16),
            const Text(
              'Ao aceitar, o serviço será agendado.',
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
              setState(() {
                quotation['status'] = 'accepted';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Orçamento aceito! Serviço agendado.'),
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

  void _rejectQuotation(Map<String, dynamic> quotation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rejeitar Orçamento'),
        content: const Text('Tem certeza que deseja rejeitar este orçamento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _quotations.remove(quotation);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Orçamento rejeitado.'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Rejeitar'),
          ),
        ],
      ),
    );
  }
}

class _QuotationCard extends StatelessWidget {
  final Map<String, dynamic> quotation;
  final bool isMobile;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const _QuotationCard({
    required this.quotation,
    required this.isMobile,
    required this.onAccept,
    required this.onReject,
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
                    quotation['title'],
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
                    color: quotation['status'] == 'accepted'
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    quotation['status'] == 'accepted' ? 'Aceito' : 'Pendente',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 6 : 8),
            Text(
              'Prestadora: ${quotation['provider']}',
              style: TextStyle(
                fontSize: smallFontSize,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: isMobile ? 4 : 6),
            Text(
              quotation['description'],
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
                  'Valor: R\$ ${quotation['quotationValue']?.toStringAsFixed(2) ?? quotation['estimatedValue'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: smallFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            if (quotation['status'] != 'accepted') ...[
              SizedBox(height: isMobile ? 12 : 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
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
                          vertical: isMobile ? 8 : 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onReject,
                      icon: Icon(Icons.cancel, size: isMobile ? 16 : 20),
                      label: Text(
                        'Rejeitar',
                        style: TextStyle(fontSize: isMobile ? 12 : 14),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 8 : 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Responsive sizing
    final padding = isMobile ? 12.0 : 16.0;
    final spacing = isMobile ? 16.0 : 32.0;
    final avatarRadius = isMobile ? 40.0 : 50.0;
    final iconSize = isMobile ? 40.0 : 50.0;
    final nameFontSize = isMobile ? 20.0 : 24.0;
    final emailFontSize = isMobile ? 14.0 : 16.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  child: Icon(Icons.person, size: iconSize),
                ),
                SizedBox(height: spacing * 0.5),
                Text(
                  'Maria Silva',
                  style: GoogleFonts.poppins(
                    fontSize: nameFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'maria.silva@email.com',
                  style: GoogleFonts.poppins(
                    fontSize: emailFontSize,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person_rounded),
              title: Text(
                'Conta',
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
              leading: const Icon(Icons.payment),
              title: Text(
                'Métodos de Pagamento',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to payment methods
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.contacts),
              title: Text(
                'Contatos de Emergência',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to emergency contacts
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.crisis_alert),
              title: Text(
                'Botão de Pânico',
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/panic'),
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
