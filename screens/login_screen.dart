import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'main_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hero background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAFWF5S7k0RPc3pe3xnB05KjwHpeowgZcMxoo1qqZmdSmRqBxMKnI3zt5GOLH6ebgQxd7KsFkj_7zMlYjxBhGb5rFTXdlBDn5a3kFHetkcxhq87hVk0wvqrqG8leUQmdmupfwzpF8Jrioqr9-799fbUakHT3lMIb8tVnNoNZJc0ai6andUfx6IFZ3PFUg9ySijht-Vh8epos86HGaFUBbJB3fs0-CeecqvCmiAh5Wx8nlrEbvMd0a72rkn5WK9SafsESEEW-Z59ih7j',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Color(0x66000109), BlendMode.darken),
              ),
            ),
          ),
          // Location badge bottom-right
          
          // Auth card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000109).withValues(alpha: 0.2),
                      blurRadius: 50,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
                      child: Column(
                        children: [
                          Text(
                            'Traveloop',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 32, fontWeight: FontWeight.w800,
                              color: TraveloopColors.primary, letterSpacing: -0.64,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'The Expert Guide to your next adventure.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16, color: TraveloopColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isLogin = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: _isLogin ? TraveloopColors.secondary : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _isLogin ? TraveloopColors.secondary : TraveloopColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isLogin = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: !_isLogin ? TraveloopColors.secondary : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: !_isLogin ? TraveloopColors.secondary : TraveloopColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Form
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_isLogin) ...[
                            _label('Full Name'),
                            const SizedBox(height: 6),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Alex Walker',
                                prefixIcon: const Icon(Icons.person_outline, color: TraveloopColors.onSurfaceVariant),
                                hintStyle: GoogleFonts.plusJakartaSans(color: TraveloopColors.outlineVariant),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          _label('Email Address'),
                          const SizedBox(height: 6),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'alex@example.com',
                              prefixIcon: const Icon(Icons.mail_outline, color: TraveloopColors.onSurfaceVariant),
                              hintStyle: GoogleFonts.plusJakartaSans(color: TraveloopColors.outlineVariant),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _label('Password'),
                              if (_isLogin)
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text('Forgot Password?', style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w600,
                                    color: TraveloopColors.secondary, letterSpacing: 0.48,
                                  )),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              prefixIcon: const Icon(Icons.lock_outline, color: TraveloopColors.onSurfaceVariant),
                              hintStyle: GoogleFonts.plusJakartaSans(color: TraveloopColors.outlineVariant),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: TraveloopColors.onSurfaceVariant,
                                ),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Primary CTA
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => const MainScaffold()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TraveloopColors.secondary,
                                foregroundColor: TraveloopColors.onSecondary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 4,
                                textStyle: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              child: Text(_isLogin ? 'Login' : 'Create Account'),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider(color: TraveloopColors.outlineVariant)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text('OR CONTINUE WITH', style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10, fontWeight: FontWeight.w700, color: TraveloopColors.onSurfaceVariant, letterSpacing: 0.5,
                                )),
                              ),
                              const Expanded(child: Divider(color: TraveloopColors.outlineVariant)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Social buttons
                          const Row(
                            children: [
                              Expanded(child: _SocialButton(icon: Icons.g_mobiledata, label: 'Google')),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.plusJakartaSans(fontSize: 14, color: TraveloopColors.onSurfaceVariant),
                                children: [
                                  TextSpan(text: _isLogin ? "Don't have an account? " : 'Already have an account? '),
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: () => setState(() => _isLogin = !_isLogin),
                                      child: Text(
                                        _isLogin ? 'Sign Up' : 'Login',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14, fontWeight: FontWeight.w700,
                                          color: TraveloopColors.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Footer
                    Container(
                      color: TraveloopColors.surfaceContainerLow,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.verified_user, size: 14, color: TraveloopColors.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            'SECURE LOGIN POWERED BY Traveloop',
                            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w700, color: TraveloopColors.onSurfaceVariant, letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: GoogleFonts.plusJakartaSans(
      fontSize: 12, fontWeight: FontWeight.w600,
      color: TraveloopColors.onSurfaceVariant, letterSpacing: 0.48,
    ),
  );
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SocialButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: TraveloopColors.onSurface),
      label: Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: TraveloopColors.onSurface)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: TraveloopColors.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: TraveloopColors.surfaceContainerLowest,
      ),
    );
  }
}
