import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacialRecognitionScreen extends StatefulWidget {
  const FacialRecognitionScreen({super.key});

  @override
  State<FacialRecognitionScreen> createState() => _FacialRecognitionScreenState();
}

class _FacialRecognitionScreenState extends State<FacialRecognitionScreen> {
  bool _facialRecognitionEnabled = true;
  bool _proxyDetectionEnabled = true;
  bool _doubleShiftDetectionEnabled = true;

  final List<Map<String, dynamic>> _registeredStaff = [
    {
      'id': 1,
      'name': 'Ramesh Kumar',
      'role': 'Security Guard',
      'registered': true,
      'photo': 'staff_photo_001.jpg',
    },
    {
      'id': 2,
      'name': 'Suresh Patel',
      'role': 'Cleaner',
      'registered': true,
      'photo': 'staff_photo_002.jpg',
    },
    {
      'id': 3,
      'name': 'Mahesh Gupta',
      'role': 'Gardener',
      'registered': false,
      'photo': 'staff_photo_003.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facial Recognition Setup'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Facial recognition description
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
                        'Facial Recognition System',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Configure facial recognition settings and manage staff face registrations.',
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
              // System settings
              Text(
                'System Settings',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildSettingCard(
                context,
                title: 'Facial Recognition',
                description: 'Enable/disable facial recognition for attendance',
                value: _facialRecognitionEnabled,
                onChanged: (value) {
                  setState(() {
                    _facialRecognitionEnabled = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildSettingCard(
                context,
                title: 'Proxy Detection',
                description: 'Detect and prevent proxy attendance',
                value: _proxyDetectionEnabled,
                onChanged: (value) {
                  setState(() {
                    _proxyDetectionEnabled = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildSettingCard(
                context,
                title: 'Double Shift Detection',
                description: 'Detect and prevent double shift attendance',
                value: _doubleShiftDetectionEnabled,
                onChanged: (value) {
                  setState(() {
                    _doubleShiftDetectionEnabled = value;
                  });
                },
              ),
              SizedBox(height: 30.h),
              // Registered staff
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Registered Staff',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showRegisterStaffDialog(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Register Staff'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _registeredStaff.length,
                itemBuilder: (context, index) {
                  final staff = _registeredStaff[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Row(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30.r,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  staff['name'],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  staff['role'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
                            decoration: BoxDecoration(
                              color: staff['registered'] 
                                  ? Colors.green.withOpacity(0.1) 
                                  : Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              staff['registered'] ? 'Registered' : 'Pending',
                              style: TextStyle(
                                color: staff['registered'] ? Colors.green : Colors.orange,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'view') {
                                _viewStaffDetails(context, staff);
                              } else if (value == 'unregister') {
                                _unregisterStaff(context, staff);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'view',
                                child: Text('View Details'),
                              ),
                              if (staff['registered'])
                                const PopupMenuItem(
                                  value: 'unregister',
                                  child: Text('Unregister'),
                                ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildSettingCard(
    BuildContext context, {
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: value,
                  onChanged: onChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRegisterStaffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Staff for Facial Recognition'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Staff',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: _registeredStaff.where((staff) => !staff['registered']).map((staff) {
                    return DropdownMenuItem(
                      value: staff['id'].toString(),
                      child: Text(staff['name']),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                const Text(
                  'Instructions:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1. Ask the staff member to look directly at the camera\n'
                  '2. Ensure good lighting conditions\n'
                  '3. Capture multiple angles of the face\n'
                  '4. Confirm registration after capturing',
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
                // Register staff logic
                Navigator.of(context).pop();
              },
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }

  void _viewStaffDetails(BuildContext context, Map<String, dynamic> staff) {
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
                    staff['name'],
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
              Center(
                child: Container(
                  width: 150.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(75.r),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 80.r,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              _buildDetailRow('Role', staff['role']),
              _buildDetailRow('Registration Status', staff['registered'] ? 'Registered' : 'Pending'),
              SizedBox(height: 20.h),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
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
            width: 150.w,
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

  void _unregisterStaff(BuildContext context, Map<String, dynamic> staff) {
    // Unregister staff logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unregister Staff'),
          content: Text('Are you sure you want to unregister ${staff['name']} from facial recognition?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${staff['name']} unregistered from facial recognition'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Unregister'),
            ),
          ],
        );
      },
    );
  }
}