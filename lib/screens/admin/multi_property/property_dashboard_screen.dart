import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyDashboardScreen extends StatefulWidget {
  const PropertyDashboardScreen({super.key});

  @override
  State<PropertyDashboardScreen> createState() => _PropertyDashboardScreenState();
}

class _PropertyDashboardScreenState extends State<PropertyDashboardScreen> {
  final Map<String, dynamic> _selectedProperty = {
    'id': 1,
    'name': 'Green Valley Apartments',
    'location': 'Mumbai, Maharashtra',
    'units': 120,
    'residents': 450,
    'status': 'Active',
  };

  final List<Map<String, dynamic>> _propertyStats = [
    {
      'title': 'Total Residents',
      'value': '450',
      'change': '+12',
      'isIncrease': true,
      'icon': Icons.people,
      'color': Colors.blue,
    },
    {
      'title': 'Pending Approvals',
      'value': '8',
      'change': '+3',
      'isIncrease': true,
      'icon': Icons.checklist,
      'color': Colors.orange,
    },
    {
      'title': 'Active Complaints',
      'value': '5',
      'change': '-2',
      'isIncrease': false,
      'icon': Icons.report_problem,
      'color': Colors.red,
    },
    {
      'title': 'Collection Rate',
      'value': '88%',
      'change': '+3%',
      'isIncrease': true,
      'icon': Icons.credit_card,
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.people, 'label': 'Residents'},
    {'icon': Icons.description, 'label': 'Reports'},
    {'icon': Icons.notifications, 'label': 'Notices'},
    {'icon': Icons.home, 'label': 'Society'},
    {'icon': Icons.calendar_today, 'label': 'Events'},
    {'icon': Icons.credit_card, 'label': 'Payments'},
    {'icon': Icons.bar_chart, 'label': 'Analytics'},
    {'icon': Icons.checklist, 'label': 'Tasks'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedProperty['name']),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle property selection
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'property1',
                child: Text('Green Valley Apartments'),
              ),
              const PopupMenuItem(
                value: 'property2',
                child: Text('Sunshine Residency'),
              ),
              const PopupMenuItem(
                value: 'property3',
                child: Text('Royal Gardens'),
              ),
            ],
            child: const Icon(Icons.business),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property info
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            _selectedProperty['location'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _buildPropertyInfo(
                            context,
                            title: 'Units',
                            value: _selectedProperty['units'].toString(),
                            icon: Icons.apartment,
                          ),
                          SizedBox(width: 20.w),
                          _buildPropertyInfo(
                            context,
                            title: 'Residents',
                            value: _selectedProperty['residents'].toString(),
                            icon: Icons.people,
                          ),
                          SizedBox(width: 20.w),
                          _buildPropertyInfo(
                            context,
                            title: 'Status',
                            value: _selectedProperty['status'],
                            icon: Icons.check_circle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Stats cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: _propertyStats.length,
                itemBuilder: (context, index) {
                  final stat = _propertyStats[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: stat['color'].withOpacity(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(height: 20.h),
              // Quick actions
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                itemCount: _quickActions.length,
                itemBuilder: (context, index) {
                  final item = _quickActions[index];
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
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
                      SizedBox(height: 8.h),
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
      ),
    );
  }

  Widget _buildPropertyInfo(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
        SizedBox(width: 4.w),
        Text(
          '$title: $value',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}