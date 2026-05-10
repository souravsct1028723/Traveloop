import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'explore_screen.dart';
import 'trips_screen.dart';
import 'journal_screen.dart';
import 'budget_screen.dart';
import 'pack_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final _screens = const [
    ExploreScreen(),
    TripsScreen(),
    JournalScreen(),
    PackingScreen(),
    BudgetScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: TraveloopNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
