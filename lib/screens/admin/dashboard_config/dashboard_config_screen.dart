import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardConfigScreen extends StatefulWidget {
  const DashboardConfigScreen({super.key});

  @override
  State<DashboardConfigScreen> createState() => _DashboardConfigScreenState();
}

class _DashboardConfigScreenState extends State<DashboardConfigScreen> {
  // Available widgets that can be added to the dashboard
  final List<Map<String, dynamic>> _availableWidgets = [
    {
      'id': 1,
      'title': 'Resident Statistics',
      'description': 'View resident count and distribution',
      'icon': Icons.people,
      'category': 'Residents',
    },
    {
      'id': 2,
      'title': 'Financial Overview',
      'description': 'Track income, expenses and dues',
      'icon': Icons.account_balance_wallet,
      'category': 'Finance',
    },
    {
      'id': 3,
      'title': 'Attendance Summary',
      'description': 'Staff attendance and punctuality',
      'icon': Icons.check_circle,
      'category': 'Staff',
    },
    {
      'id': 4,
      'title': 'Service Requests',
      'description': 'Track maintenance and service requests',
      'icon': Icons.build,
      'category': 'Maintenance',
    },
    {
      'id': 5,
      'title': 'Visitor Logs',
      'description': 'Monitor visitor entries and exits',
      'icon': Icons.security,
      'category': 'Security',
    },
    {
      'id': 6,
      'title': 'Amenity Usage',
      'description': 'Track amenity bookings and usage',
      'icon': Icons.pool,
      'category': 'Amenities',
    },
    {
      'id': 7,
      'title': 'Notice Board',
      'description': 'View and manage announcements',
      'icon': Icons.campaign,
      'category': 'Communication',
    },
    {
      'id': 8,
      'title': 'Complaints Tracker',
      'description': 'Monitor and resolve complaints',
      'icon': Icons.report_problem,
      'category': 'Maintenance',
    },
  ];

  // Currently selected widgets for the dashboard
  List<Map<String, dynamic>> _selectedWidgets = [
    {
      'id': 1,
      'title': 'Resident Statistics',
      'description': 'View resident count and distribution',
      'icon': Icons.people,
      'category': 'Residents',
    },
    {
      'id': 2,
      'title': 'Financial Overview',
      'description': 'Track income, expenses and dues',
      'icon': Icons.account_balance_wallet,
      'category': 'Finance',
    },
    {
      'id': 5,
      'title': 'Visitor Logs',
      'description': 'Monitor visitor entries and exits',
      'icon': Icons.security,
      'category': 'Security',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Configuration'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Configuration instructions
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customize Your Dashboard',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Drag and drop widgets to rearrange them. Add or remove widgets to personalize your dashboard.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Selected widgets section
              Text(
                'Selected Widgets',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              if (_selectedWidgets.isEmpty)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inbox,
                          size: 48.r,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No widgets selected',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Add widgets from the available list below',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = _selectedWidgets.removeAt(oldIndex);
                      _selectedWidgets.insert(newIndex, item);
                    });
                  },
                  children: _selectedWidgets.map((widget) {
                    return _buildSelectedWidgetCard(context, widget);
                  }).toList(),
                ),
              SizedBox(height: 30.h),
              // Available widgets section
              Text(
                'Available Widgets',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.r,
                  mainAxisSpacing: 16.r,
                  childAspectRatio: 0.85,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _availableWidgets.length,
                itemBuilder: (context, index) {
                  final widget = _availableWidgets[index];
                  final isSelected = _selectedWidgets.any((w) => w['id'] == widget['id']);
                  return _buildAvailableWidgetCard(context, widget, isSelected);
                },
              ),
              SizedBox(height: 30.h),
              // Save configuration button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Save configuration logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Dashboard configuration saved successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Save Configuration'),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedWidgetCard(BuildContext context, Map<String, dynamic> widget) {
    return Card(
      key: ValueKey(widget['id']),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget['icon'],
                  size: 24.r,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget['title'],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedWidgets.removeWhere((w) => w['id'] == widget['id']);
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
                const Icon(Icons.drag_handle),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              widget['description'],
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
              decoration: BoxDecoration(
                color: _getCategoryColor(widget['category']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget['category'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: _getCategoryColor(widget['category']),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableWidgetCard(
      BuildContext context, Map<String, dynamic> widget, bool isSelected) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: isSelected ? 0 : 2,
      color: isSelected ? Colors.grey[100] : null,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                widget['icon'],
                size: 32.r,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              widget['title'],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              widget['description'],
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
              decoration: BoxDecoration(
                color: _getCategoryColor(widget['category']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget['category'],
                style: TextStyle(
                  fontSize: 10.sp,
                  color: _getCategoryColor(widget['category']),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isSelected
                    ? null
                    : () {
                        setState(() {
                          _selectedWidgets.add(widget);
                        });
                      },
                child: Text(
                  isSelected ? 'Added' : 'Add Widget',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'residents':
        return Colors.blue;
      case 'finance':
        return Colors.green;
      case 'staff':
        return Colors.orange;
      case 'maintenance':
        return Colors.purple;
      case 'security':
        return Colors.red;
      case 'amenities':
        return Colors.teal;
      case 'communication':
        return Colors.indigo;
      default:
        return Theme.of(context).primaryColor;
    }
  }
}