import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinancialReportsScreen extends StatefulWidget {
  const FinancialReportsScreen({super.key});

  @override
  State<FinancialReportsScreen> createState() => _FinancialReportsScreenState();
}

class _FinancialReportsScreenState extends State<FinancialReportsScreen> {
  final List<Map<String, dynamic>> _financialReports = [
    {
      'id': 1,
      'title': 'Monthly Income Statement',
      'period': 'April 2023',
      'generated': '2023-05-01',
      'status': 'Generated',
    },
    {
      'id': 2,
      'title': 'Dues Collection Report',
      'period': 'April 2023',
      'generated': '2023-05-01',
      'status': 'Generated',
    },
    {
      'id': 3,
      'title': 'Expense Summary',
      'period': 'April 2023',
      'generated': '2023-05-02',
      'status': 'Generated',
    },
    {
      'id': 4,
      'title': 'Annual Financial Report',
      'period': 'FY 2022-23',
      'generated': '2023-04-15',
      'status': 'Generated',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Financial summary
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Text(
                        'Financial Summary',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFinancialCard(
                            context,
                            title: 'Total Income',
                            value: '₹4,50,000',
                            icon: Icons.trending_up,
                            color: Colors.green,
                          ),
                          _buildFinancialCard(
                            context,
                            title: 'Total Expenses',
                            value: '₹2,30,000',
                            icon: Icons.trending_down,
                            color: Colors.red,
                          ),
                          _buildFinancialCard(
                            context,
                            title: 'Net Profit',
                            value: '₹2,20,000',
                            icon: Icons.account_balance,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
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
                              '01/04/2023',
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
                              '30/04/2023',
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
              // Financial reports list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Financial Reports',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showGenerateReportDialog(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Generate Report'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _financialReports.length,
                itemBuilder: (context, index) {
                  final report = _financialReports[index];
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
                            'Period: ${report['period']}',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 80.w,
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
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showGenerateReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Generate Financial Report'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Report Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'income_statement', child: Text('Monthly Income Statement')),
                    DropdownMenuItem(
                        value: 'dues_report', child: Text('Dues Collection Report')),
                    DropdownMenuItem(value: 'expense_summary', child: Text('Expense Summary')),
                    DropdownMenuItem(
                        value: 'annual_report', child: Text('Annual Financial Report')),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Report Period',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
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
                // Generate report logic
                Navigator.of(context).pop();
              },
              child: const Text('Generate'),
            ),
          ],
        );
      },
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
              _buildDetailRow('Period', report['period']),
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
}