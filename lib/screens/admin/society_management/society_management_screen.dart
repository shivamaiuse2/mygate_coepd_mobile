import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocietyManagementScreen extends StatelessWidget {
  const SocietyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Society Management'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage all aspects of your society',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20.h),
              // Grid of management options
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.r,
                mainAxisSpacing: 16.r,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildManagementCard(
                    context,
                    title: 'Flats & Units',
                    icon: Icons.apartment,
                    color: Colors.blue,
                    onTap: () {
                      // Navigate to flats management
                    },
                  ),
                  _buildManagementCard(
                    context,
                    title: 'Towers & Blocks',
                    icon: Icons.business,
                    color: Colors.green,
                    onTap: () {
                      // Navigate to towers management
                    },
                  ),
                  _buildManagementCard(
                    context,
                    title: 'Gates & Entry Points',
                    icon: Icons.security,
                    color: Colors.orange,
                    onTap: () {
                      // Navigate to gates management
                    },
                  ),
                  _buildManagementCard(
                    context,
                    title: 'Amenities',
                    icon: Icons.pool,
                    color: Colors.purple,
                    onTap: () {
                      // Navigate to amenities management
                    },
                  ),
                  _buildManagementCard(
                    context,
                    title: 'Parking',
                    icon: Icons.local_parking,
                    color: Colors.red,
                    onTap: () {
                      // Navigate to parking management
                    },
                  ),
                  _buildManagementCard(
                    context,
                    title: 'Daily Activities',
                    icon: Icons.event,
                    color: Colors.teal,
                    onTap: () {
                      // Navigate to activities management
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManagementCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 32.r,
                color: color,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}