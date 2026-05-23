import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class HomePage extends StatelessWidget {
  final Function(int) onNavigate;

  const HomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
        children: [
          // Hero
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFCC00),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color(0x33FFCC00),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.flag, color: AppColors.vnzYellow, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'Portal Privado',
                        style: TextStyle(
                          color: AppColors.vnzYellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Color(0xFFCBD5E1)],
                  ).createShader(bounds),
                  child: Text(
                    'Consulta tu Cédula o RIF',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Accede a información pública de identificación personal y empresarial de Venezuela de forma rápida y segura.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Cards
          _buildNavCard(
            icon: Icons.credit_card,
            iconGradient: const LinearGradient(
              colors: [AppColors.vnzBlue, AppColors.vnzBlueDark],
            ),
            title: 'Consulta por Cédula',
            subtitle:
                'Busca información pública asociada a un número de cédula de identidad venezolana.',
            onTap: () => onNavigate(1),
          ),
          const SizedBox(height: 12),
          _buildNavCard(
            icon: Icons.business,
            iconGradient: const LinearGradient(
              colors: [AppColors.vnzRed, Color(0xFFA01020)],
            ),
            title: 'Consulta por RIF',
            subtitle:
                'Obtén información fiscal y empresarial del Registro de Información Fiscal (RIF).',
            onTap: () => onNavigate(2),
          ),
          const SizedBox(height: 28),

          // Features
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeature(Icons.credit_card, 'Cédula', 'V.E'),
                _buildFeature(Icons.business, 'RIF', 'Empresas'),
                _buildFeature(Icons.bolt, 'Instantáneo', 'Segundos'),
              ],
            ),
          ),
          const Divider(color: AppColors.glassBorder),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildNavCard({
    required IconData icon,
    required Gradient iconGradient,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x12FFFFFF), Color(0x05FFFFFF)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.glassBorder),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: iconGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: AppColors.textMuted, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String label, String desc) {
    return Column(
      children: [
        Icon(icon, color: AppColors.vnzYellow, size: 24),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          desc,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
