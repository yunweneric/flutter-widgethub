import 'package:flutter/material.dart';
import '../../shared/shared.dart';
import 'widgets/index.dart';

class Explore3 extends StatefulWidget {
  const Explore3({super.key});

  @override
  State<Explore3> createState() => _Explore3State();
}

class _Explore3State extends State<Explore3> {
  bool isFavorite = false;
  late ScrollController _scrollController;
  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_showHeader) {
      setState(() {
        _showHeader = true;
      });
    } else if (_scrollController.offset <= 50 && _showHeader) {
      setState(() {
        _showHeader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Sliver app bar that shows/hides header
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: _showHeader
                  ? Theme.of(context).colorScheme.surface.withOpacity(0.95)
                  : Colors.transparent,
              elevation: _showHeader ? 2 : 0,
              shadowColor: Colors.black.withOpacity(0.1),
              surfaceTintColor: Colors.transparent,
              title: const HeaderWidget(),
              flexibleSpace: FlexibleSpaceBar(
                background: MainImageWidget(
                  isFavorite: isFavorite,
                  onFavoriteTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
                titlePadding: EdgeInsets.zero,
                centerTitle: false,
              ),
            ),

            // Main content slivers
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property title and rating
                  PropertyTitleWidget(),

                  // Host information
                  HostInfoWidget(),

                  // Room details
                  RoomDetailsWidget(),

                  // Self check-in
                  SelfCheckInWidget(),

                  // Booking section
                  BookingSectionWidget(),

                  // AirCover protection
                  AirCoverWidget(),

                  // Property description
                  DescriptionWidget(),

                  // Where you'll sleep
                  SleepingSectionWidget(),

                  // Amenities
                  AmenitiesWidget(),

                  // Location map
                  LocationSectionWidget(),

                  // Reviews
                  ReviewsWidget(),

                  // Host profile
                  HostProfileWidget(),

                  // During your stay
                  DuringStayWidget(),

                  // Additional sections
                  AdditionalSectionsWidget(),

                  // Bottom padding
                  SizedBox(height: AirbnbConstants.paddingXL),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
