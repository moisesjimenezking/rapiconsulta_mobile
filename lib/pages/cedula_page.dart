import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../services/api_service.dart';
import '../widgets/result_bottom_sheet.dart';

class CedulaPage extends StatefulWidget {
  const CedulaPage({super.key});

  @override
  State<CedulaPage> createState() => _CedulaPageState();
}

class _CedulaPageState extends State<CedulaPage> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  String _prefix = 'V';
  bool _loading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _cedulaController.dispose();
    super.dispose();
  }

  Future<void> _consult() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final response = await ApiService.consultDni(
          _prefix.toLowerCase(), _cedulaController.text.trim());
      if (!mounted) return;
      ResultBottomSheet.showCedula(context, response['data']);
      _cedulaController.clear();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

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
                    colors: [AppColors.vnzBlue, AppColors.vnzBlueDark],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x30003DA5),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.credit_card,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Consulta por Cédula',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Personas Naturales',
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

          // Form Card
          Container(
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Número de Cédula',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Custom input: icon + prefix selector + text field
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x0DFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0x1FFFFFFF)),
                    ),
                    child: Row(
                      children: [
                        // Person icon
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Icon(Icons.person,
                              color: AppColors.textMuted, size: 20),
                        ),
                        // Prefix selector (V/E)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: const Color(0x0FFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _prefix,
                              dropdownColor: const Color(0xFF1A2332),
                              style: GoogleFonts.inter(
                                color: AppColors.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              items: ['V', 'E']
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (v) =>
                                  setState(() => _prefix = v!),
                            ),
                          ),
                        ),
                        // Text field
                        Expanded(
                          child: TextFormField(
                            controller: _cedulaController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Ej: 12345678',
                              hintStyle: TextStyle(
                                  color: AppColors.textMuted, fontSize: 15),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Ingresa un número de cédula';
                              }
                              return null;
                            },
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
                      onPressed: _loading ? null : _consult,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.vnzBlue,
                        disabledBackgroundColor:
                            AppColors.vnzBlue.withOpacity(0.5),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: const Color(0x40003DA5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.search, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Buscar Cédula',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0x1FCF142B),
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: const Color(0x40CF142B)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.error_outline,
                              color: Color(0xFFF87171), size: 18),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 4),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Color(0xFFF87171),
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
