// ignore_for_file: unused_element, unused_local_variable, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_state.dart';
import 'package:mygate_coepd/theme/app_theme.dart';
import 'package:mygate_coepd/screens/guard/details/group_visitor_entry_screen.dart';
import 'package:mygate_coepd/screens/guard/details/vendor_access_screen.dart';
import 'package:mygate_coepd/screens/guard/details/utility_vehicle_tracking_screen.dart';
import 'package:mygate_coepd/screens/guard/details/guard_patrolling_screen.dart';
import 'package:mygate_coepd/screens/guard/details/guard_calling_screen.dart';
import 'package:mygate_coepd/screens/guard/details/temperature_mask_screen.dart';
import 'package:mygate_coepd/screens/voice_command_entry_screen.dart';
import 'package:mygate_coepd/screens/guard/details/e_intercom_screen.dart';
import 'package:mygate_coepd/screens/guard/details/offline_mode_screen.dart';
import 'package:mygate_coepd/screens/guard/details/multilingual_support_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GuardDashboardScreen extends StatefulWidget {
  const GuardDashboardScreen({super.key});

  @override
  State<GuardDashboardScreen> createState() => _GuardDashboardScreenState();
}

class _GuardDashboardScreenState extends State<GuardDashboardScreen> {
  bool _isOffline = false;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pendingVisitors = [
    {
      'id': 1,
      'name': 'Rahul Kumar',
      'type': 'Delivery',
      'flat': 'A-101',
      'time': '10:15 AM',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100&h=100',
    },
    {
      'id': 2,
      'name': 'Priya Sharma',
      'type': 'Guest',
      'flat': 'B-203',
      'time': '10:05 AM',
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100&h=100',
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'icon': Icons.person_add,
      'label': 'Visitor Entry',
      'color': Colors.blue,
      'screen': 'visitor_entry',
    },
    {
      'icon': Icons.group,
      'label': 'Group Entry',
      'color': Colors.purple,
      'screen': 'group_entry',
    },
    {
      'icon': Icons.build,
      'label': 'Vendor Access',
      'color': Colors.green,
      'screen': 'vendor_access',
    },
    {
      'icon': Icons.directions_car,
      'label': 'Vehicle Log',
      'color': Colors.orange,
      'screen': 'vehicle_log',
    },
    {
      'icon': Icons.directions_walk,
      'label': 'Patrolling',
      'color': Colors.indigo,
      'screen': 'patrolling',
    },
    {
      'icon': Icons.phone,
      'label': 'Call Guard',
      'color': Colors.red,
      'screen': 'call_guard',
    },
    {
      'icon': Icons.thermostat,
      'label': 'Temp Check',
      'color': Colors.teal,
      'screen': 'temp_check',
    },
    {
      'icon': Icons.keyboard_voice,
      'label': 'Voice Entry',
      'color': Colors.pink,
      'screen': 'voice_entry',
    },
    {
      'icon': Icons.voicemail,
      'label': 'E-Intercom',
      'color': Colors.cyan,
      'screen': 'e_intercom',
    },
    {
      'icon': Icons.wifi_off,
      'label': 'Offline Mode',
      'color': Colors.brown,
      'screen': 'offline_mode',
    },
    {
      'icon': Icons.language,
      'label': 'Language',
      'color': Colors.lime,
      'screen': 'language',
    },
  ];

  final List<Map<String, dynamic>> _recentActivity = [
    {
      'icon': Icons.person,
      'title': 'Visitor Entry',
      'description': 'Amit Patel for B-404',
      'time': '10:32 AM',
      'iconBg': Colors.blue,
      'iconColor': Colors.white,
    },
    {
      'icon': Icons.directions_car,
      'title': 'Vehicle Exit',
      'description': 'MH02 AB 1234',
      'time': '10:15 AM',
      'iconBg': Colors.green,
      'iconColor': Colors.white,
    },
    {
      'icon': Icons.inventory,
      'title': 'Delivery Accepted',
      'description': 'Amazon Package for A-101',
      'time': '9:45 AM',
      'iconBg': Colors.orange,
      'iconColor': Colors.white,
    },
  ];

  void _handleApprove(int id) {
    setState(() {
      // Remove the approved visitor from the list
    });
  }

  void _handleReject(int id) {
    setState(() {
      // Remove the rejected visitor from the list
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToScreen(String screen) {
    switch (screen) {
      case 'group_entry':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GroupVisitorEntryScreen(),
          ),
        );
        break;
      case 'vendor_access':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VendorAccessScreen(),
          ),
        );
        break;
      case 'vehicle_log':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UtilityVehicleTrackingScreen(),
          ),
        );
        break;
      case 'patrolling':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GuardPatrollingScreen(),
          ),
        );
        break;
      case 'call_guard':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GuardCallingScreen(),
          ),
        );
        break;
      case 'temp_check':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TemperatureMaskScreen(),
          ),
        );
        break;
      case 'voice_entry':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VoiceCommandEntryScreen(),
          ),
        );
        break;
      case 'e_intercom':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EIntercomScreen(),
          ),
        );
        break;
      case 'offline_mode':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OfflineModeScreen(),
          ),
        );
        break;
      case 'language':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MultilingualSupportScreen(),
          ),
        );
        break;
      default:
        // For visitor entry and other simple actions
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Action not implemented yet'),
            backgroundColor: AppTheme.primary,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Guard Dashboard'),
              actions: [
                IconButton(
                  onPressed: () {
                    // Notification action
                  },
                  icon: const Icon(Icons.notifications),
                ),
                IconButton(
                  onPressed: () {
                    // Menu action
                  },
                  icon: const Icon(Icons.menu),
                ),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Offline Banner
                        if (_isOffline)
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.wifi_off, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      'Offline Mode',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isOffline = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        // Search Bar at top
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.grey),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Search visitors, vehicles or flats...',
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (value) {
                                      // Handle search
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Quick Actions
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            const Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemCount: _quickActions.length,
                              itemBuilder: (context, index) {
                                final action = _quickActions[index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _navigateToScreen(action['screen']),
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: action['color'],
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: action['color']
                                                  .withValues(alpha: 0.3),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          action['icon'],
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      action['label'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Pending Approvals
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Pending Approvals',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${_pendingVisitors.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            if (_pendingVisitors.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _pendingVisitors.length,
                                itemBuilder: (context, index) {
                                  final visitor = _pendingVisitors[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        visitor['image']),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      visitor['name'],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      visitor['type'],
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'For: ${visitor['flat']} • ${visitor['time']}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    _handleReject(visitor['id']);
                                                  },
                                                  child: const Text('Reject'),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _handleApprove(visitor['id']);
                                                  },
                                                  child: const Text('Approve'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            else
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        'No pending approvals',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Recent Activity
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Recent Activity',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // View all activity
                                  },
                                  child: const Text('View All'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: _recentActivity
                                    .map(
                                      (activity) => ListTile(
                                        leading: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: activity['iconBg']
                                                .withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Icon(
                                            activity['icon'],
                                            color: activity['iconColor'],
                                          ),
                                        ),
                                        title: Text(activity['title']),
                                        subtitle: Text(activity['description']),
                                        trailing: Text(
                                          activity['time'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20), // Reduced space
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Removed bottomNavigationBar from here since it's handled in GuardMainScreen
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}