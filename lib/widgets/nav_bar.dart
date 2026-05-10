import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TraveloopNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TraveloopNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TraveloopColors.surfaceContainerLowest.withValues(alpha: 0.92),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(
          top: BorderSide(color: TraveloopColors.outlineVariant.withValues(alpha: 0.3)),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000109).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.explore_outlined, activeIcon: Icons.explore, label: 'Explore', index: 0, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.travel_explore_outlined, activeIcon: Icons.travel_explore, label: 'Trips', index: 1, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.add_circle_outline, activeIcon: Icons.add_circle, label: 'Journal', index: 2, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.checklist, activeIcon: Icons.checklist, label: 'Pack', index: 3, currentIndex: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.payments_outlined, activeIcon: Icons.payments, label: 'Budget', index: 4, currentIndex: currentIndex, onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isActive ? 16 : 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? TraveloopColors.secondaryFixed.withValues(alpha: 0.4) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? TraveloopColors.secondary : TraveloopColors.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? TraveloopColors.secondary : TraveloopColors.onSurfaceVariant,
                letterSpacing: 0.48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
