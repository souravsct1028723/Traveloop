import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: TraveloopColors.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
            title: const Text('Traveloop'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 112,
                              height: 112,
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [TraveloopColors.secondary, TraveloopColors.secondaryContainer],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCtUnh31vthXorMCsRCq7pomSjM7FVh0RfE5JKwaDFHUUWiK6xlv_SFT78rcGt7sC0xrZ7FreVHzj2cWcTgiWXATxqKWAMIgW2-923V3P5KYHcw_O0qJwbRKrx0u-SPM-vFDKRkbz0DkaP31MiOPRrBiWb8ojsPdaciSAZKiNsP_bReYlcQsR_9MCh8DUp-l7R9xJOszqTFeHG6v2GNSkxg0CdIb6E-pO-hzZba2-AlReuNY51YQQHfRoX_xgr1-6445I0-7lp___fu',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(0, 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: TraveloopColors.secondary,
                                  borderRadius: BorderRadius.circular(999),
                                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 4)],
                                ),
                                child: Text('Expert Explorer', style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('Alex Walker', style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: TraveloopColors.primary, letterSpacing: -0.64)),
                        const SizedBox(height: 4),
                        Text('12 Trips Planned • 24 Countries Visited', style: GoogleFonts.plusJakartaSans(fontSize: 16, color: TraveloopColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Personal Info
                  _sectionTitle('Personal Info'),
                  const SizedBox(height: 12),
                  const _InfoCard(children: [
                    _FormField(label: 'Full Name', value: 'Alex Walker'),
                    SizedBox(height: 16),
                    _FormField(label: 'Email Address', value: 'alex.walker@explorer.com', keyboardType: TextInputType.emailAddress),
                    SizedBox(height: 16),
                    _FormField(label: 'Home City', value: 'San Francisco, CA'),
                  ]),
                  const SizedBox(height: 24),

                  // Travel Preferences
                  _sectionTitle('Travel Preferences'),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Expanded(child: _PrefCard(
                        icon: Icons.groups_outlined,
                        iconColor: TraveloopColors.secondary,
                        borderColor: TraveloopColors.secondary,
                        title: 'Travel Style',
                        subtitle: 'Prefers Group & Solo hybrid trips with local guides.',
                      )),
                      SizedBox(width: 12),
                      Expanded(child: _PrefCard(
                        icon: Icons.payments_outlined,
                        iconColor: TraveloopColors.secondaryContainer,
                        borderColor: TraveloopColors.secondaryContainer,
                        title: 'Budget Level',
                        subtitle: '\$\$ Mid-Range Luxury',
                      )),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Saved Destinations
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _sectionTitle('Saved Destinations'),
                      TextButton(
                        onPressed: () {},
                        child: Text('View all', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: TraveloopColors.secondary, letterSpacing: 0.48)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 128,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _DestChip(city: 'Sydney, AU', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC07cCRbOYUEjmNtT8egA9_SOJg65PquP5C4wjWuZvNXEySw0I4xPfAd0ykjllRxvDEBdcq8TJzQIlgEtraUgH2irjXpEPhGGhSwgSwDSY5u1n30Pif0uWYuTGbmomP6oVfKOfvE7bRV1TnJW7aSGdoN5XQQ6hYnQS3mE59pPqjwGYtD2oYrTA6IeSdkNwmXmoxWNCpI9gAKAfxse_Z13oRRCWlYIrO-TEOum_2v9AASlBn9n4WveX-bdk3bWEMoNsBbT_b4Ykje_dT'),
                        _DestChip(city: 'Venice, IT', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBZC4DkmuawC0N-RCpfFDgr5WAOFs6od77apZRDt1cy-ZWXBMQq3y2qUwAdN1jf1XCTFLqk3rbld8dZ4eRBWC3hYAsnVDROvlTsw9QXQSGKfIvI9yj5dPXHjSr2o9SJs4BFs6_FYfPs1pV3m-ibcfbYq-UrHaZjBdoXcnllSv-p3FRFFs-1_D8i9s-bVrfuTWpP0A4yM5xh-IfTAbZzb8CnU8Mm4tcjbGr9HRbmo6I_Y9-BL7dUQsC0O0zHv_P4rcfRY6AMojEGl8xs'),
                        _DestChip(city: 'Kyoto, JP', image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBjXv_9iaoXoxHmy36ex65Ky8k8_3reu4o-DR9OtVgj06PQdyYFhXG3f9gYPliBgFbsqdv_7KejBHPPavanFXethPVff3XJumpHMnyU6870Gk_mAVD7k8vOojrNUrA-hNGH2-yPdfjT6cE8HahzzPgeQLb2sBFuqSYhsNpy6DmBp9CGPgmCdw8j8FPZxfl1nbLdOSJ60RofUEC3nnOYKvuN1smJcwHG59imOSvBrzbhs4IKPkhg35HkwyCYGrkbaJMQdNeqevNVg6O9'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Settings
                  _sectionTitle('Settings'),
                  const SizedBox(height: 12),
                  const _InfoCard(children: [
                    _SettingsRow(icon: Icons.language_outlined, title: 'Language', trailing: 'English (US)'),
                    Divider(color: TraveloopColors.outlineVariant, height: 1, indent: 56),
                    _SettingsRow(icon: Icons.notifications_outlined, title: 'Notifications', isToggle: true, toggleValue: true),
                    Divider(color: TraveloopColors.outlineVariant, height: 1, indent: 56),
                    _SettingsRow(icon: Icons.security_outlined, title: 'Privacy & Security'),
                  ]),
                  const SizedBox(height: 32),

                  // Logout
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (_) => false,
                        );
                      },
                      icon: const Icon(Icons.logout, color: TraveloopColors.error),
                      label: Text('Logout', style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700, color: TraveloopColors.error)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: TraveloopColors.error, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text('Traveloop v2.4.1 • Proudly exploring since 2024', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: TraveloopColors.outline, letterSpacing: 0.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(text, style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700, color: TraveloopColors.primary));
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TraveloopColors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: TraveloopColors.outlineVariant.withValues(alpha: 0.2)),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

class _FormField extends StatelessWidget {
  final String label;
  final String value;
  final TextInputType? keyboardType;
  const _FormField({required this.label, required this.value, this.keyboardType});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: TraveloopColors.onSurfaceVariant, letterSpacing: 0.48)),
      const SizedBox(height: 4),
      TextFormField(
        initialValue: value,
        keyboardType: keyboardType,
        style: GoogleFonts.plusJakartaSans(fontSize: 16, color: TraveloopColors.onSurface),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          filled: true,
          fillColor: Color(0x80FFFFFF),
        ),
      ),
    ],
  );
}

class _PrefCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final String title;
  final String subtitle;
  const _PrefCard({required this.icon, required this.iconColor, required this.borderColor, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TraveloopColors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(16),
      border: Border(left: BorderSide(color: borderColor, width: 4)),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(height: 8),
        Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600, color: TraveloopColors.primary)),
        const SizedBox(height: 4),
        Text(subtitle, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: TraveloopColors.onSurfaceVariant)),
      ],
    ),
  );
}

class _DestChip extends StatelessWidget {
  final String city;
  final String image;
  const _DestChip({required this.city, required this.image});
  @override
  Widget build(BuildContext context) => Container(
    width: 200,
    margin: const EdgeInsets.only(right: 12),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.hardEdge,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: TraveloopColors.surfaceContainer)),
        Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Color(0x99000000)], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
        Positioned(bottom: 12, left: 12, child: Text(city, style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))),
      ],
    ),
  );
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final bool isToggle;
  final bool toggleValue;
  const _SettingsRow({required this.icon, required this.title, this.trailing, this.isToggle = false, this.toggleValue = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Icon(icon, size: 24, color: TraveloopColors.onSurfaceVariant),
        const SizedBox(width: 16),
        Expanded(child: Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 16, color: TraveloopColors.onSurface))),
        if (isToggle)
          Switch(value: toggleValue, onChanged: (_) {}, activeThumbColor: TraveloopColors.secondary)
        else if (trailing != null) ...[
          Text(trailing!, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: TraveloopColors.onSurfaceVariant)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: TraveloopColors.outline),
        ] else
          const Icon(Icons.chevron_right, color: TraveloopColors.outline),
      ],
    ),
  );
}
