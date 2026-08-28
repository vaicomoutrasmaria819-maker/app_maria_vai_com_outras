import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminOverviewPage(),
    const AdminPaymentsPage(),
    const AdminUsersPage(),
    const AdminPanicAlertsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maria Vai - Admin'),
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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Visão Geral',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Pagamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Usuários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Alertas',
          ),
        ],
      ),
    );
  }
}

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visão Geral',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total de Usuários',
                  value: '1,234',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'Serviços Ativos',
                  value: '89',
                  icon: Icons.work,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Receita Total',
                  value: 'R\$ 45.678',
                  icon: Icons.account_balance_wallet,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'Comissões',
                  value: 'R\$ 9.135',
                  icon: Icons.trending_up,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Serviços Recentes',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.cleaning_services),
                  ),
                  title: Text('Serviço #${1000 + index}'),
                  subtitle: Text('Cliente: Maria Silva | Prestador: Ana Costa'),
                  trailing: Chip(
                    label: Text(index < 2 ? 'Concluído' : 'Em andamento'),
                    backgroundColor: index < 2 ? Colors.green : Colors.blue,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminPaymentsPage extends StatelessWidget {
  const AdminPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pagamentos Processados',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resumo Financeiro',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PaymentSummaryRow(
                    label: 'Total Processado',
                    value: 'R\$ 45.678,00',
                    color: Colors.green,
                  ),
                  _PaymentSummaryRow(
                    label: 'Comissões (20%)',
                    value: 'R\$ 9.135,60',
                    color: Colors.orange,
                  ),
                  _PaymentSummaryRow(
                    label: 'Valor Líquido Prestadores',
                    value: 'R\$ 36.542,40',
                    color: Colors.blue,
                  ),
                  const Divider(height: 32),
                  _PaymentSummaryRow(
                    label: 'Pagamentos Pendentes',
                    value: 'R\$ 2.340,00',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Histórico de Pagamentos',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                final payment = _getPaymentData(index);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: payment['status'] == 'completed'
                        ? Colors.green
                        : Colors.orange,
                    child: Icon(
                      payment['status'] == 'completed'
                          ? Icons.check
                          : Icons.pending,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Pagamento #${1000 + index}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Serviço: ${payment['service']}'),
                      Text('Prestador: ${payment['provider']}'),
                      Text('Data: ${payment['date']}'),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        payment['amount'] ?? 'R\$ 0,00',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Comissão: ${payment['commission'] ?? 'R\$ 0,00'}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> _getPaymentData(int index) {
    final services = ['Limpeza', 'Cuidados', 'Alimentação', 'Beleza', 'Saúde'];
    final providers = ['Ana Costa', 'Maria Santos', 'Joana Silva', 'Carla Oliveira'];
    final dates = ['28/08/2026', '27/08/2026', '26/08/2026', '25/08/2026'];
    
    return {
      'service': services[index % services.length],
      'provider': providers[index % providers.length],
      'date': dates[index % dates.length],
      'amount': 'R\$ ${(150 + index * 10).toStringAsFixed(2)}',
      'commission': 'R\$ ${((150 + index * 10) * 0.2).toStringAsFixed(2)}',
      'status': index < 7 ? 'completed' : 'pending',
    };
  }
}

class _PaymentSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _PaymentSummaryRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Clientes'),
              Tab(text: 'Prestadores'),
              Tab(text: 'Administradores'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _UsersList(userType: 'Cliente'),
                _UsersList(userType: 'Prestador'),
                _UsersList(userType: 'Administrador'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  final String userType;

  const _UsersList({required this.userType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('$userType ${index + 1}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: user${index + 1}@email.com'),
                Text('Telefone: (11) 99999-${1000 + index}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Edit user
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // TODO: Delete user
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AdminPanicAlertsPage extends StatelessWidget {
  const AdminPanicAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alertas de Pânico',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.red[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alertas Ativos',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('2 alertas precisam de atenção'),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Histórico de Alertas',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final alert = _getAlertData(index);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: alert['statusColor'],
                    child: Icon(
                      alert['statusIcon'],
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Alerta #${1000 + index}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Usuário: ${alert['user']}'),
                      Text('Localização: ${alert['location']}'),
                      Text('Horário: ${alert['time']}'),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(alert['status']),
                    backgroundColor: alert['statusColor'],
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getAlertData(int index) {
    final users = ['Maria Silva', 'Ana Costa', 'Joana Santos', 'Carla Oliveira'];
    final locations = [
      'Rua das Flores, 123',
      'Av. Brasil, 456',
      'Praça Central, 789',
      'Rua do Sol, 321'
    ];
    final times = ['14:30', '12:15', '10:45', '09:20'];
    
    final statuses = ['Resolvido', 'Resolvido', 'Ativo', 'Ativo', 'Resolvido'];
    final status = statuses[index % statuses.length];
    
    return {
      'user': users[index % users.length],
      'location': locations[index % locations.length],
      'time': times[index % times.length],
      'status': status,
      'statusColor': status == 'Ativo' ? Colors.red : Colors.green,
      'statusIcon': status == 'Ativo' ? Icons.warning : Icons.check,
    };
  }
}