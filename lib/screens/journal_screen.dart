import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traveloop/widgets/header.dart';
import '../theme/app_theme.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  int _activeFilter = 0;
  bool _showEditor = false;

  final _filters = ['All Notes', 'Kyoto Trip', 'Day 3', 'Food Log'];

  final _notes = [
    {
      'date': 'Oct 24, 10:45 AM',
      'trip': 'Kyoto Trip',
      'title': 'Arashiyama Bamboo Grove',
      'body':
          'The sunlight filtering through the stalks is ethereal. Must remember to bring the wide-angle lens next time. The crowd was light early in the morning...',
      'tags': ['Sightseeing', 'Nature'],
      'hasImage': false,
      'image': null,
    },
    {
      'date': 'Oct 23, 8:12 PM',
      'trip': 'Day 2',
      'title': 'Best Ramen in Gion',
      'body':
          '"The richness of the broth was unparalleled. Subtle hint of yuzu."',
      'tags': <String>[],
      'hasImage': false,
      'image': null,
    },
    {
      'date': 'Oct 22, 2:30 PM',
      'trip': 'Kyoto Trip',
      'title': 'Fushimi Inari Shrine',
      'body': 'Hiking all the way to the top was worth it for the view.',
      'tags': <String>[],
      'hasImage': true,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD9AZbvMTxc2pjA7EM4eorEUDZ_OdvmEnXD8s9uG5pEVuZHW-eirfH7gWq-lnqFytNfJW_kGdkPaeAQCRR1KVnGyflPKMlW35MJM1NXFxU0S5DnKRN2CwOcTWvlN-apuS8wntoeA7-YFFc9Mi4nQ5nh1I3tPJ_qPkl6vNoNANNRvdlavx1FBDa9VLJgW-i2rsrtwNAIWgJ1pBw-omuKOyqsj5V22Z-AC-De3QX8TaoGBMG0q0O7lnX17htDJTPdpBbq_-dza1hchO6J',
    },
    {
      'date': 'Oct 21, 11:00 PM',
      'trip': 'Preparation',
      'title': 'Final Packing Checklist',
      'body':
          'Passport, rail pass, comfortable shoes, and the travel adapter. Everything is ready for the flight tomorrow morning!',
      'tags': <String>[],
      'hasImage': false,
      'image': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const TraveloopHeader(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('My Journal',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w800,
                                        color: TraveloopColors.primary,
                                        letterSpacing: -0.64)),
                                Text(
                                    'Capture your thoughts, memories, and important details for your journey to Kyoto.',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        color:
                                            TraveloopColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Filter chips
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _filters.length,
                          itemBuilder: (context, i) {
                            final isActive = i == _activeFilter;
                            return GestureDetector(
                              onTap: () => setState(() => _activeFilter = i),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? TraveloopColors.primary
                                      : TraveloopColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(_filters[i],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isActive
                                          ? TraveloopColors.onPrimary
                                          : TraveloopColors.onSurfaceVariant,
                                      letterSpacing: 0.28,
                                    )),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _NoteCard(note: _notes[i]),
                    childCount: _notes.length,
                  ),
                ),
              ),
            ],
          ),
          // FAB
          Positioned(
            bottom: 88,
            right: 20,
            child: GestureDetector(
              onTap: () => setState(() => _showEditor = true),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: TraveloopColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: const Icon(Icons.add,
                    color: TraveloopColors.onSecondaryContainer, size: 32),
              ),
            ),
          ),
          // Editor bottom sheet
          if (_showEditor)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: TraveloopColors.surfaceContainerLowest,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 30,
                        offset: const Offset(0, -8))
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                    24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () =>
                                setState(() => _showEditor = false),
                            child: Text('Cancel',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: TraveloopColors.onSurfaceVariant))),
                        Text('New Entry',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: TraveloopColors.primary)),
                        TextButton(
                            onPressed: () =>
                                setState(() => _showEditor = false),
                            child: Text('Save',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: TraveloopColors.secondary))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: TraveloopColors.primary),
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: TraveloopColors.outlineVariant),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const Divider(color: TraveloopColors.outlineVariant),
                    // Toolbar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.format_bold),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                          IconButton(
                              icon: const Icon(Icons.format_italic),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                          IconButton(
                              icon: const Icon(Icons.format_list_bulleted),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                          IconButton(
                              icon: const Icon(Icons.format_list_numbered),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                          Container(
                              width: 1,
                              height: 24,
                              color: TraveloopColors.outlineVariant
                                  .withValues(alpha: 0.3)),
                          IconButton(
                              icon: const Icon(Icons.link),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                          IconButton(
                              icon: const Icon(Icons.image_outlined),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                          IconButton(
                              icon: const Icon(Icons.location_on_outlined),
                              onPressed: () {},
                              color: TraveloopColors.onSurfaceVariant),
                        ],
                      ),
                    ),
                    const Divider(color: TraveloopColors.outlineVariant),
                    TextField(
                      maxLines: 5,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16, color: TraveloopColors.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Start writing your memories...',
                        hintStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            color: TraveloopColors.outlineVariant),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 18,
                              color: TraveloopColors.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text('Today, 3:42 PM',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: TraveloopColors.onSurfaceVariant,
                                  letterSpacing: 0.48)),
                        ]),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: TraveloopColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(999)),
                          child: Row(children: [
                            const Icon(Icons.travel_explore,
                                size: 18,
                                color: TraveloopColors.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Text('Kyoto Trip',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: TraveloopColors.onSurfaceVariant,
                                    letterSpacing: 0.48)),
                          ]),
                        ),
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
}

class _NoteCard extends StatelessWidget {
  final Map<String, dynamic> note;
  const _NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    final hasImage = note['hasImage'] as bool;
    final tags = note['tags'] as List<String>;

    if (hasImage) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: TraveloopColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: TraveloopColors.outlineVariant.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            SizedBox(
              width: 96,
              child: Image.network(
                note['image']!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: TraveloopColors.surfaceContainerHigh),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${note['date']} • ${note['trip']}'.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: TraveloopColors.onSurfaceVariant,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text(note['title']!,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: TraveloopColors.primary)),
                    Text(note['body']!,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: TraveloopColors.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TraveloopColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: TraveloopColors.outlineVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text('${note['date']} • ${note['trip']}'.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: TraveloopColors.onSurfaceVariant,
                          letterSpacing: 0.5))),
              const Icon(Icons.more_vert,
                  size: 20, color: TraveloopColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: 4),
          Text(note['title']!,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: TraveloopColors.primary)),
          const SizedBox(height: 4),
          Text(note['body']!,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 14, color: TraveloopColors.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: tags
                  .map((tag) => Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: TraveloopColors.surfaceVariant
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(tag.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: TraveloopColors.onSurfaceVariant)),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
