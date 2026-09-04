import 'package:flutter/material.dart';
import 'package:mariavai_services/core/theme/app_theme.dart';

/// Widget do logo Maria Vai Com As Outras usando imagem real
/// Carrega a imagem do logo do assets
class BrandingLogoImage extends StatelessWidget {
  final double size;

  const BrandingLogoImage({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size * 0.6,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback se a imagem não existir
        return Container(
          width: size,
          height: size * 0.6,
          decoration: BoxDecoration(
            color: AppTheme.primaryPink,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction,
                  size: size * 0.3,
                  color: AppTheme.primaryBlack,
                ),
                const SizedBox(height: 8),
                Text(
                  'Logo',
                  style: TextStyle(
                    color: AppTheme.primaryBlack,
                    fontSize: size * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}