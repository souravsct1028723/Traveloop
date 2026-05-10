import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveloop/widgets/header.dart';
import '../theme/app_theme.dart';

class PackingScreen extends StatefulWidget {
  const PackingScreen({super.key});

  @override
  State<PackingScreen> createState() => _PackingScreenState();
}

class _PackingScreenState extends State<PackingScreen> {
  void _showAddItemDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    int selectedCategory = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Add Packing Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    items: [
                      ...List.generate(
                        _categories.length,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            _categories[index]['name'].toString(),
                          ),
                        ),
                      ),
                      const DropdownMenuItem<int>(
                        value: -1,
                        child: Text('+ Create New Category'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      setModalState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedCategory == -1)
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: 'New Category Name',
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final text = nameController.text.trim();

                    if (text.isEmpty) return;

                    int targetCategory;

                    // Create new category
                    if (selectedCategory == -1) {
                      final newCategory = categoryController.text.trim();

                      if (newCategory.isEmpty) return;

                      setState(() {
                        _categories.add({
                          'icon': Icons.folder_outlined,
                          'name': newCategory,
                          'items': <Map<String, dynamic>>[],
                        });
                      });

                      targetCategory = _categories.length - 1;
                    } else {
                      targetCategory = selectedCategory;
                    }

                    setState(() {
                      (_categories[targetCategory]['items']
                              as List<Map<String, dynamic>>)
                          .add({
                        'label': text,
                        'checked': false,
                      });
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _removeItem(int catIndex, int itemIndex) {
    setState(() {
      (_categories[catIndex]['items'] as List<Map<String, dynamic>>)
          .removeAt(itemIndex);
    });
  }

  final List<Map<String, dynamic>> _categories = [
    {
      'icon': Icons.checkroom_outlined,
      'name': 'Clothing',
      'items': [
        {'label': 'Waterproof Jacket', 'checked': true},
        {'label': 'Thermal Layers', 'checked': false},
        {'label': 'Hiking Boots', 'checked': true},
        {'label': 'Wool Socks (5 pairs)', 'checked': false},
      ],
    },
    {
      'icon': Icons.article_outlined,
      'name': 'Documents',
      'items': [
        {'label': 'Passport', 'checked': true},
        {'label': 'Travel Insurance', 'checked': true},
        {'label': 'Flight E-ticket', 'checked': true},
      ],
    },
    {
      'icon': Icons.sanitizer_outlined,
      'name': 'Toiletries',
      'items': [
        {'label': 'Toothbrush', 'checked': true},
        {'label': 'Sunscreen SPF 50+', 'checked': false},
        {'label': 'Lip Balm', 'checked': false},
        {'label': 'Personal Meds', 'checked': false},
      ],
    },
    {
      'icon': Icons.devices_outlined,
      'name': 'Electronics',
      'items': [
        {'label': 'Camera + SD Cards', 'checked': true},
        {'label': 'Power Bank', 'checked': true},
        {'label': 'Universal Adapter', 'checked': false},
        {'label': 'Headphones', 'checked': false},
      ],
    },
  ];

  int _totalChecked() => _categories.fold(0, (sum, cat) {
        final items = cat['items'] as List<Map<String, dynamic>>;
        return sum + items.where((i) => i['checked'] as bool).length;
      });

  int _totalItems() => _categories.fold(0, (sum, cat) {
        final items = cat['items'] as List<Map<String, dynamic>>;
        return sum + items.length;
      });

  double _progress() {
    final total = _totalItems();
    return total == 0 ? 0 : _totalChecked() / total;
  }

  void _toggleItem(int catIndex, int itemIndex) {
    setState(() {
      _categories[catIndex]['items'][itemIndex]['checked'] =
          !(_categories[catIndex]['items'][itemIndex]['checked'] as bool);
    });
  }

  void _resetAll() {
    setState(() {
      for (final cat in _categories) {
        for (final item in cat['items'] as List<Map<String, dynamic>>) {
          item['checked'] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final percent = (_progress() * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // App Bar
                  const TraveloopHeader(),

                  // Header section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ACTIVE TRIP',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: TraveloopColors.secondary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Iceland Expedition',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: TraveloopColors.primary,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$percent%',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: TraveloopColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: _progress(),
                              minHeight: 8,
                              backgroundColor: TraveloopColors.surfaceContainer,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  TraveloopColors.secondary),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Action buttons row
                          Row(
                            children: [
                              _ActionButton(
                                icon: Icons.refresh_rounded,
                                label: 'Reset Checklist',
                                onTap: _resetAll,
                              ),
                              const SizedBox(width: 10),
                              _ActionButton(
                                icon: Icons.add,
                                label: 'New Item',
                                isPrimary: true,
                                onTap: _showAddItemDialog,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Category cards
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => _CategoryCard(
                          category: _categories[i],
                          categoryIndex: i,
                          onToggle: _toggleItem,
                          onRemove: _removeItem,
                        ),
                        childCount: _categories.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: isPrimary ? TraveloopColors.secondary : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isPrimary ? Colors.white : TraveloopColors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? Colors.white : TraveloopColors.primary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Category Card ────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final int categoryIndex;
  final void Function(int catIndex, int itemIndex) onToggle;
  final void Function(int catIndex, int itemIndex) onRemove;

  const _CategoryCard({
    required this.category,
    required this.categoryIndex,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final items = category['items'] as List<Map<String, dynamic>>;
    final checkedCount = items.where((i) => i['checked'] as bool).length;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: TraveloopColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    size: 20,
                    color: TraveloopColors.secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    category['name'] as String,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: TraveloopColors.primary,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F4F8),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$checkedCount/${items.length}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: TraveloopColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Items
            ...items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              final isChecked = item['checked'] as bool;

              return GestureDetector(
                onTap: () => onToggle(categoryIndex, idx),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (_) => onToggle(categoryIndex, idx),
                          activeColor: TraveloopColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            color: isChecked
                                ? TraveloopColors.secondary
                                : TraveloopColors.outlineVariant,
                            width: 1.5,
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item['label'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isChecked
                                ? TraveloopColors.onSurfaceVariant
                                : TraveloopColors.primary,
                            decoration:
                                isChecked ? TextDecoration.lineThrough : null,
                            decorationColor: TraveloopColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onRemove(categoryIndex, idx),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: TraveloopColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
