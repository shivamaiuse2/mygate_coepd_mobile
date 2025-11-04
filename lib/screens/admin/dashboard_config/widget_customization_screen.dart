import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetCustomizationScreen extends StatefulWidget {
  const WidgetCustomizationScreen({super.key});

  @override
  State<WidgetCustomizationScreen> createState() => _WidgetCustomizationScreenState();
}

class _WidgetCustomizationScreenState extends State<WidgetCustomizationScreen> {
  // Sample widget configurations
  final List<Map<String, dynamic>> _widgetConfigs = [
    {
      'id': 1,
      'title': 'Resident Statistics',
      'refreshInterval': '15 minutes',
      'dataRange': 'Last 30 days',
      'displayType': 'Chart',
      'notifications': true,
    },
    {
      'id': 2,
      'title': 'Financial Overview',
      'refreshInterval': '1 hour',
      'dataRange': 'Current month',
      'displayType': 'Summary Cards',
      'notifications': true,
    },
    {
      'id': 3,
      'title': 'Attendance Summary',
      'refreshInterval': 'Daily',
      'dataRange': 'Current week',
      'displayType': 'Table',
      'notifications': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Customization'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customization instructions
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
                        'Customize Widget Settings',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Adjust settings for each widget on your dashboard to match your preferences.',
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
              // Widget configurations list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _widgetConfigs.length,
                itemBuilder: (context, index) {
                  final config = _widgetConfigs[index];
                  return Card(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                config['title'],
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showCustomizationDialog(context, config);
                                },
                                icon: const Icon(Icons.settings),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          _buildConfigRow('Refresh Interval', config['refreshInterval']),
                          _buildConfigRow('Data Range', config['dataRange']),
                          _buildConfigRow('Display Type', config['displayType']),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                value: config['notifications'],
                                onChanged: (value) {
                                  setState(() {
                                    config['notifications'] = value;
                                  });
                                },
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
              // Reset to default button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    _confirmResetToDefault(context);
                  },
                  child: const Text('Reset to Default Settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.r),
      child: Row(
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
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

  void _showCustomizationDialog(BuildContext context, Map<String, dynamic> config) {
    final refreshIntervalController = TextEditingController(text: config['refreshInterval']);
    final dataRangeController = TextEditingController(text: config['dataRange']);
    final displayTypeController = TextEditingController(text: config['displayType']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Customize ${config['title']}'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: refreshIntervalController,
                  decoration: InputDecoration(
                    labelText: 'Refresh Interval',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: dataRangeController,
                  decoration: InputDecoration(
                    labelText: 'Data Range',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  value: config['displayType'],
                  decoration: InputDecoration(
                    labelText: 'Display Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Chart', child: Text('Chart')),
                    DropdownMenuItem(value: 'Summary Cards', child: Text('Summary Cards')),
                    DropdownMenuItem(value: 'Table', child: Text('Table')),
                    DropdownMenuItem(value: 'List', child: Text('List')),
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
                // Save customization logic
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmResetToDefault(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset to Default'),
          content: const Text(
              'Are you sure you want to reset all widget settings to their default values?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Reset to default logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Widget settings reset to default'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}