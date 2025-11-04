import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParkingManagementScreen extends StatefulWidget {
  const ParkingManagementScreen({super.key});

  @override
  State<ParkingManagementScreen> createState() => _ParkingManagementScreenState();
}

class _ParkingManagementScreenState extends State<ParkingManagementScreen> {
  final List<Map<String, dynamic>> _parkingSlots = [
    {
      'id': 1,
      'slotNumber': 'P-101',
      'type': 'Car',
      'status': 'Occupied',
      'owner': 'Rajesh Kumar (A-101)',
    },
    {
      'id': 2,
      'slotNumber': 'P-102',
      'type': 'Car',
      'status': 'Available',
      'owner': '',
    },
    {
      'id': 3,
      'slotNumber': 'P-103',
      'type': 'Bike',
      'status': 'Occupied',
      'owner': 'Priya Sharma (A-102)',
    },
    {
      'id': 4,
      'slotNumber': 'P-104',
      'type': 'Car',
      'status': 'Maintenance',
      'owner': '',
    },
    {
      'id': 5,
      'slotNumber': 'P-105',
      'type': 'Bike',
      'status': 'Available',
      'owner': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate statistics
    int totalSlots = _parkingSlots.length;
    int occupiedSlots = _parkingSlots.where((slot) => slot['status'] == 'Occupied').length;
    int availableSlots = _parkingSlots.where((slot) => slot['status'] == 'Available').length;
    int maintenanceSlots = _parkingSlots.where((slot) => slot['status'] == 'Maintenance').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Management'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Parking statistics
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
                          _buildStatCard(
                            context,
                            title: 'Total Slots',
                            value: totalSlots.toString(),
                            icon: Icons.local_parking,
                            color: Theme.of(context).primaryColor,
                          ),
                          _buildStatCard(
                            context,
                            title: 'Occupied',
                            value: occupiedSlots.toString(),
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                          _buildStatCard(
                            context,
                            title: 'Available',
                            value: availableSlots.toString(),
                            icon: Icons.radio_button_unchecked,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildStatCard(
                        context,
                        title: 'Under Maintenance',
                        value: maintenanceSlots.toString(),
                        icon: Icons.build,
                        color: Colors.red,
                        fullWidth: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Search and filter section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search parking slots...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Slot Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Types')),
                                DropdownMenuItem(value: 'car', child: Text('Car')),
                                DropdownMenuItem(value: 'bike', child: Text('Bike')),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Status')),
                                DropdownMenuItem(value: 'available', child: Text('Available')),
                                DropdownMenuItem(value: 'occupied', child: Text('Occupied')),
                                DropdownMenuItem(value: 'maintenance', child: Text('Maintenance')),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Parking slots list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Parking Slots',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddSlotDialog(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Slot'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _parkingSlots.length,
                itemBuilder: (context, index) {
                  final slot = _parkingSlots[index];
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
                                slot['slotNumber'],
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.r,
                                  vertical: 6.r,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(slot['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  slot['status'],
                                  style: TextStyle(
                                    color: _getStatusColor(slot['status']),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(
                                slot['type'] == 'Car' ? Icons.directions_car : Icons.motorcycle,
                                size: 16,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                slot['type'],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          if (slot['owner'].isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  slot['owner'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (slot['status'] == 'Available')
                                OutlinedButton(
                                  onPressed: () {
                                    _assignSlotDialog(context, slot);
                                  },
                                  child: const Text('Assign'),
                                ),
                              if (slot['status'] == 'Occupied')
                                OutlinedButton(
                                  onPressed: () {
                                    _releaseSlot(context, slot);
                                  },
                                  child: const Text('Release'),
                                ),
                              SizedBox(width: 12.w),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditSlotDialog(context, slot);
                                  } else if (value == 'delete') {
                                    _confirmDeleteSlot(context, slot);
                                  } else if (value == 'maintenance') {
                                    _toggleMaintenance(context, slot);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'maintenance',
                                    child: Text('Toggle Maintenance'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
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

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24.r,
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'occupied':
        return Colors.orange;
      case 'maintenance':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddSlotDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Parking Slot'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Slot Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Slot Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'car', child: Text('Car')),
                    DropdownMenuItem(value: 'bike', child: Text('Bike')),
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
                // Add slot logic
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditSlotDialog(BuildContext context, Map<String, dynamic> slot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Parking Slot'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Slot Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  controller: TextEditingController(text: slot['slotNumber']),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Slot Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'car', child: Text('Car')),
                    DropdownMenuItem(value: 'bike', child: Text('Bike')),
                  ],
                  value: slot['type'].toString().toLowerCase(),
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
                // Edit slot logic
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _assignSlotDialog(BuildContext context, Map<String, dynamic> slot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assign Parking Slot'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Owner Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Flat/Unit Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
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
                // Assign slot logic
                Navigator.of(context).pop();
              },
              child: const Text('Assign'),
            ),
          ],
        );
      },
    );
  }

  void _releaseSlot(BuildContext context, Map<String, dynamic> slot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Release Parking Slot'),
          content: Text('Are you sure you want to release ${slot['slotNumber']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Release slot logic
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Release'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteSlot(BuildContext context, Map<String, dynamic> slot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Parking Slot'),
          content: Text(
              'Are you sure you want to delete ${slot['slotNumber']}? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Delete slot logic
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _toggleMaintenance(BuildContext context, Map<String, dynamic> slot) {
    // Toggle maintenance status logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Maintenance status toggled for ${slot['slotNumber']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}