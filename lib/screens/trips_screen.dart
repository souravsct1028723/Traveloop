import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveloop/widgets/header.dart';
import '../theme/app_theme.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  int _filter = 0;

  final _trips = [
    {
      'title': 'Italian Coastline Tour',
      'dates': 'Oct 12 - Oct 20, 2024',
      'status': 'Upcoming',
      'days': '8',
      'cities': 'Rome, Amalfi, Naples',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAA4B7pEOgYEpoq3IqPA4Ax_BjVNjv4Uys6irp7DV7E5Wlq37wsRqaM6E3cLtzWsfgfAyeRW2LkbGkKclYRvfD1itsJKFyFfLERYHHJgXfgBZZajoI7AWn88gG1Nb8YDT_ByO1dBnqZiO-EmCuBDAWfqgvgjBrdcASZoh4EFlsm5E9jgviQn4VzQKq-KN9Rz3Pzi-brSZNljUMaTj8lcwazJWHx2MyX0vK5323KiwjnSyn5mv6XmGbzuekBNqsH4KRQjCjE__WEhPfR',
      'isPast': false,
    },
    {
      'title': 'Japan Cherry Blossom',
      'dates': 'Mar 25 - Apr 5, 2024',
      'status': 'Past',
      'days': '11',
      'cities': 'Tokyo, Kyoto, Osaka',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBjXv_9iaoXoxHmy36ex65Ky8k8_3reu4o-DR9OtVgj06PQdyYFhXG3f9gYPliBgFbsqdv_7KejBHPPavanFXethPVff3XJumpHMnyU6870Gk_mAVD7k8vOojrNUrA-hNGH2-yPdfjT6cE8HahzzPgeQLb2sBFuqSYhsNpy6DmBp9CGPgmCdw8j8FPZxfl1nbLdOSJ60RofUEC3nnOYKvuN1smJcwHG59imOSvBrzbhs4IKPkhg35HkwyCYGrkbaJMQdNeqevNVg6O9',
      'isPast': true,
    },
    {
      'title': 'Lisbon Weekend Getaway',
      'dates': 'Jan 10 - Jan 14, 2024',
      'status': 'Past',
      'days': '4',
      'cities': 'Lisbon, Sintra',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBZC4DkmuawC0N-RCpfFDgr5WAOFs6od77apZRDt1cy-ZWXBMQq3y2qUwAdN1jf1XCTFLqk3rbld8dZ4eRBWC3hYAsnVDROvlTsw9QXQSGKfIvI9yj5dPXHjSr2o9SJs4BFs6_FYfPs1pV3m-ibcfbYq-UrHaZjBdoXcnllSv-p3FRFFs-1_D8i9s-bVrfuTWpP0A4yM5xh-IfTAbZzb8CnU8Mm4tcjbGr9HRbmo6I_Y9-BL7dUQsC0O0zHv_P4rcfRY6AMojEGl8xs',
      'isPast': true,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_filter == 0) return _trips.cast();
    if (_filter == 1) return _trips.where((t) => t['isPast'] == false).toList().cast();
    return _trips.where((t) => t['isPast'] == true).toList().cast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const TraveloopHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Trips', style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: TraveloopColors.primary, letterSpacing: -0.64)),
                  Text('Manage your past and upcoming adventures', style: GoogleFonts.plusJakartaSans(fontSize: 16, color: TraveloopColors.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _chip('All Trips', 0),
                        const SizedBox(width: 8),
                        _chip('Upcoming', 1),
                        const SizedBox(width: 8),
                        _chip('Past', 2),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _TripCard(trip: _filtered[i]),
                childCount: _filtered.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, int idx) {
    final isSelected = _filter == idx;
    return GestureDetector(
      onTap: () => setState(() => _filter = idx),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TraveloopColors.primary : TraveloopColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12, fontWeight: FontWeight.w600,
            color: isSelected ? TraveloopColors.onPrimary : TraveloopColors.onSurfaceVariant,
            letterSpacing: 0.48,
          ),
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Map<String, dynamic> trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final isPast = trip['isPast'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: TraveloopColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TraveloopColors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: const Color(0xFF000109).withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 140,
            child: Image.network(trip['image']!, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: TraveloopColors.surfaceContainer),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isPast ? TraveloopColors.surfaceContainer : TraveloopColors.secondaryFixed,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          trip['status']!.toUpperCase(),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5,
                            color: isPast ? TraveloopColors.onSurfaceVariant : TraveloopColors.onSecondaryFixedVariant,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined, size: 18), visualDensity: VisualDensity.compact, color: TraveloopColors.onSurfaceVariant),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, size: 18), visualDensity: VisualDensity.compact, color: TraveloopColors.onSurfaceVariant),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(trip['title']!, style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w700, color: TraveloopColors.primary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 14, color: TraveloopColors.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Expanded(child: Text(trip['dates']!, style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: TraveloopColors.onSurfaceVariant, letterSpacing: 0.48), overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: TraveloopColors.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Expanded(child: Text(trip['cities']!, style: GoogleFonts.plusJakartaSans(fontSize: 12, color: TraveloopColors.onSurfaceVariant), overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _tag('${trip['days']} Days'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: TraveloopColors.surfaceVariant.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(4)),
    child: Text(text.toUpperCase(), style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w700, color: TraveloopColors.onSurfaceVariant)),
  );
}
