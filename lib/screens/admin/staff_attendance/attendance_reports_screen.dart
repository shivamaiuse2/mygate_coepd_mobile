import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceReportsScreen extends StatefulWidget {
  const AttendanceReportsScreen({super.key});

  @override
  State<AttendanceReportsScreen> createState() => _AttendanceReportsScreenState();
}

class _AttendanceReportsScreenState extends State<AttendanceReportsScreen> {
  final List<Map<String, dynamic>> _attendanceReports = [
    {
      'date': '2023-05-01',
      'present': 12,
      'absent': 3,
      'leave': 1,
      'total': 16,
    },
    {
      'date': '2023-05-02',
      'present': 14,
      'absent': 1,
      'leave': 1,
      'total': 16,
    },
    {
      'date': '2023-05-03',
      'present': 13,
      'absent': 2,
      'leave': 1,
      'total': 16,
    },
    {
      'date': '2023-05-04',
      'present': 15,
      'absent': 0,
      'leave': 1,
      'total': 16,
    },
    {
      'date': '2023-05-05',
      'present': 11,
      'absent': 3,
      'leave': 2,
      'total': 16,
    },
  ];

  final List<Map<String, dynamic>> _individualReports = [
    {
      'name': 'Ramesh Kumar',
      'role': 'Security Guard',
      'present': 22,
      'absent': 3,
      'leave': 1,
      'total': 26,
      'attendanceRate': '84.6%',
    },
    {
      'name': 'Suresh Patel',
      'role': 'Cleaner',
      'present': 24,
      'absent': 1,
      'leave': 1,
      'total': 26,
      'attendanceRate': '92.3%',
    },
    {
      'name': 'Mahesh Gupta',
      'role': 'Gardener',
      'present': 20,
      'absent': 4,
      'leave': 2,
      'total': 26,
      'attendanceRate': '76.9%',
    },
    {
      'name': 'Vikram Singh',
      'role': 'Plumber',
      'present': 25,
      'absent': 0,
      'leave': 1,
      'total': 26,
      'attendanceRate': '96.2%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date range selector
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'From Date',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '01/05/2023',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.grey[400]),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'To Date',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '31/05/2023',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Open date range picker
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Summary cards
              Text(
                'Attendance Summary',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSummaryCard(
                            context,
                            title: 'Total Staff',
                            value: '16',
                            icon: Icons.people,
                            color: Theme.of(context).primaryColor,
                          ),
                          _buildSummaryCard(
                            context,
                            title: 'Avg. Attendance',
                            value: '85%',
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                          _buildSummaryCard(
                            context,
                            title: 'Leave Requests',
                            value: '12',
                            icon: Icons.event_busy,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Daily attendance report
              Text(
                'Daily Attendance Report',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20.w,
                      headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                      columns: const [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Present')),
                        DataColumn(label: Text('Absent')),
                        DataColumn(label: Text('Leave')),
                        DataColumn(label: Text('Total')),
                      ],
                      rows: _attendanceReports.map((report) {
                        return DataRow(
                          cells: [
                            DataCell(Text(report['date'])),
                            DataCell(Text(report['present'].toString())),
                            DataCell(Text(report['absent'].toString())),
                            DataCell(Text(report['leave'].toString())),
                            DataCell(Text(report['total'].toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Individual staff report
              Text(
                'Individual Staff Report',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20.w,
                      headingRowColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Role')),
                        DataColumn(label: Text('Present')),
                        DataColumn(label: Text('Absent')),
                        DataColumn(label: Text('Leave')),
                        DataColumn(label: Text('Total')),
                        DataColumn(label: Text('Rate')),
                      ],
                      rows: _individualReports.map((report) {
                        return DataRow(
                          cells: [
                            DataCell(Text(report['name'])),
                            DataCell(Text(report['role'])),
                            DataCell(Text(report['present'].toString())),
                            DataCell(Text(report['absent'].toString())),
                            DataCell(Text(report['leave'].toString())),
                            DataCell(Text(report['total'].toString())),
                            DataCell(Text(report['attendanceRate'])),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Export options
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Export report logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Report exported successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Export Report'),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
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