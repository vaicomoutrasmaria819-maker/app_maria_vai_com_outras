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
    const ProviderEarningsPage(),
    const ProviderProfilePage(),
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
class ProviderEarningsPage extends StatelessWidget {
  const ProviderEarningsPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Tela de Ganhos'));
}

class ProviderProfilePage extends StatelessWidget {
  const ProviderProfilePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('Tela de Perfil'));
}
