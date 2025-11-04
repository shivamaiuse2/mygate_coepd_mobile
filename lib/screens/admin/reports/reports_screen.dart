import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final List<Map<String, dynamic>> _reportCategories = [
    {
      'id': 1,
      'title': 'Financial Reports',
      'description': 'Income, expenses, dues tracking',
      'icon': Icons.account_balance_wallet,
      'color': Colors.green,
    },
    {
      'id': 2,
      'title': 'Resident Reports',
      'description': 'Demographics, occupancy, activity',
      'icon': Icons.people,
      'color': Colors.blue,
    },
    {
      'id': 3,
      'title': 'Staff Reports',
      'description': 'Attendance, performance, payroll',
      'icon': Icons.badge,
      'color': Colors.orange,
    },
    {
      'id': 4,
      'title': 'Security Reports',
      'description': 'Visitor logs, incidents, patrols',
      'icon': Icons.security,
      'color': Colors.red,
    },
    {
      'id': 5,
      'title': 'Maintenance Reports',
      'description': 'Service requests, repairs, vendors',
      'icon': Icons.build,
      'color': Colors.purple,
    },
    {
      'id': 6,
      'title': 'Amenity Reports',
      'description': 'Usage statistics, bookings, revenue',
      'icon': Icons.pool,
      'color': Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> _recentReports = [
    {
      'id': 1,
      'title': 'Monthly Financial Summary',
      'category': 'Financial Reports',
      'generated': '2023-05-01',
      'status': 'Generated',
    },
    {
      'id': 2,
      'title': 'Resident Demographics',
      'category': 'Resident Reports',
      'generated': '2023-04-28',
      'status': 'Generated',
    },
    {
      'id': 3,
      'title': 'Staff Attendance Report',
      'category': 'Staff Reports',
      'generated': '2023-05-02',
      'status': 'Generated',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comprehensive Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Report categories
              Text(
                'Report Categories',
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
                itemCount: _reportCategories.length,
                itemBuilder: (context, index) {
                  final category = _reportCategories[index];
                  return _buildCategoryCard(context, category);
                },
              ),
              SizedBox(height: 30.h),
              // Recent reports
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Reports',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // View all reports
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recentReports.length,
                itemBuilder: (context, index) {
                  final report = _recentReports[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.r),
                      title: Text(
                        report['title'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),
                          Text(
                            report['category'],
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Generated: ${report['generated']}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          report['status'],
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      onTap: () {
                        _viewReportDetails(context, report);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              // Generate custom report
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
                        'Generate Custom Report',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Create a custom report by selecting specific data points, date ranges, and filters.',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () {
                          _showCustomReportDialog(context);
                        },
                        child: const Text('Create Custom Report'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: () {
          _navigateToCategoryReports(context, category);
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  category['icon'],
                  size: 32.r,
                  color: category['color'],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                category['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                category['description'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCategoryReports(BuildContext context, Map<String, dynamic> category) {
    // Navigate to specific category reports screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to ${category['title']}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _viewReportDetails(BuildContext context, Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    report['title'],
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildDetailRow('Category', report['category']),
              _buildDetailRow('Generated', report['generated']),
              _buildDetailRow('Status', report['status']),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      // View report
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text('View'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Download report
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Share report
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Share'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.r),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            ': ',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Custom Report'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Report Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: _reportCategories.map((category) {
                    return DropdownMenuItem(
                      value: category['id'].toString(),
                      child: Text(category['title']),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Report Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Date Range',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Open date range picker
                  },
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Format',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'pdf', child: Text('PDF')),
                    DropdownMenuItem(value: 'excel', child: Text('Excel')),
                    DropdownMenuItem(value: 'csv', child: Text('CSV')),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Generate custom report logic
                Navigator.of(context).pop();
              },
              child: const Text('Generate'),
            ),
          ],
        );
      },
    );
  }
}