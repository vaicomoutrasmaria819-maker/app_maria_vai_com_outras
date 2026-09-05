import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mariavai_services/core/firebase/firestore_service.dart';
import 'package:mariavai_services/domain/entities/payment.dart';
import 'package:mariavai_services/domain/entities/panic_alert.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Maria Vai - Admin', style: TextStyle(fontSize: isMobile ? 18 : 20)),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    // Responsive sizing
    final padding = isMobile ? 12.0 : 16.0;
    final spacing = isMobile ? 16.0 : 24.0;
    final titleFontSize = isMobile ? 24.0 : 28.0;
    final subtitleFontSize = isMobile ? 18.0 : 20.0;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visão Geral',
            style: GoogleFonts.poppins(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spacing),
          if (isMobile) ...[
            _StatCard(
              title: 'Total de Usuários',
              value: '1,234',
              icon: Icons.people,
              color: Colors.blue,
              isMobile: isMobile,
            ),
            SizedBox(height: spacing * 0.67),
            _StatCard(
              title: 'Serviços Ativos',
              value: '89',
              icon: Icons.work,
              color: Colors.green,
              isMobile: isMobile,
            ),
            SizedBox(height: spacing * 0.67),
            _StatCard(
              title: 'Receita Total',
              value: 'R\$ 45.678',
              icon: Icons.account_balance_wallet,
              color: Colors.purple,
              isMobile: isMobile,
            ),
            SizedBox(height: spacing * 0.67),
            _StatCard(
              title: 'Comissões',
              value: 'R\$ 9.135',
              icon: Icons.trending_up,
              color: Colors.orange,
              isMobile: isMobile,
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total de Usuários',
                    value: '1,234',
                    icon: Icons.people,
                    color: Colors.blue,
                    isMobile: isMobile,
                  ),
                ),
                SizedBox(width: spacing * 0.67),
                Expanded(
                  child: _StatCard(
                    title: 'Serviços Ativos',
                    value: '89',
                    icon: Icons.work,
                    color: Colors.green,
                    isMobile: isMobile,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing * 0.67),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Receita Total',
                    value: 'R\$ 45.678',
                    icon: Icons.account_balance_wallet,
                    color: Colors.purple,
                    isMobile: isMobile,
                  ),
                ),
                SizedBox(width: spacing * 0.67),
                Expanded(
                  child: _StatCard(
                    title: 'Comissões',
                    value: 'R\$ 9.135',
                    icon: Icons.trending_up,
                    color: Colors.orange,
                    isMobile: isMobile,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spacing),
          Text(
            'Serviços Recentes',
            style: GoogleFonts.poppins(
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spacing * 0.67),
          Card(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: isMobile ? 20 : 24,
                    child: Icon(Icons.cleaning_services, size: isMobile ? 20 : 24),
                  ),
                  title: Text('Serviço #${1000 + index}', style: TextStyle(fontSize: isMobile ? 14 : 16)),
                  subtitle: Text('Cliente: Maria Silva | Prestador: Ana Costa', style: TextStyle(fontSize: isMobile ? 12 : 14)),
                  trailing: isMobile
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: index < 2 ? Colors.green : Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            index < 2 ? 'Concluído' : 'Em andamento',
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        )
                      : Chip(
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
  final bool isMobile;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 12.0 : 16.0;
    final iconSize = isMobile ? 24.0 : 32.0;
    final titleFontSize = isMobile ? 12.0 : 14.0;
    final valueFontSize = isMobile ? 20.0 : 24.0;
    final spacing = isMobile ? 6.0 : 8.0;
    
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: iconSize),
                SizedBox(width: spacing),
              ],
            ),
            SizedBox(height: spacing),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: titleFontSize,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: spacing * 0.5),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: valueFontSize,
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
    // MVP: Firestore desabilitado - usar dados mockados
    // final firestoreService = FirestoreService();

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
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('MVP: Dados mockados - Firebase desabilitado'),
                ],
              ),
            ),
          ),
          // MVP: StreamBuilder desabilitado
          // StreamBuilder<List<Payment>>(
          //   stream: firestoreService.getAllPayments(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }

          //     if (snapshot.hasError) {
          //       return Center(child: Text('Erro: ${snapshot.error}'));
          //     }

          //     final payments = snapshot.data ?? [];
              
          //     // Calcular totais
          //     double totalProcessed = 0;
          //     double totalCommission = 0;
          //     double totalPending = 0;

          //     for (final payment in payments) {
          //       if (payment.status == PaymentStatus.completed) {
          //         totalProcessed += payment.amount;
          //         totalCommission += payment.commissionAmount;
          //       } else if (payment.status == PaymentStatus.pending) {
          //         totalPending += payment.amount;
          //       }
          //     }

          //     return Column(
          //       children: [
          //         Card(
          //           color: Colors.green[50],
          //           child: Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 const Text(
          //                   'Resumo Financeiro',
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 const SizedBox(height: 16),
          //                 _PaymentSummaryRow(
          //                   label: 'Total Processado',
          //                   value: 'R\$ ${totalProcessed.toStringAsFixed(2)}',
          //                   color: Colors.green,
          //                 ),
          //                 _PaymentSummaryRow(
          //                   label: 'Comissões (20%)',
          //                   value: 'R\$ ${totalCommission.toStringAsFixed(2)}',
          //                   color: Colors.orange,
          //                 ),
          //                 _PaymentSummaryRow(
          //                   label: 'Valor Líquido Prestadores',
          //                   value: 'R\$ ${(totalProcessed - totalCommission).toStringAsFixed(2)}',
          //                   color: Colors.blue,
          //                 ),
          //                 const Divider(height: 32),
          //                 _PaymentSummaryRow(
          //                   label: 'Pagamentos Pendentes',
          //                   value: 'R\$ ${totalPending.toStringAsFixed(2)}',
          //                   color: Colors.red,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         const SizedBox(height: 24),
          //         Text(
          //           'Histórico de Pagamentos',
          //           style: GoogleFonts.poppins(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         const SizedBox(height: 16),
          //         Card(
          //           child: payments.isEmpty
          //               ? const Padding(
          //                   padding: EdgeInsets.all(32.0),
          //                   child: Text('Nenhum pagamento encontrado'),
          //                 )
          //               : ListView.builder(
          //                   shrinkWrap: true,
          //                   physics: const NeverScrollableScrollPhysics(),
          //                   itemCount: payments.length,
          //                   itemBuilder: (context, index) {
          //                     final payment = payments[index];
          //                     return ListTile(
          //                       leading: CircleAvatar(
          //                         backgroundColor: payment.status == PaymentStatus.completed
          //                             ? Colors.green
          //                             : Colors.orange,
          //                         child: Icon(
          //                           payment.status == PaymentStatus.completed
          //                               ? Icons.check
          //                               : Icons.pending,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                       title: Text('Pagamento #${payment.id.substring(0, 8)}'),
          //                       subtitle: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Text('Serviço ID: ${payment.serviceId}'),
          //                           Text('Data: ${payment.createdAt.toLocal().toString().split('.')[0]}'),
          //                         ],
          //                       ),
          //                       trailing: Column(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         crossAxisAlignment: CrossAxisAlignment.end,
          //                         children: [
          //                           Text(
          //                             'R\$ ${payment.amount.toStringAsFixed(2)}',
          //                             style: GoogleFonts.poppins(
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                           ),
          //                           Text(
          //                             'Comissão: R\$ ${payment.commissionAmount.toStringAsFixed(2)}',
          //                             style: GoogleFonts.poppins(
          //                               fontSize: 12,
          //                               color: Colors.grey[600],
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     );
          //                   },
          //                 ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    // Responsive sizing
    final padding = isMobile ? 12.0 : 16.0;
    final cardMargin = isMobile ? 8.0 : 12.0;
    final avatarRadius = isMobile ? 20.0 : 24.0;
    final titleFontSize = isMobile ? 14.0 : 16.0;
    final subtitleFontSize = isMobile ? 12.0 : 14.0;
    
    return ListView.builder(
      padding: EdgeInsets.all(padding),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: cardMargin),
          child: ListTile(
            leading: CircleAvatar(
              radius: avatarRadius,
              child: Icon(Icons.person, size: isMobile ? 20 : 24),
            ),
            title: Text('$userType ${index + 1}', style: TextStyle(fontSize: titleFontSize)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: user${index + 1}@email.com', style: TextStyle(fontSize: subtitleFontSize)),
                Text('Telefone: (11) 99999-${1000 + index}', style: TextStyle(fontSize: subtitleFontSize)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: isMobile ? 20 : 24),
                  onPressed: () {
                    // TODO: Edit user
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: isMobile ? 20 : 24),
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
    // MVP: Firestore desabilitado
    // final firestoreService = FirestoreService();

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
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('MVP: Dados mockados - Firebase desabilitado'),
                ],
              ),
            ),
          ),
          // MVP: StreamBuilder desabilitado
          // StreamBuilder<List<PanicAlert>>(
          //   stream: firestoreService.getPanicAlerts(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     }

          //     if (snapshot.hasError) {
          //       return Center(child: Text('Erro: ${snapshot.error}'));
          //     }

          //     final alerts = snapshot.data ?? [];
          //     final activeAlerts = alerts.where((alert) => 
          //       alert.status == PanicStatus.triggered || 
          //       alert.status == PanicStatus.acknowledged
          //     ).toList();

          //     return Column(
          //       children: [
          //         Card(
          //           color: Colors.red[50],
          //           child: Padding(
          //             padding: const EdgeInsets.all(16.0),
          //             child: Row(
          //               children: [
          //                 const Icon(Icons.warning, color: Colors.red, size: 32),
          //                 const SizedBox(width: 16),
          //                 Expanded(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         'Alertas Ativos',
          //                         style: GoogleFonts.poppins(
          //                           fontSize: 18,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                       const SizedBox(height: 4),
          //                       Text('${activeAlerts.length} alertas precisam de atenção'),
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   padding: const EdgeInsets.all(12),
          //                   decoration: BoxDecoration(
          //                     color: Colors.red,
          //                     borderRadius: BorderRadius.circular(8),
          //                   ),
          //                   child: Text(
          //                     '${activeAlerts.length}',
          //                     style: const TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 24,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         const SizedBox(height: 24),
          //         Text(
          //           'Histórico de Alertas',
          //           style: GoogleFonts.poppins(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         const SizedBox(height: 16),
          //         Card(
          //           child: alerts.isEmpty
          //               ? const Padding(
          //                   padding: EdgeInsets.all(32.0),
          //                   child: Text('Nenhum alerta encontrado'),
          //                 )
          //               : ListView.builder(
          //                   shrinkWrap: true,
          //                   physics: const NeverScrollableScrollPhysics(),
          //                   itemCount: alerts.length,
          //                   itemBuilder: (context, index) {
          //                     final alert = alerts[index];
          //                     final statusColor = _getStatusColor(alert.status);
          //                     final statusIcon = _getStatusIcon(alert.status);
          //                     final statusText = _getStatusText(alert.status);

          //                     return ListTile(
          //                       leading: CircleAvatar(
          //                         backgroundColor: statusColor,
          //                         child: Icon(
          //                           statusIcon,
          //                           color: Colors.white,
          //                         ),
          //                       ),
          //                       title: Text('Alerta #${alert.id.substring(0, 8)}'),
          //                       subtitle: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Text('Usuário ID: ${alert.userId}'),
          //                           if (alert.address != null) 
          //                             Text('Localização: ${alert.address}'),
          //                           if (alert.latitude != null && alert.longitude != null)
          //                             Text('GPS: ${alert.latitude!.toStringAsFixed(6)}, ${alert.longitude!.toStringAsFixed(6)}'),
          //                           Text('Horário: ${alert.triggeredAt.toLocal().toString().split('.')[0]}'),
          //                         ],
          //                       ),
          //                       trailing: Chip(
          //                         label: Text(statusText),
          //                         backgroundColor: statusColor,
          //                         labelStyle: const TextStyle(color: Colors.white),
          //                       ),
          //                     );
          //                   },
          //                 ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Color _getStatusColor(PanicStatus status) {
    switch (status) {
      case PanicStatus.triggered:
        return Colors.red;
      case PanicStatus.acknowledged:
        return Colors.orange;
      case PanicStatus.resolved:
        return Colors.green;
      case PanicStatus.falseAlarm:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(PanicStatus status) {
    switch (status) {
      case PanicStatus.triggered:
        return Icons.warning;
      case PanicStatus.acknowledged:
        return Icons.access_time;
      case PanicStatus.resolved:
        return Icons.check;
      case PanicStatus.falseAlarm:
        return Icons.close;
    }
  }

  String _getStatusText(PanicStatus status) {
    switch (status) {
      case PanicStatus.triggered:
        return 'Acionado';
      case PanicStatus.acknowledged:
        return 'Reconhecido';
      case PanicStatus.resolved:
        return 'Resolvido';
      case PanicStatus.falseAlarm:
        return 'Falso Alarme';
    }
  }
}