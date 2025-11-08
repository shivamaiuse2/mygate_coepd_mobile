import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mygate_coepd/blocs/auth/auth_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _currentIndex = 0;

  final List<Map<String, dynamic>> _stats = [
    {
      'title': 'Total Residents',
      'value': '246',
      'change': '+3',
      'isIncrease': true,
      'icon': Icons.people,
      'color': Colors.blue,
    },
    {
      'title': 'Pending Approvals',
      'value': '12',
      'change': '+5',
      'isIncrease': true,
      'icon': Icons.checklist,
      'color': Colors.orange,
    },
    {
      'title': 'Active Complaints',
      'value': '8',
      'change': '-2',
      'isIncrease': false,
      'icon': Icons.report_problem,
      'color': Colors.red,
    },
    {
      'title': 'Collection Rate',
      'value': '92%',
      'change': '+4%',
      'isIncrease': true,
      'icon': Icons.credit_card,
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> _pendingApprovals = [
    {
      'id': 1,
      'name': 'Rahul Kumar',
      'unit': 'A-101',
      'requestedOn': '2023-05-12T10:30:00',
      'type': 'Resident',
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100&h=100',
    },
    {
      'id': 2,
      'name': 'Priya Sharma',
      'unit': 'B-203',
      'requestedOn': '2023-05-11T14:15:00',
      'type': 'Tenant',
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100&h=100',
    },
  ];

  final List<Map<String, dynamic>> _recentActivity = [
    {
      'id': 1,
      'title': 'New Resident Registered',
      'description': 'Amit Patel registered for unit C-405',
      'time': '1 hour ago',
      'icon': Icons.person_add,
      'iconBg': Colors.blue,
      'iconColor': Colors.white,
    },
    {
      'id': 2,
      'title': 'Complaint Resolved',
      'description': 'Water leakage in B-201 fixed',
      'time': '3 hours ago',
      'icon': Icons.check_circle,
      'iconBg': Colors.green,
      'iconColor': Colors.white,
    },
    {
      'id': 3,
      'title': 'Payment Received',
      'description': '₹15,000 received from A-302',
      'time': '5 hours ago',
      'icon': Icons.credit_card,
      'iconBg': Colors.purple,
      'iconColor': Colors.white,
    },
  ];

  final List<Map<String, dynamic>> _quickAccess = [
    {'icon': Icons.apartment, 'label': 'Society Management', 'route': '/society-management'},
    {'icon': Icons.people, 'label': 'Resident Management', 'route': '/resident-management'},
    {'icon': Icons.business, 'label': 'Service Providers', 'route': '/service-providers'},
    {'icon': Icons.checklist, 'label': 'Staff Attendance', 'route': '/staff-attendance'},
    {'icon': Icons.house, 'label': 'Tenant Management', 'route': '/tenant-management'},
    {'icon': Icons.swap_horiz, 'label': 'Move Process', 'route': '/move-process'},
    {'icon': Icons.dashboard, 'label': 'Dashboard Config', 'route': '/dashboard-config'},
    {'icon': Icons.description, 'label': 'Reports', 'route': '/reports'},
    {'icon': Icons.settings, 'label': 'App Controls', 'route': '/app-controls'},
    {'icon': Icons.camera, 'label': 'Selfie Attendance', 'route': '/selfie-attendance'},
    {'icon': Icons.privacy_tip, 'label': 'Masked Directory', 'route': '/masked-directory'},
    {'icon': Icons.business, 'label': 'Multi-Property', 'route': '/multi-property'},
    {'icon': Icons.campaign, 'label': 'Notice Board', 'route': '/notice-board'},
    {'icon': Icons.move_to_inbox, 'label': 'Resident Requests', 'route': '/resident-requests'},
    {'icon': Icons.call, 'label': 'Resident Calling', 'route': '/resident-calling'},
    {'icon': Icons.email, 'label': 'Email Campaigns', 'route': '/email-campaigns'},
    {'icon': Icons.notifications, 'label': 'Push Notifications', 'route': '/push-notifications'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleApprove(int id) {
    // Handle approval logic
  }

  void _handleReject(int id) {
    // Handle rejection logic
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          // ignore: unused_local_variable
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Admin Dashboard'),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
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
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Residents'),
                  Tab(text: 'Billing'),
                  Tab(text: 'Complaints'),
                  Tab(text: 'Amenities'),
                  Tab(text: 'Reports'),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                // Overview Tab
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Stats Cards
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                          itemCount: _stats.length,
                          itemBuilder: (context, index) {
                            final stat = _stats[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10.r),
                                          decoration: BoxDecoration(
                                            color: stat['color'].withValues(alpha: 
                                              0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                          child: Icon(
                                            stat['icon'],
                                            color: stat['color'],
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      stat['title'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          stat['value'],
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          stat['change'],
                                          style: TextStyle(
                                            color: stat['isIncrease']
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Quick Access
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quick Access',
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
                                    childAspectRatio: 0.85,
                                  ),
                              itemCount: _quickAccess.length,
                              itemBuilder: (context, index) {
                                final item = _quickAccess[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to the respective module
                                        Navigator.pushNamed(context, item['route']);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).cardTheme.color,
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withValues(alpha: 0.1),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          item['icon'],
                                          color: Theme.of(context).primaryColor,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item['label'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // Pending Approvals
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
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
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${_pendingApprovals.length}',
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
                            if (_pendingApprovals.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _pendingApprovals.length,
                                itemBuilder: (context, index) {
                                  final approval = _pendingApprovals[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                      approval['image'],
                                                    ),
                                                backgroundColor: Theme.of(
                                                  context,
                                                ).primaryColor.withValues(alpha: 0.1),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      approval['name'],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '${approval['type']} • ${approval['unit']}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Requested: ${DateTime.parse(approval['requestedOn']).day}/${DateTime.parse(approval['requestedOn']).month}/${DateTime.parse(approval['requestedOn']).year}',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    _handleReject(
                                                      approval['id'],
                                                    );
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 12,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text('Reject'),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    _handleApprove(
                                                      approval['id'],
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 12,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
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
                                elevation: 2,
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
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Recent Activity
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
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
                            const SizedBox(height: 15),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                              child: Column(
                                children: _recentActivity
                                    .map(
                                      (activity) => ListTile(
                                        leading: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: activity['iconBg']
                                                .withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Icon(
                                            activity['icon'],
                                            color: activity['iconColor'],
                                          ),
                                        ),
                                        title: Text(
                                          activity['title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        subtitle: Text(activity['description']),
                                        trailing: Text(
                                          activity['time'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80), // Space for bottom bar
                    ],
                  ),
                ),
                // Other tabs would go here
                const Center(child: Text('Residents Tab')),
                const Center(child: Text('Billing Tab')),
                const Center(child: Text('Complaints Tab')),
                const Center(child: Text('Amenities Tab')),
                const Center(child: Text('Reports Tab')),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add new item
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
            ),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}