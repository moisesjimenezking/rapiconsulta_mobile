import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ResultBottomSheet {
  static void showCedula(BuildContext context, Map<String, dynamic> data) {
    final firstName = data['first_name']?.toString() ?? '';
    final middleName = data['middle_name']?.toString() ?? '';
    final lastName = data['last_name']?.toString() ?? '';
    final secondLastName = data['second_last_name']?.toString() ?? '';
    final fullName = [firstName, middleName, lastName, secondLastName]
        .where((e) => e.isNotEmpty)
        .join(' ');
    final dniCode = data['dni_code']?.toString() ?? '';
    final dniNumber = data['dni_number']?.toString() ?? '';
    final cedulaDisplay =
        dniCode.isNotEmpty && dniNumber.isNotEmpty ? '$dniCode$dniNumber' : '';
    final birthdate = data['birthdate'];
    final lastCompany = data['last_company_worked'];
    final maritalStatus = data['marital_status'];
    final sex = data['sex'];
    final address = data['address'];
    final phone = data['phone'];
    final email = data['email'];

    String sexText = 'No disponible';
    Color sexColor = AppColors.textMuted;
    String sexIcon = '—';
    if (sex == 'M') {
      sexText = 'Masculino';
      sexColor = const Color(0xFF3B82F6);
      sexIcon = '♂';
    } else if (sex == 'F') {
      sexText = 'Femenino';
      sexColor = const Color(0xFFEC4899);
      sexIcon = '♀';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _buildSheet(
        ctx,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(
              icon: Icons.credit_card,
              iconBg: const LinearGradient(
                colors: [AppColors.vnzBlue, AppColors.vnzBlueDark],
              ),
              label: 'Cédula Consultada',
              title: cedulaDisplay,
            ),
            const SizedBox(height: 12),
            _buildField(Icons.person, 'Nombre Completo', fullName, fullWidth: true),
            const SizedBox(height: 6),
            _buildField(Icons.cake, 'Nacimiento', birthdate),
            const SizedBox(height: 6),
            _buildField(Icons.business, 'Última Empresa (ivss)', lastCompany),
            const SizedBox(height: 6),
            _buildField(Icons.transgender, 'Sexo', '$sexIcon $sexText',
                valueColor: sexColor),
            const SizedBox(height: 6),
            _buildField(Icons.favorite, 'Estado Civil', maritalStatus),
            const SizedBox(height: 6),
            _buildField(Icons.location_on, 'Dirección', address),
            const SizedBox(height: 6),
            _buildField(Icons.phone, 'Teléfono', phone),
            const SizedBox(height: 6),
            _buildField(Icons.email, 'Email', email),
            const SizedBox(height: 16),
            _buildFooter(),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  static void showRif(BuildContext context, Map<String, dynamic> data) {
    final nombre = data['name']?.toString() ?? 'No disponible';
    final actividad = data['activity']?.toString() ?? 'No disponible';
    final rif = data['rif']?.toString() ?? '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _buildSheet(
        ctx,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(
              icon: Icons.business,
              iconBg: const LinearGradient(
                colors: [AppColors.vnzRed, Color(0xFFA01020)],
              ),
              label: 'RIF Consultado',
              title: rif,
            ),
            const SizedBox(height: 12),
            _buildField(Icons.store, 'Razón Social', nombre, fullWidth: true),
            const SizedBox(height: 6),
            _buildField(Icons.work, 'Actividad Económica', actividad,
                fullWidth: true),
            const SizedBox(height: 16),
            _buildFooter(),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  static Widget _buildSheet(BuildContext context, {required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A2332), Color(0xFF111827)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0x1AFFFFFF))),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: child,
      ),
    );
  }

  static Widget _buildHeader({
    required IconData icon,
    required Gradient iconBg,
    required String label,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: iconBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x30000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildField(
    IconData icon,
    String label,
    dynamic value, {
    bool fullWidth = false,
    Color? valueColor,
  }) {
    final text = value != null && value.toString().isNotEmpty
        ? value.toString()
        : 'No disponible';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x08FFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0x0FFFFFFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0x14FFCC00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.vnzYellow, size: 14),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? const Color(0xFFE2E8F0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0x08FFCC00),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x1AFFCC00)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.vnzYellow, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Datos obtenidos de fuentes públicas no oficiales',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
