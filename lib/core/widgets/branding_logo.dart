import 'package:flutter/material.dart';
import 'package:mariavai_services/core/theme/app_theme.dart';

/// Widget do logo Maria Vai Com As Outras
/// Representa as silhuetas das mulheres trabalhadoras com ferramentas
class BrandingLogo extends StatelessWidget {
  final double size;

  const BrandingLogo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.5,
      child: CustomPaint(
        painter: _LogoPainter(),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryBlack
      ..style = PaintingStyle.fill;

    // Desenhar 5 silhuetas de mulheres trabalhadoras
    // Cada uma com uma ferramenta diferente
    _drawWomanWithTool(canvas, size, 0.1, Icons.format_paint); // Rolo de tinta
    _drawWomanWithTool(canvas, size, 0.3, Icons.work); // Maleta/briefcase
    _drawWomanWithTool(canvas, size, 0.5, Icons.build); // Chave inglesa
    _drawWomanWithTool(canvas, size, 0.7, Icons.handyman); // Martelo
    _drawWomanWithTool(canvas, size, 0.9, Icons.construction); // Capacete/ferramentas
  }

  void _drawWomanWithTool(Canvas canvas, Size size, double xRatio, IconData toolIcon) {
    final centerX = size.width * xRatio;
    final centerY = size.height * 0.5;
    final scale = size.width * 0.08;

    // Corpo da mulher (silhueta)
    final bodyPaint = Paint()
      ..color = AppTheme.primaryBlack
      ..style = PaintingStyle.fill;

    // Cabeça
    canvas.drawCircle(
      Offset(centerX, centerY - scale * 2),
      scale * 0.4,
      bodyPaint,
    );

    // Capacete
    final helmetPaint = Paint()
      ..color = AppTheme.primaryBlack
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY - scale * 2.3),
          width: scale * 0.9,
          height: scale * 0.4,
        ),
        const Radius.circular(2),
      ),
      helmetPaint,
    );

    // Corpo (tronco)
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: scale * 0.6,
        height: scale * 1.2,
      ),
      bodyPaint,
    );

    // Pernas
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX - scale * 0.15, centerY + scale * 0.9),
        width: scale * 0.2,
        height: scale * 0.8,
      ),
      bodyPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX + scale * 0.15, centerY + scale * 0.9),
        width: scale * 0.2,
        height: scale * 0.8,
      ),
      bodyPaint,
    );

    // Braços segurando ferramenta
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX - scale * 0.3, centerY - scale * 0.3),
        width: scale * 0.15,
        height: scale * 0.6,
      ),
      bodyPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX + scale * 0.3, centerY - scale * 0.3),
        width: scale * 0.15,
        height: scale * 0.6,
      ),
      bodyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}