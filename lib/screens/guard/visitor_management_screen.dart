import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_state.dart';
import 'package:mygate_coepd/theme/app_theme.dart';
import 'package:mygate_coepd/screens/guard/details/group_visitor_entry_screen.dart';
import 'package:mygate_coepd/screens/guard/details/vendor_access_screen.dart';
import 'package:mygate_coepd/screens/guard/details/utility_vehicle_tracking_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VisitorManagementScreen extends StatefulWidget {
  const VisitorManagementScreen({super.key});

  @override
  State<VisitorManagementScreen> createState() => _VisitorManagementScreenState();
}

class _VisitorManagementScreenState extends State<VisitorManagementScreen> {
  int _selectedIndex = 0;
  bool _isOffline = false;

  final List<Map<String, dynamic>> _visitors = [
    {
      'id': 1,
      'name': 'Rahul Kumar',
      'type': 'Delivery',
      'flat': 'A-101',
      'time': '10:15 AM',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100&h=100',
      'status': 'pending',
    },
    {
      'id': 2,
      'name': 'Priya Sharma',
      'type': 'Guest',
      'flat': 'B-203',
      'time': '10:05 AM',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100&h=100',
      'status': 'approved',
    },
    {
      'id': 3,
      'name': 'Amit Patel',
      'type': 'Service',
      'flat': 'C-105',
      'time': '9:45 AM',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100&h=100',
      'status': 'rejected',
    },
  ];

  final List<Map<String, dynamic>> _frequentVisitors = [
    {
      'id': 1,
      'name': 'School Bus',
      'type': 'Transport',
      'vehicle': 'MH-01 AB 1234',
      'frequency': 'Daily',
      'image': 'https://images.unsplash.com/photo-1541899481282-d53b200c8f53?auto=format&fit=crop&q=80&w=100&h=100',
    },
    {
      'id': 2,
      'name': 'Milkman',
      'type': 'Service',
      'vehicle': 'NA',
      'frequency': 'Daily',
      'image': 'https://images.unsplash.com/photo-1541899481282-d53b200c8f53?auto=format&fit=crop&q=80&w=100&h=100',
    },
    {
      'id': 3,
      'name': 'Water Tanker',
      'type': 'Utility',
      'vehicle': 'MH-02 CD 5678',
      'frequency': 'Weekly',
      'image': 'https://images.unsplash.com/photo-1541899481282-d53b200c8f53?auto=format&fit=crop&q=80&w=100&h=100',
    },
  ];

  final List<String> _categories = [
    'All Visitors',
    'Pending Approval',
    'Approved',
    'Rejected',
    'Frequent Visitors',
    'Group Entry',
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      'icon': Icons.group,
      'label': 'Group Entry',
      'color': Colors.blue,
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
      'label': 'Vehicle Tracking',
      'color': Colors.orange,
      'screen': 'vehicle_tracking',
    },
  ];

  void _handleApprove(int id) {
    setState(() {
      // Update visitor status to approved
    });
  }

  void _handleReject(int id) {
    setState(() {
      // Update visitor status to rejected
    });
  }

  void _showAddVisitorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Visitor'),
          content: const Text('Visitor entry form would appear here'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
      case 'vehicle_tracking':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UtilityVehicleTrackingScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Visitor Management'),
              actions: [
                IconButton(
                  onPressed: () {
                    // Refresh action
                  },
                  icon: const Icon(Icons.refresh),
                ),
                IconButton(
                  onPressed: () {
                    // Filter action
                  },
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
            body: Stack(
              children: [
                Padding(
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
                      // Quick Actions
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              crossAxisCount: 3,
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
                                      padding: const EdgeInsets.all(20),
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
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    action['label'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      // Category Tabs
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: ChoiceChip(
                                label: Text(_categories[index]),
                                selected: _selectedIndex == index,
                                selectedColor: AppTheme.primary,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _selectedIndex = selected ? index : 0;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      // Visitor List
                      Expanded(
                        child: _selectedIndex == 4
                            ? _buildFrequentVisitorsList()
                            : _buildVisitorList(),
                      ),
                    ],
                  ),
                ),
                // Floating Action Button
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: _showAddVisitorDialog,
                    backgroundColor: AppTheme.primary,
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
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

  Widget _buildVisitorList() {
    return ListView.builder(
      // padding: const EdgeInsets.all(20),
      itemCount: _visitors.length,
      itemBuilder: (context, index) {
        final visitor = _visitors[index];
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
                      backgroundImage: CachedNetworkImageProvider(visitor['image']),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            visitor['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: visitor['status'] == 'approved'
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : visitor['status'] == 'rejected'
                                      ? Colors.red.withValues(alpha: 0.2)
                                      : Colors.orange.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              visitor['status'].toString().toUpperCase(),
                              style: TextStyle(
                                color: visitor['status'] == 'approved'
                                    ? Colors.green
                                    : visitor['status'] == 'rejected'
                                        ? Colors.red
                                        : Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                if (visitor['status'] == 'pending')
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
    );
  }

  Widget _buildFrequentVisitorsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _frequentVisitors.length,
      itemBuilder: (context, index) {
        final visitor = _frequentVisitors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(visitor['image']),
            ),
            title: Text(
              visitor['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${visitor['type']} • ${visitor['vehicle']}'),
                Text('Frequency: ${visitor['frequency']}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // Quick entry action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Entry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}