import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariavai_services/core/theme/app_theme.dart';

class CreateRatingPage extends StatefulWidget {
  final String serviceId;
  final String providerId;
  final String providerName;
  final String serviceTitle;

  const CreateRatingPage({
    super.key,
    required this.serviceId,
    required this.providerId,
    required this.providerName,
    required this.serviceTitle,
  });

  @override
  State<CreateRatingPage> createState() => _CreateRatingPageState();
}

class _CreateRatingPageState extends State<CreateRatingPage> {
  double _rating = 0.0;
  final _commentController = TextEditingController();
  final List<String> _selectedCategories = [];

  final List<String> _availableCategories = [
    'Profissionalismo',
    'Qualidade',
    'Pontualidade',
    'Preço',
    'Comunicação',
    'Limpeza',
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppTheme.primaryPink,
      appBar: AppBar(
        title: Text(
          'Avaliar Serviço',
          style: TextStyle(fontSize: isMobile ? 18 : 20),
        ),
        backgroundColor: AppTheme.primaryWhite,
        foregroundColor: AppTheme.primaryBlack,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serviço: ${widget.serviceTitle}',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Text(
                        'Prestadora: ${widget.providerName}',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Como você avalia este serviço?',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _rating.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: isMobile ? 32 : 48,
                            ),
                            onPressed: () => setState(() => _rating = (index + 1).toDouble()),
                          );
                        }),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Text(
                        _rating > 0 ? '${_rating.toStringAsFixed(1)} estrelas' : 'Selecione uma avaliação',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'O que você gostou?',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      Wrap(
                        spacing: isMobile ? 8 : 12,
                        runSpacing: isMobile ? 8 : 12,
                        children: _availableCategories.map((category) {
                          final isSelected = _selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(
                              category,
                              style: TextStyle(fontSize: isMobile ? 12 : 14),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategories.add(category);
                                } else {
                                  _selectedCategories.remove(category);
                                }
                              });
                            },
                            selectedColor: AppTheme.primaryPink,
                            checkmarkColor: AppTheme.primaryBlack,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comentário (opcional)',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      TextField(
                        controller: _commentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Conte sua experiência...',
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(isMobile ? 12 : 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 24 : 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _rating > 0 ? _submitRating : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 20),
                    backgroundColor: AppTheme.primaryBlack,
                    foregroundColor: AppTheme.primaryWhite,
                  ),
                  child: Text(
                    'Enviar Avaliação',
                    style: TextStyle(fontSize: isMobile ? 16 : 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRating() {
    // Here you would save the rating to your backend
    // For now, just show a success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Avaliação enviada com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }
}