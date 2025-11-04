import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceProviderPerformanceScreen extends StatefulWidget {
  const ServiceProviderPerformanceScreen({super.key});

  @override
  State<ServiceProviderPerformanceScreen> createState() => _ServiceProviderPerformanceScreenState();
}

class _ServiceProviderPerformanceScreenState extends State<ServiceProviderPerformanceScreen> {
  final List<Map<String, dynamic>> _performanceData = [
    {
      'provider': 'CleanTech Services',
      'completed': 45,
      'pending': 5,
      'cancelled': 2,
      'rating': 4.5,
    },
    {
      'provider': 'SecureGuard Solutions',
      'completed': 62,
      'pending': 3,
      'cancelled': 1,
      'rating': 4.8,
    },
    {
      'provider': 'GreenThumb Landscaping',
      'completed': 28,
      'pending': 7,
      'cancelled': 3,
      'rating': 4.2,
    },
    {
      'provider': 'QuickFix Plumbing',
      'completed': 35,
      'pending': 4,
      'cancelled': 0,
      'rating': 4.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Performance'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Performance summary cards
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Text(
                        'Performance Overview',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPerformanceCard(
                            context,
                            title: 'Total Providers',
                            value: _performanceData.length.toString(),
                            icon: Icons.business,
                            color: Theme.of(context).primaryColor,
                          ),
                          _buildPerformanceCard(
                            context,
                            title: 'Avg. Rating',
                            value: '4.5',
                            icon: Icons.star,
                            color: Colors.orange,
                          ),
                          _buildPerformanceCard(
                            context,
                            title: 'Completed Tasks',
                            value: _performanceData.fold<int>(0, (sum, item) => sum + item['completed'] as int).toString(),
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Performance charts
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
                        'Task Completion Rate',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Chart placeholder - would require external charting library
                      Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            'Performance Chart Visualization',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Detailed performance table
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
                        'Detailed Performance',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20.w,
                          headingRowColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          columns: const [
                            DataColumn(label: Text('Provider')),
                            DataColumn(label: Text('Completed')),
                            DataColumn(label: Text('Pending')),
                            DataColumn(label: Text('Cancelled')),
                            DataColumn(label: Text('Rating')),
                          ],
                          rows: _performanceData.map((provider) {
                            return DataRow(
                              cells: [
                                DataCell(Text(provider['provider'])),
                                DataCell(Text(provider['completed'].toString())),
                                DataCell(Text(provider['pending'].toString())),
                                DataCell(Text(provider['cancelled'].toString())),
                                DataCell(
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.orange, size: 16),
                                      Text(' ${provider['rating']}'),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
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

  Widget _buildPerformanceCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24.r,
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}