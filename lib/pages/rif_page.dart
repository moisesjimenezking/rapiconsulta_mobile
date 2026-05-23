import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/app_logo.dart';

class RifPage extends StatelessWidget {
  const RifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.vnzRed, Color(0xFFA01020)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x30CF142B),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    const Icon(Icons.business, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Consulta por RIF',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Empresas y Comercios',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Maintenance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0x12FFFFFF), Color(0x05FFFFFF)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Stack(
              children: [
                // Grayscale content
                Column(
                  children: [
                    Text(
                      'Número de RIF',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0x08FFFFFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0x1FFFFFFF)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.work,
                              color: AppColors.textMuted, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'J — 123456789',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor:
                              AppColors.vnzRed.withOpacity(0.3),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.build, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'En Mantenimiento',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          const Color(0xBF0A0F1A).withOpacity(0.75),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Robot SVG placeholder
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: const Color(0xFF475569)),
                            ),
                            child: const Center(
                              child: Icon(Icons.smart_toy,
                                  size: 40,
                                  color: Color(0xFF94A3B8)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'En Mantenimiento',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24),
                            child: Text(
                              'Estamos trabajando para mejorar este servicio. Pronto estará disponible.',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Ribbons
                Positioned(
                  top: -10,
                  left: -10,
                  child: _buildRibbon(true),
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: _buildRibbon(false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildRibbon(bool topLeft) {
    return IgnorePointer(
      child: CustomPaint(
        size: const Size(100, 100),
        painter: _RibbonPainter(topLeft: topLeft),
      ),
    );
  }
}

class _RibbonPainter extends CustomPainter {
  final bool topLeft;
  _RibbonPainter({required this.topLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: const [Color(0xFF1A1A2E), Color(0xFFE94560)],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    if (topLeft) {
      path.moveTo(0, 0);
      path.lineTo(size.width * 0.7, 0);
      path.lineTo(0, size.height * 0.7);
    } else {
      path.moveTo(size.width * 0.3, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, size.height * 0.3);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
