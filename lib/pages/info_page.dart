import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../widgets/app_logo.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

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
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x303B82F6),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.info_outline,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '¿Cómo funciona?',
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

          // Info items
          _buildInfoItem(
            icon: Icons.storage,
            title: 'Datos Públicos',
            description:
                'Accedemos a información disponible en las fuentes. Todos los datos mostrados son de carácter público.',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            icon: Icons.shield_outlined,
            title: 'Sin Almacenamiento',
            description:
                'No guardamos tus consultas. Cada búsqueda se realiza en tiempo real contra las fuentes.',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            icon: Icons.bolt,
            title: 'Resultados Inmediatos',
            description:
                'Respuesta en segundos. Si el dato está disponible en las fuentes, lo encontrarás aquí.',
          ),
          const SizedBox(height: 24),

          // Disclaimer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0x0FFFCC00),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0x1FFFCC00)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.warning_amber_rounded,
                    color: AppColors.vnzYellow, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Aviso: Este portal consulta información pública disponible en fuentes no oficiales venezolanas. No somos un ente gubernamental. Los resultados dependen de la disponibilidad en las fuentes consultadas.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Footer
          Center(
            child: Column(
              children: [
                const AppLogo(size: 48, borderRadius: 12),
                const SizedBox(height: 10),
                Text(
                  'RapiConsultas',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '© 2025 RapiConsultas — MJ Tech.\nTodos los derechos reservados.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialBtn(
                      Icons.email,
                      () => _launchEmail('jimenezsmoises27@gmail.com'),
                      const Color(0xFFEA4335),
                    ),
                    const SizedBox(width: 12),
                    _buildSocialBtn(
                      Icons.chat,
                      () => _launchWhatsApp('+584127689737'),
                      const Color(0xFF25D366),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0x1AFFCC00),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Icon(icon, color: AppColors.vnzYellow, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(IconData icon, VoidCallback onTap, Color hoverColor) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0x0DFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0x14FFFFFF)),
        ),
        child: Icon(icon, color: hoverColor, size: 22),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final uri = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
