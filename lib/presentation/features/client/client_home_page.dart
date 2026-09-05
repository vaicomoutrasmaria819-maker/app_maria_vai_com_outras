import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
    const ClientProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Maria Vai - Cliente', style: TextStyle(fontSize: isMobile ? 18 : 20)),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Meus Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewServiceDialog(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text('Novo Serviço', style: TextStyle(fontSize: isMobile ? 12 : 14)),
      ),
    );
  }

  void _showNewServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Solicitar Novo Serviço'),
        content: const Text('Funcionalidade de criação de serviço será implementada.'),
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
    final spacing = isMobile ? 12.0 : 16.0;
    final titleFontSize = isMobile ? 20.0 : 24.0;
    
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorias de Serviços',
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap ?? () {
          // TODO: Navigate to service providers
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: color,
              ),
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
                      child: Icon(Icons.cleaning_services, size: isMobile ? 20 : 24),
                    ),
                    title: Text('Serviço #${index + 1}', style: TextStyle(fontSize: isMobile ? 14 : 16)),
                    subtitle: Text('Status: ${_getStatus(index)}', style: TextStyle(fontSize: isMobile ? 12 : 14)),
                    trailing: const Icon(Icons.chevron_right),
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
              leading: const Icon(Icons.settings),
              title: Text('Configurações', style: TextStyle(fontSize: isMobile ? 14 : 16)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.payment),
              title: Text('Métodos de Pagamento', style: TextStyle(fontSize: isMobile ? 14 : 16)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to payment methods
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.contacts),
              title: Text('Contatos de Emergência', style: TextStyle(fontSize: isMobile ? 14 : 16)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to emergency contacts
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text('Sair', style: TextStyle(color: Colors.red, fontSize: isMobile ? 14 : 16)),
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