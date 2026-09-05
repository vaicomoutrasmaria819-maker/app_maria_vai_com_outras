import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariavai_services/domain/entities/rating.dart';

import '../../../core/theme/app_theme.dart';

class RatingsPage extends StatefulWidget {
  final String? providerId;
  final String? providerName;
  final bool isAdminView;
  final bool isClientView; // Se true, mostra avaliações do próprio cliente
  final String? clientId; // ID do cliente para suas próprias avaliações

  const RatingsPage({
    super.key,
    this.providerId,
    this.providerName,
    this.isAdminView = false,
    this.isClientView = false,
    this.clientId,
  });

  @override
  State<RatingsPage> createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  // Mock data for provider ratings (avaliações que clientes deram ao prestador)
  final List<Rating> _providerRatings = [
    Rating(
      id: '1',
      serviceId: 'service_1',
      clientId: 'client_1',
      clientName: 'Maria Silva',
      providerId: 'provider_1',
      providerName: 'Ana Costa',
      rating: 5.0,
      comment: 'Excelente trabalho! Muito profissional e pontual.',
      categories: ['Profissionalismo', 'Qualidade', 'Pontualidade'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      status: RatingStatus.completed,
      response: 'Obrigada pelo feedback! Foi um prazer ajudar.',
    ),
    Rating(
      id: '2',
      serviceId: 'service_2',
      clientId: 'client_2',
      clientName: 'Julia Santos',
      providerId: 'provider_1',
      providerName: 'Ana Costa',
      rating: 4.5,
      comment: 'Bom trabalho, mas poderia ter sido mais rápido.',
      categories: ['Qualidade', 'Pontualidade'],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      status: RatingStatus.completed,
    ),
    Rating(
      id: '3',
      serviceId: 'service_3',
      clientId: 'client_3',
      clientName: 'Carla Oliveira',
      providerId: 'provider_1',
      providerName: 'Ana Costa',
      rating: 4.0,
      comment: 'Trabalho satisfatório, preço justo.',
      categories: ['Profissionalismo', 'Preço'],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      status: RatingStatus.completed,
    ),
    Rating(
      id: '4',
      serviceId: 'service_4',
      clientId: 'client_4',
      clientName: 'Fernanda Lima',
      providerId: 'provider_1',
      providerName: 'Ana Costa',
      rating: 5.0,
      comment: 'Perfeita! Recomendo fortemente.',
      categories: ['Profissionalismo', 'Qualidade', 'Pontualidade', 'Preço'],
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      status: RatingStatus.completed,
    ),
  ];

  // Mock data for client ratings (avaliações que o cliente deu aos serviços)
  final List<Rating> _clientRatings = [
    Rating(
      id: '5',
      serviceId: 'service_5',
      clientId: 'client_1',
      clientName: 'Maria Silva',
      providerId: 'provider_2',
      providerName: 'Beatriz Santos',
      rating: 4.0,
      comment: 'Pintura ficou muito bonita, no prazo combinado.',
      categories: ['Qualidade', 'Pontualidade'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      status: RatingStatus.completed,
    ),
    Rating(
      id: '6',
      serviceId: 'service_6',
      clientId: 'client_1',
      clientName: 'Maria Silva',
      providerId: 'provider_3',
      providerName: 'Cláudia Rodrigues',
      rating: 5.0,
      comment: 'Excelente serviço de limpeza pós-obra!',
      categories: ['Profissionalismo', 'Qualidade'],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      status: RatingStatus.completed,
    ),
  ];

  List<Rating> get _ratings {
    if (widget.isClientView) {
      return _clientRatings;
    } else {
      return _providerRatings;
    }
  }

  double get _averageRating {
    if (_ratings.isEmpty) return 0.0;
    final sum = _ratings.fold<double>(
      0.0,
      (sum, rating) => sum + rating.rating,
    );
    return sum / _ratings.length;
  }

  int get _totalRatings => _ratings.length;

  Map<String, int> get _ratingDistribution {
    final distribution = <String, int>{'5': 0, '4': 0, '3': 0, '2': 0, '1': 0};
    for (final rating in _ratings) {
      final stars = rating.rating.round().toString();
      distribution[stars] = (distribution[stars] ?? 0) + 1;
    }
    return distribution;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF0BFC5),
      appBar: AppBar(
        title: Text(
          widget.isAdminView ? 'Avaliações do Sistema' : 'Avaliações',
          style: TextStyle(fontSize: isMobile ? 18 : 20),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RatingSummaryCard(
                averageRating: _averageRating,
                totalRatings: _totalRatings,
                ratingDistribution: _ratingDistribution,
                providerName: widget.providerName ?? 'Prestadora',
                isMobile: isMobile,
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Text(
                'Histórico de Avaliações',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              ..._ratings.map(
                (rating) => _RatingCard(
                  rating: rating,
                  isMobile: isMobile,
                  canRespond: !widget.isAdminView,
                  onResponse: (response) =>
                      _respondToRating(rating.id, response),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _respondToRating(String ratingId, String response) {
    setState(() {
      final index = _ratings.indexWhere((r) => r.id == ratingId);
      if (index != -1) {
        _ratings[index] = _ratings[index].copyWith(response: response);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resposta enviada com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _RatingSummaryCard extends StatelessWidget {
  final double averageRating;
  final int totalRatings;
  final Map<String, int> ratingDistribution;
  final String providerName;
  final bool isMobile;

  const _RatingSummaryCard({
    required this.averageRating,
    required this.totalRatings,
    required this.ratingDistribution,
    required this.providerName,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              providerName,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.primaryWhite
                    : const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Row(
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 36 : 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.primaryWhite
                        : const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < averageRating.round()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: isMobile ? 16 : 20,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 4 : 8),
                    Text(
                      '$totalRatings avaliações',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.primaryWhite
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: isMobile ? 16 : 24),
            ...ratingDistribution.entries.map((entry) {
              final stars = int.parse(entry.key);
              final count = entry.value;
              final percentage = totalRatings > 0
                  ? (count / totalRatings) * 100
                  : 0.0;

              return Padding(
                padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
                child: Row(
                  children: [
                    Text(
                      '$stars estrelas',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.primaryWhite
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          stars >= 4
                              ? Colors.green
                              : stars >= 3
                              ? Colors.amber
                              : Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Text(
                      '$count ($percentage%)',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.primaryWhite
                            : const Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _RatingCard extends StatefulWidget {
  final Rating rating;
  final bool isMobile;
  final bool canRespond;
  final Function(String) onResponse;

  const _RatingCard({
    required this.rating,
    required this.isMobile,
    this.canRespond = false,
    required this.onResponse,
  });

  @override
  State<_RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<_RatingCard> {
  bool _isExpanded = false;
  final _responseController = TextEditingController();

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: widget.isMobile ? 12 : 16),
      child: Padding(
        padding: EdgeInsets.all(widget.isMobile ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: widget.isMobile ? 16 : 20,
                        backgroundColor: const Color(0xFFF0BFC5),
                        child: Icon(
                          Icons.person,
                          size: widget.isMobile ? 16 : 20,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.primaryWhite
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(width: widget.isMobile ? 8 : 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.rating.clientName,
                              style: TextStyle(
                                fontSize: widget.isMobile ? 14 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              _formatDate(widget.rating.createdAt),
                              style: TextStyle(
                                fontSize: widget.isMobile ? 10 : 12,
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppTheme.primaryWhite
                                    : const Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < widget.rating.rating.round()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: widget.isMobile ? 16 : 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.isMobile ? 8 : 12),
            Wrap(
              spacing: widget.isMobile ? 4 : 8,
              runSpacing: widget.isMobile ? 4 : 8,
              children:
                  widget.rating.categories
                      ?.map(
                        (category) => Chip(
                          label: Text(
                            category,
                            style: TextStyle(
                              fontSize: widget.isMobile ? 10 : 12,
                            ),
                          ),
                          backgroundColor: const Color(0xFFF0BFC5),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: widget.isMobile ? 10 : 12,
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            SizedBox(height: widget.isMobile ? 8 : 12),
            if (widget.rating.comment != null) ...[
              Text(
                widget.rating.comment!,
                style: TextStyle(
                  fontSize: widget.isMobile ? 12 : 14,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.primaryWhite
                      : const Color(0xFF1A1A1A),
                ),
                maxLines: _isExpanded ? null : 2,
                overflow: _isExpanded ? null : TextOverflow.ellipsis,
              ),
              GestureDetector(
                onTap: () => setState(() => _isExpanded = !_isExpanded),
                child: Text(
                  _isExpanded ? 'Mostrar menos' : 'Mostrar mais',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.primaryWhite
                        : const Color(0xFF1A1A1A),
                    fontSize: widget.isMobile ? 12 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            if (widget.rating.response != null) ...[
              SizedBox(height: widget.isMobile ? 12 : 16),
              Container(
                padding: EdgeInsets.all(widget.isMobile ? 8 : 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.reply,
                          size: widget.isMobile ? 14 : 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.primaryWhite
                              : const Color(0xFF1A1A1A),
                        ),
                        SizedBox(width: widget.isMobile ? 4 : 8),
                        Expanded(
                          child: Text(
                            'Resposta da prestadora',
                            style: TextStyle(
                              fontSize: widget.isMobile ? 12 : 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.isMobile ? 4 : 8),
                    Text(
                      widget.rating.response!,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 12 : 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.canRespond && widget.rating.response == null) ...[
              SizedBox(height: widget.isMobile ? 12 : 16),
              ElevatedButton.icon(
                onPressed: () => _showResponseDialog(context),
                icon: Icon(
                  Icons.reply,
                  size: widget.isMobile ? 16 : 20,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1A1A1A)
                      : AppTheme.primaryWhite,
                ),
                label: Text(
                  'Responder',
                  style: TextStyle(
                    fontSize: widget.isMobile ? 12 : 14,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1A1A1A)
                        : AppTheme.primaryWhite,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.primaryWhite
                      : const Color(0xFF1A1A1A),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showResponseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Responder Avaliação'),
        content: TextField(
          controller: _responseController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Escreva sua resposta...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_responseController.text.isNotEmpty) {
                widget.onResponse(_responseController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
