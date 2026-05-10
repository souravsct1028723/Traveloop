import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveloop/widgets/header.dart';
import '../theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  int _filter = 0;
  List<Map<String, dynamic>> _trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  List<Map<String, dynamic>> get _filtered {
    final now = DateTime.now();

    final fallbackImages = [
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e', // beach
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b', // mountains
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee'  // valley
    ];

    final mappedTrips = _trips.asMap().entries.map((entry) {
      final index = entry.key;
      final trip = entry.value;

      final endDate = DateTime.parse(trip['end_date']);

      return {
        ...trip,
        'isPast': endDate.isBefore(now),
        'status': endDate.isBefore(now) ? 'Past' : 'Upcoming',
        'days': DateTime.parse(trip['end_date'])
            .difference(DateTime.parse(trip['start_date']))
            .inDays
            .toString(),
        'cities': trip['description'] ?? '',
        'image': trip['cover_image'] ??
            fallbackImages[index % fallbackImages.length],
        'dates': '${trip['start_date']} - ${trip['end_date']}',
      };
    }).toList();

    if (_filter == 0) return mappedTrips;

    if (_filter == 1) {
      return mappedTrips.where((t) => t['isPast'] == false).toList();
    }

    return mappedTrips.where((t) => t['isPast'] == true).toList();
  }

  Future<void> fetchTrips() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) return;

      final response = await Supabase.instance.client
          .from('trips')
          .select()
          .eq('user_id', user.id)
          .order('start_date');

      setState(() {
        _trips = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TraveloopColors.secondary,
        child: const Icon(
          Icons.add,
          color: TraveloopColors.surface,
        ),
        onPressed: () async {
          final titleController = TextEditingController();
          final descriptionController = TextEditingController();

          DateTime? startDate;
          DateTime? endDate;

          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: const Text('Create Trip'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'Trip Title',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            title: Text(
                              startDate == null
                                  ? 'Select Start Date'
                                  : startDate.toString().split(' ')[0],
                            ),
                            trailing: const Icon(Icons.calendar_month),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                                initialDate: DateTime.now(),
                              );

                              if (picked != null) {
                                setDialogState(() {
                                  startDate = picked;
                                });
                              }
                            },
                          ),
                          ListTile(
                            title: Text(
                              endDate == null
                                  ? 'Select End Date'
                                  : endDate.toString().split(' ')[0],
                            ),
                            trailing: const Icon(Icons.calendar_month),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2030),
                                initialDate: DateTime.now(),
                              );

                              if (picked != null) {
                                setDialogState(() {
                                  endDate = picked;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (titleController.text.isEmpty ||
                              startDate == null ||
                              endDate == null) {
                            return;
                          }

                          await Supabase.instance.client.from('trips').insert({
                            'user_id':
                                Supabase.instance.client.auth.currentUser!.id,
                            'title': titleController.text,
                            'description': descriptionController.text,
                            'start_date': startDate!.toIso8601String(),
                            'end_date': endDate!.toIso8601String(),
                          });

                          if (!context.mounted) return;

                          Navigator.pop(context);

                          fetchTrips();
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                const TraveloopHeader(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Trips',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: TraveloopColors.primary,
                                letterSpacing: -0.64)),
                        Text('Manage your past and upcoming adventures',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                color: TraveloopColors.onSurfaceVariant)),
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
          color: isSelected
              ? TraveloopColors.primary
              : TraveloopColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? TraveloopColors.onPrimary
                : TraveloopColors.onSurfaceVariant,
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
        border: Border.all(
            color: TraveloopColors.outlineVariant.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF000109).withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 140,
            child: Image.network(
              trip['image']!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: TraveloopColors.surfaceContainer),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isPast
                              ? TraveloopColors.surfaceContainer
                              : TraveloopColors.secondaryFixed,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          trip['status']!.toUpperCase(),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: isPast
                                ? TraveloopColors.onSurfaceVariant
                                : TraveloopColors.onSecondaryFixedVariant,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.share_outlined, size: 18),
                              visualDensity: VisualDensity.compact,
                              color: TraveloopColors.onSurfaceVariant),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_outlined, size: 18),
                              visualDensity: VisualDensity.compact,
                              color: TraveloopColors.onSurfaceVariant),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(trip['title']!,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: TraveloopColors.primary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined,
                          size: 14, color: TraveloopColors.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(trip['dates']!,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: TraveloopColors.onSurfaceVariant,
                                  letterSpacing: 0.48),
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.notes,
                          size: 14, color: TraveloopColors.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Expanded(
                          child: Text(trip['cities']!,
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: TraveloopColors.onSurfaceVariant),
                              overflow: TextOverflow.ellipsis)),
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
        decoration: BoxDecoration(
            color: TraveloopColors.surfaceVariant.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4)),
        child: Text(text.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: TraveloopColors.onSurfaceVariant)),
      );
}
