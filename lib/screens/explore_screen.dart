import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveloop/widgets/header.dart';
import '../theme/app_theme.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Recent trips data
  final _recentTrips = [
    {
      'name': 'Tokyo & Kyoto',
      'dates': 'Apr 12 - Apr 24 • 12 Days',
      'status': 'COMPLETE',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBjXv_9iaoXoxHmy36ex65Ky8k8_3reu4o-DR9OtVgj06PQdyYFhXG3f9gYPliBgFbsqdv_7KejBHPPavanFXethPVff3XJumpHMnyU6870Gk_mAVD7k8vOojrNUrA-hNGH2-yPdfjT6cE8HahzzPgeQLb2sBFuqSYhsNpy6DmBp9CGPgmCdw8j8FPZxfl1nbLdOSJ60RofUEC3nnOYKvuN1smJcwHG59imOSvBrzbhs4IKPkhg35HkwyCYGrkbaJMQdNeqevNVg6O9',
    },
    {
      'name': 'Greek Islands',
      'dates': 'Jun 05 - Jun 15',
      'status': '',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBuNrFxGgm28E0SWTpNxM3sDAEgb8oN_bePa8I9mLOPJhT3ghT2S1uJwTfcT5-5ZYuO2vwS-xDilFBSGV6nK_Gd0N6JR7M2MVqBSfz6ot2mUiD0PzSB0bJL9z4Z0SYiXGSUqnF9pB7NmU1CKCopk3Q0YbJf5VL3QKyBSXvCl7FE4eFbCqyMbP29Ct2v4hA4R82JhY_KYrGVW6s9cBf_0SJz0gB6L4vQ1f87W3tM',
    },
  ];

  // Recommended destinations
  final _recommended = [
    {
      'name': 'Paris, France',
      'tag': 'POPULAR',
      'size': 'large',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBO6E8UYTAD-dcAxL_yV8xQ-p6s4xAf_w--Ysmhsjsgds1svgjxgwR__xOIf3sAHjWIpNc51mjwRwSIx0qx9govVcNppXG1T-IpWbZ3Fn5B8kJGI06oa6CuxmKOLOot-0fcX2jp_rcfWROdj8CVnDQ1wEVgrDWe7TwJ8npzt5DJ7y_N1GfTWr00bCcEjoJ5GflLsjsiKH3Q2h6iZgf4_iiaFUx9FXX1fgPjN5Ahj3WuIY_9E3l6eUiIz88lay0GYtOPF76a7hAH6iOb',
    },
    {
      'name': 'Venice',
      'tag': '',
      'size': 'small',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAaO3LyPPKV05LCp_B1_5s3WZjem5dRo2RbUw0t1S2pJQN6TRN_tEVuWX96os43LyE9rBdGwQjQ7RJ2aAnirM-HwO_5D_Ueb8BWs65rbheaGjpvsTvTMIlOQ8GSqlGi8M1lhKf9bwnA5pshuet_8m9x1kpdYI6E8ixRQ5cdmbQ0lS-e_BJLn-QIkspkiv2E3Q7C10V5rorl4Nm8CZJd8fLr0pggVeirh8gbJCbCslfBsaCZkvPIow_cLtXmhK4o75CGp9juUI_Ybh4i',
    },
    {
      'name': 'Dubai',
      'tag': '',
      'size': 'small',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAmB_5kQ9Puv5gwYqrXr2MhjO7vcMzTwMFSGzbl7wW3iJc7DKxa-th69MZ41TT257unTQs1AX6zyC30OEZrtaNt05kKbzOEcU7VIe3xFVuRsqYKrstuzPRT0_66rNpdKsnQUm_BMRPMmF5xffmxWRix1kB2j32zS1NOYVYWnAx1Bke7J_BNeEA5-tEXwoz9aDBiLj7BVvDzF7s77bTzukTY_Y8tZzhcIrFPfdoO4xHYg3W9ElY6pnFhTHYtX8djhihNsaQMvk7hAR3R',
    },
    {
      'name': 'Maldives',
      'tag': '',
      'size': 'large',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBjXv_9iaoXoxHmy36ex65Ky8k8_3reu4o-DR9OtVgj06PQdyYFhXG3f9gYPliBgFbsqdv_7KejBHPPavanFXethPVff3XJumpHMnyU6870Gk_mAVD7k8vOojrNUrA-hNGH2-yPdfjT6cE8HahzzPgeQLb2sBFuqSYhsNpy6DmBp9CGPgmCdw8j8FPZxfl1nbLdOSJ60RofUEC3nnOYKvuN1smJcwHG59imOSvBrzbhs4IKPkhg35HkwyCYGrkbaJMQdNeqevNVg6O9',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TraveloopColors.surface,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App Bar
            const TraveloopHeader(),
            
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello, Alex!', style: GoogleFonts.plusJakartaSans(fontSize: 32, fontWeight: FontWeight.w800, color: TraveloopColors.primary, letterSpacing: -0.64)),
                      Text(
                        'Where should we go next?',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: TraveloopColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Budget Card
                      _BudgetCard(),
                      const SizedBox(height: 28),

                      // Recent Trips Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Trips',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: TraveloopColors.primary,
                            ),
                          ),
                          Text(
                            'View All',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: TraveloopColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Recent Trips horizontal scroll
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _recentTrips.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, i) =>
                              _TripCard(trip: _recentTrips[i]),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Plan New Trip Banner
                      _PlanTripBanner(),
                      const SizedBox(height: 28),

                      // Recommended for You
                      Text(
                        'Recommended for You',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: TraveloopColors.primary,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Recommended grid
                      _RecommendedGrid(items: _recommended),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating map button
          Positioned(
            right: 20,
            bottom: 80,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: TraveloopColors.secondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: TraveloopColors.secondary.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child:
                  const Icon(Icons.map_outlined, color: Colors.white, size: 26),
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double spent = 1240;
    const double total = 2500;
    const double progress = spent / total;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Budget',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: TraveloopColors.primary,
                ),
              ),
              Text(
                'Paris Getaway',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: TraveloopColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Spent: ₹1,240.00',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: TraveloopColors.onSurfaceVariant,
                ),
              ),
              Text(
                'Total: ₹2,500.00',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: TraveloopColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: TraveloopColors.surfaceContainer,
              valueColor:
                  AlwaysStoppedAnimation<Color>(TraveloopColors.secondary),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '49% OF BUDGET CONSUMED',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: TraveloopColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Trip Card ────────────────────────────────────────────────────────────────

class _TripCard extends StatelessWidget {
  final Map<String, String> trip;
  const _TripCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final hasStatus = trip['status']!.isNotEmpty;

    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            trip['image']!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: TraveloopColors.surfaceContainer),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Status badge
          if (hasStatus)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: TraveloopColors.secondary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  trip['status']!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          // Name & dates
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip['name']!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  trip['dates']!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Plan Trip Banner ─────────────────────────────────────────────────────────

class _PlanTripBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2340),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ready for adventure?',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Start your next journey with our expert tools.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_circle_outline, size: 18),
            label: const Text('Plan New Trip'),
            style: ElevatedButton.styleFrom(
              backgroundColor: TraveloopColors.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999)),
              textStyle: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Recommended Grid ─────────────────────────────────────────────────────────

class _RecommendedGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _RecommendedGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    // Layout: large, [small, small], large
    final large1 = items.isNotEmpty ? items[0] : null;
    final small1 = items.length > 1 ? items[1] : null;
    final small2 = items.length > 2 ? items[2] : null;
    final large2 = items.length > 3 ? items[3] : null;

    return Column(
      children: [
        if (large1 != null) _RecommendedItem(item: large1, height: 200),
        const SizedBox(height: 10),
        if (small1 != null && small2 != null)
          Row(
            children: [
              Expanded(child: _RecommendedItem(item: small1, height: 130)),
              const SizedBox(width: 10),
              Expanded(child: _RecommendedItem(item: small2, height: 130)),
            ],
          ),
        const SizedBox(height: 10),
        if (large2 != null) _RecommendedItem(item: large2, height: 160),
      ],
    );
  }
}

class _RecommendedItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final double height;
  const _RecommendedItem({required this.item, required this.height});

  @override
  Widget build(BuildContext context) {
    final tag = item['tag']?.toString() ?? '';

    final hasTag = tag.isNotEmpty;

    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            item['image']?.toString() ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Container(color: TraveloopColors.surfaceContainer),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.65),
                ],
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasTag)
                  Text(
                    tag,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white.withValues(alpha: 0.8),
                      letterSpacing: 1,
                    ),
                  ),
                if (hasTag) const SizedBox(height: 2),
                Text(
                  item['name']?.toString() ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
