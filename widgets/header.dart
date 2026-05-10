import 'package:flutter/material.dart';
import 'package:traveloop/screens/profile_screen.dart';
import '../theme/app_theme.dart';

class TraveloopHeader extends StatelessWidget implements PreferredSizeWidget {
  const TraveloopHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: TraveloopColors.surface,
      elevation: 0,
      titleSpacing: 20,
      automaticallyImplyLeading: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: TraveloopColors.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      title: const Text('Traveloop'),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: TraveloopColors.outlineVariant,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAmB_5kQ9Puv5gwYqrXr2MhjO7vcMzTwMFSGzbl7wW3iJc7DKxa-th69MZ41TT257unTQs1AX6zyC30OEZrtaNt05kKbzOEcU7VIe3xFVuRsqYKrstuzPRT0_66rNpdKsnQUm_BMRPMmF5xffmxWRix1kB2j32zS1NOYVYWnAx1Bke7J_BNeEA5-tEXwoz9aDBiLj7BVvDzF7s77bTzukTY_Y8tZzhcIrFPfdoO4xHYg3W9ElY6pnFhTHYtX8djhihNsaQMvk7hAR3R',
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
