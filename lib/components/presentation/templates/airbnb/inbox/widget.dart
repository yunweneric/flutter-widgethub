import 'package:flutter/material.dart';
import '../shared/shared.dart';

/// Airbnb inbox screen with tabbed interface for messages and notifications.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// InboxScreen()
/// ```
class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Inbox', style: theme.textTheme.displayLarge),
            centerTitle: false,
          ),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab Bar
                TabBar(
                  padding: EdgeInsets.zero,
                  controller: _tabController,
                  labelColor: theme.primaryColorDark,
                  indicatorColor: theme.primaryColorDark,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Messages'),
                          const SizedBox(width: AirbnbConstants.paddingXS),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.primaryColorDark,
                              shape: BoxShape.circle,
                            ),
                            child: Text('1',
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(fontSize: 12, color: theme.primaryColorLight)),
                          ),
                        ],
                      ),
                    ),
                    const Tab(text: 'Notifications'),
                  ],
                ),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Messages Tab
                      _MessagesTab(),
                      // Notifications Tab
                      _NotificationsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AirbnbConstants.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AirbnbConstants.height30),

          // Messages List
          _MessagesList(),

          const SizedBox(height: AirbnbConstants.height40),
        ],
      ),
    );
  }
}

class _NotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: AirbnbTheme.mediumGray,
          ),
          const SizedBox(height: AirbnbConstants.height20),
          Text(
            'No notifications yet',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AirbnbTheme.mediumGray,
                ),
          ),
        ],
      ),
    );
  }
}

class _MessagesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MessageItem(
          profileImage: 'https://picsum.photos/60/60?random=airbnb',
          sender: 'Craig',
          message: 'Alright got it we\'ll make do thanks a lot',
          isSystemMessage: true,
        ),
        _MessageDivider(),
        _MessageItem(
          profileImage: 'https://picsum.photos/60/60?random=craig',
          sender: 'Craig',
          location: 'Yonkers',
          message: 'Airbnb update: Reservation canceled',
          subtitle: 'Canceled · Feb 13 - 14, 2023',
        ),
        _MessageDivider(),
        _MessageItem(
          profileImage: 'https://picsum.photos/60/60?random=erin',
          sender: 'Erin',
          location: 'New York',
          message: 'New date and time request',
          subtitle: 'Request pending',
        ),
      ],
    );
  }
}

class _MessageItem extends StatelessWidget {
  final String profileImage;
  final String sender;
  final String? location;
  final String message;
  final String? subtitle;
  final bool isSystemMessage;

  const _MessageItem({
    required this.profileImage,
    required this.sender,
    this.location,
    required this.message,
    this.subtitle,
    this.isSystemMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AirbnbConstants.height20),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: AirbnbConstants.height60,
            height: AirbnbConstants.height60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSystemMessage ? AirbnbTheme.white : null,
            ),
            child: ClipOval(
              child: Image.network(
                profileImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AirbnbTheme.backgroundGray,
                    ),
                    child: Icon(
                      isSystemMessage ? Icons.home : Icons.person,
                      size: 30,
                      color: AirbnbTheme.mediumGray,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: AirbnbConstants.paddingM),

          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender and Location
                Row(
                  children: [
                    Text(
                      sender,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (location != null) ...[
                      Text(
                        ' · ',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AirbnbTheme.mediumGray,
                        ),
                      ),
                      Text(
                        location!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AirbnbTheme.mediumGray,
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: AirbnbConstants.height10),

                // Message
                Text(
                  message,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (subtitle != null) ...[
                  const SizedBox(height: AirbnbConstants.height10),
                  Text(
                    subtitle!,
                    style: textTheme.bodySmall?.copyWith(
                      color: AirbnbTheme.mediumGray,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AirbnbTheme.lightGray,
      margin: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
    );
  }
}
