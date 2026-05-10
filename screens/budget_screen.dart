import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveloop/widgets/header.dart';
import '../theme/app_theme.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  final _expenses = const [
    {
      'category': 'Flights',
      'icon': Icons.flight_takeoff,
      'amount': 1240.00,
      'budget': 1300.00,
      'color': Color(0xFF4F5E83)
    },
    {
      'category': 'Accommodation',
      'icon': Icons.hotel_outlined,
      'amount': 860.00,
      'budget': 1000.00,
      'color': Color(0xFF9F4200)
    },
    {
      'category': 'Food & Dining',
      'icon': Icons.restaurant_outlined,
      'amount': 320.00,
      'budget': 500.00,
      'color': Color(0xFFFC7C31)
    },
    {
      'category': 'Transport',
      'icon': Icons.directions_bus_outlined,
      'amount': 180.00,
      'budget': 200.00,
      'color': Color(0xFF45464E)
    },
    {
      'category': 'Activities',
      'icon': Icons.attractions_outlined,
      'amount': 95.00,
      'budget': 300.00,
      'color': Color(0xFF793100)
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalBudget =
        _expenses.fold(0.0, (s, e) => s + (e['budget'] as double));
    final totalSpent =
        _expenses.fold(0.0, (s, e) => s + (e['amount'] as double));
    final remaining = totalBudget - totalSpent;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const TraveloopHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Budget',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: TraveloopColors.primary,
                          letterSpacing: -0.64)),
                  Text('Kyoto Trip • Oct 2024',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: TraveloopColors.onSurfaceVariant)),
                  const SizedBox(height: 24),
                  // Summary card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [TraveloopColors.primary, Color(0xFF0A1B3D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color:
                                TraveloopColors.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Budget',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white60,
                                letterSpacing: 0.48)),
                        const SizedBox(height: 4),
                        Text('₹${totalBudget.toStringAsFixed(0)}',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.64)),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: totalSpent / totalBudget,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation(
                                TraveloopColors.secondaryContainer),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                                child: _SummaryItem(
                                    label: 'Spent',
                                    value: '₹${totalSpent.toStringAsFixed(0)}',
                                    color: TraveloopColors.secondaryContainer)),
                            Expanded(
                                child: _SummaryItem(
                                    label: 'Remaining',
                                    value: '₹${remaining.toStringAsFixed(0)}',
                                    color: Colors.greenAccent)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Breakdown',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: TraveloopColors.primary)),
                      TextButton(
                        onPressed: () {},
                        child: Text('+ Add Expense',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: TraveloopColors.secondary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ..._expenses.map((e) => _ExpenseRow(expense: e)),
                  const SizedBox(height: 32),
                  // Recent transactions
                  Text('Recent Transactions',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: TraveloopColors.primary)),
                  const SizedBox(height: 12),
                  ...[
                    {
                      'title': 'Fushimi Inari Entrance',
                      'date': 'Oct 24',
                      'amount': '-₹12.00',
                      'cat': 'Activities'
                    },
                    {
                      'title': 'Ramen in Gion',
                      'date': 'Oct 23',
                      'amount': '-₹18.50',
                      'cat': 'Food'
                    },
                    {
                      'title': 'JR Pass Day 2',
                      'date': 'Oct 22',
                      'amount': '-₹45.00',
                      'cat': 'Transport'
                    },
                    {
                      'title': 'Hotel Kyoto Night 1',
                      'date': 'Oct 21',
                      'amount': '-₹220.00',
                      'cat': 'Hotel'
                    },
                  ].map((t) => _TransactionRow(tx: t)),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TraveloopColors.secondaryContainer,
        foregroundColor: TraveloopColors.onSecondaryContainer,
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _SummaryItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white60,
                letterSpacing: 0.48)),
        Text(value,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 18, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}

class _ExpenseRow extends StatelessWidget {
  final Map<String, dynamic> expense;
  const _ExpenseRow({required this.expense});

  @override
  Widget build(BuildContext context) {
    final amount = expense['amount'] as double;
    final budget = expense['budget'] as double;
    final ratio = (amount / budget).clamp(0.0, 1.0);
    final color = expense['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TraveloopColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: TraveloopColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8)),
                child:
                    Icon(expense['icon'] as IconData, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expense['category'] as String,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: TraveloopColors.primary)),
                    Text(
                        '₹${amount.toStringAsFixed(0)} of ₹${budget.toStringAsFixed(0)}',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: TraveloopColors.onSurfaceVariant)),
                  ],
                ),
              ),
              Text('${(ratio * 100).toStringAsFixed(0)}%',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ratio > 0.9 ? TraveloopColors.error : color)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: ratio,
              backgroundColor: TraveloopColors.surfaceContainer,
              valueColor: AlwaysStoppedAnimation(
                  ratio > 0.9 ? TraveloopColors.error : color),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final Map<String, String> tx;
  const _TransactionRow({required this.tx});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: TraveloopColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: TraveloopColors.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx['title']!,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: TraveloopColors.primary)),
                Text('${tx['date']!} • ${tx['cat']!}',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: TraveloopColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text(tx['amount']!,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: TraveloopColors.error)),
        ],
      ),
    );
  }
}
