import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminControlsScreen extends StatefulWidget {
  const AdminControlsScreen({super.key});

  @override
  State<AdminControlsScreen> createState() => _AdminControlsScreenState();
}

class _AdminControlsScreenState extends State<AdminControlsScreen> {
  bool _residentRegistrationApproval = true;
  bool _visitorManagement = true;
  bool _amenityBooking = true;
  bool _serviceRequests = true;
  bool _notices = true;
  bool _payments = true;
  bool _communityFeatures = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin App Controls'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Controls description
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
                        'Application Controls',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Enable or disable various features and functionalities of the admin application.',
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
              // Feature controls
              Text(
                'Feature Controls',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Resident Registration Approval',
                description: 'Require admin approval for new resident registrations',
                value: _residentRegistrationApproval,
                onChanged: (value) {
                  setState(() {
                    _residentRegistrationApproval = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Visitor Management',
                description: 'Enable visitor entry and exit tracking',
                value: _visitorManagement,
                onChanged: (value) {
                  setState(() {
                    _visitorManagement = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Amenity Booking',
                description: 'Allow residents to book society amenities',
                value: _amenityBooking,
                onChanged: (value) {
                  setState(() {
                    _amenityBooking = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Service Requests',
                description: 'Enable residents to submit maintenance requests',
                value: _serviceRequests,
                onChanged: (value) {
                  setState(() {
                    _serviceRequests = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Notices & Announcements',
                description: 'Allow posting of society notices and announcements',
                value: _notices,
                onChanged: (value) {
                  setState(() {
                    _notices = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Payments & Dues',
                description: 'Enable payment collection and dues tracking',
                value: _payments,
                onChanged: (value) {
                  setState(() {
                    _payments = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Community Features',
                description: 'Enable community interaction features',
                value: _communityFeatures,
                onChanged: (value) {
                  setState(() {
                    _communityFeatures = value;
                  });
                },
              ),
              SizedBox(height: 30.h),
              // Security controls
              Text(
                'Security Controls',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Two-Factor Authentication',
                description: 'Require 2FA for admin login',
                value: true,
                onChanged: (value) {
                  // Handle 2FA toggle
                },
              ),
              SizedBox(height: 16.h),
              _buildControlCard(
                context,
                title: 'Session Timeout',
                description: 'Automatically logout after inactivity',
                value: true,
                onChanged: (value) {
                  // Handle session timeout toggle
                },
              ),
              SizedBox(height: 30.h),
              // Save controls button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Save controls logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Admin controls updated successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('Save Controls'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlCard(
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
}