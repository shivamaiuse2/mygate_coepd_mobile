import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmenitiesManagementScreen extends StatefulWidget {
  const AmenitiesManagementScreen({super.key});

  @override
  State<AmenitiesManagementScreen> createState() => _AmenitiesManagementScreenState();
}

class _AmenitiesManagementScreenState extends State<AmenitiesManagementScreen> {
  final List<Map<String, dynamic>> _amenities = [
    {
      'id': 1,
      'name': 'Swimming Pool',
      'type': 'Recreational',
      'status': 'Available',
      'capacity': 50,
      'image': 'pool',
    },
    {
      'id': 2,
      'name': 'Gym',
      'type': 'Fitness',
      'status': 'Available',
      'capacity': 30,
      'image': 'gym',
    },
    {
      'id': 3,
      'name': 'Club House',
      'type': 'Event',
      'status': 'Booked',
      'capacity': 100,
      'image': 'clubhouse',
    },
    {
      'id': 4,
      'name': 'Tennis Court',
      'type': 'Sports',
      'status': 'Maintenance',
      'capacity': 4,
      'image': 'tennis',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amenities Management'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          hintText: 'Search amenities...',
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
                                labelText: 'Type',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Types')),
                                DropdownMenuItem(value: 'recreational', child: Text('Recreational')),
                                DropdownMenuItem(value: 'fitness', child: Text('Fitness')),
                                DropdownMenuItem(value: 'sports', child: Text('Sports')),
                                DropdownMenuItem(value: 'event', child: Text('Event')),
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
                                DropdownMenuItem(value: 'booked', child: Text('Booked')),
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
              // Amenities list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amenities (${_amenities.length})',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddAmenityDialog(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Amenity'),
                  ),
                ],
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
                itemCount: _amenities.length,
                itemBuilder: (context, index) {
                  final amenity = _amenities[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              _getAmenityIcon(amenity['name']),
                              size: 40.r,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            amenity['name'],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            amenity['type'],
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${amenity['capacity']} people',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.r,
                                  vertical: 4.r,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(amenity['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  amenity['status'],
                                  style: TextStyle(
                                    color: _getStatusColor(amenity['status']),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // View bookings
                                },
                                icon: const Icon(Icons.calendar_today, size: 18),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditAmenityDialog(context, amenity);
                                  } else if (value == 'delete') {
                                    _confirmDeleteAmenity(context, amenity);
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
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

  IconData _getAmenityIcon(String name) {
    switch (name.toLowerCase()) {
      case 'swimming pool':
        return Icons.pool;
      case 'gym':
        return Icons.fitness_center;
      case 'club house':
        return Icons.house;
      case 'tennis court':
        return Icons.sports_tennis;
      default:
        return Icons.apartment;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'booked':
        return Colors.orange;
      case 'maintenance':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddAmenityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Amenity'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amenity Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'recreational', child: Text('Recreational')),
                    DropdownMenuItem(value: 'fitness', child: Text('Fitness')),
                    DropdownMenuItem(value: 'sports', child: Text('Sports')),
                    DropdownMenuItem(value: 'event', child: Text('Event')),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Capacity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  keyboardType: TextInputType.number,
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
                // Add amenity logic
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAmenityDialog(BuildContext context, Map<String, dynamic> amenity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Amenity'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amenity Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  controller: TextEditingController(text: amenity['name']),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'recreational', child: Text('Recreational')),
                    DropdownMenuItem(value: 'fitness', child: Text('Fitness')),
                    DropdownMenuItem(value: 'sports', child: Text('Sports')),
                    DropdownMenuItem(value: 'event', child: Text('Event')),
                  ],
                  value: amenity['type'].toString().toLowerCase(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Capacity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  controller: TextEditingController(text: amenity['capacity'].toString()),
                  keyboardType: TextInputType.number,
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
                // Edit amenity logic
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteAmenity(BuildContext context, Map<String, dynamic> amenity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Amenity'),
          content: Text(
              'Are you sure you want to delete ${amenity['name']}? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Delete amenity logic
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
}