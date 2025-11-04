import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationApprovalScreen extends StatefulWidget {
  const RegistrationApprovalScreen({super.key});

  @override
  State<RegistrationApprovalScreen> createState() => _RegistrationApprovalScreenState();
}

class _RegistrationApprovalScreenState extends State<RegistrationApprovalScreen> {
  final List<Map<String, dynamic>> _pendingApprovals = [
    {
      'id': 1,
      'name': 'Rajesh Kumar',
      'unit': 'A-101',
      'phone': '+91 9876543210',
      'email': 'rajesh.kumar@email.com',
      'requestDate': '2023-05-01',
      'document': 'id_proof_001.pdf',
    },
    {
      'id': 2,
      'name': 'Priya Sharma',
      'unit': 'B-201',
      'phone': '+91 9876543211',
      'email': 'priya.sharma@email.com',
      'requestDate': '2023-05-02',
      'document': 'id_proof_002.pdf',
    },
    {
      'id': 3,
      'name': 'Amit Patel',
      'unit': 'C-301',
      'phone': '+91 9876543212',
      'email': 'amit.patel@email.com',
      'requestDate': '2023-05-03',
      'document': 'id_proof_003.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Approvals'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Approval summary
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Text(
                        'Approval Summary',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildApprovalCard(
                            context,
                            title: 'Pending',
                            value: _pendingApprovals.length.toString(),
                            icon: Icons.pending,
                            color: Colors.orange,
                          ),
                          _buildApprovalCard(
                            context,
                            title: 'Approved Today',
                            value: '5',
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                          _buildApprovalCard(
                            context,
                            title: 'Rejected Today',
                            value: '2',
                            icon: Icons.cancel,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Search section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search pending approvals...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Pending approvals list
              Text(
                'Pending Approvals (${_pendingApprovals.length})',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              if (_pendingApprovals.isEmpty)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 48.r,
                          color: Colors.green,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No pending approvals',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'All registration requests have been processed',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pendingApprovals.length,
                  itemBuilder: (context, index) {
                    final approval = _pendingApprovals[index];
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
                                  approval['name'],
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
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Unit: ${approval['unit']}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  approval['phone'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  approval['email'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Requested: ${approval['requestDate']}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    _viewDocument(context, approval);
                                  },
                                  child: const Text('View Document'),
                                ),
                                SizedBox(width: 12.w),
                                OutlinedButton(
                                  onPressed: () {
                                    _viewDetails(context, approval);
                                  },
                                  child: const Text('View Details'),
                                ),
                                SizedBox(width: 12.w),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'approve') {
                                      _approveRegistration(context, approval);
                                    } else if (value == 'reject') {
                                      _rejectRegistration(context, approval);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'approve',
                                      child: Text('Approve'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'reject',
                                      child: Text('Reject'),
                                    ),
                                  ],
                                  child: const Icon(Icons.more_vert),
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

  Widget _buildApprovalCard(
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
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _viewDocument(BuildContext context, Map<String, dynamic> approval) {
    // Show document viewer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing document: ${approval['document']}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _viewDetails(BuildContext context, Map<String, dynamic> approval) {
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
                    approval['name'],
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
              _buildDetailRow('Unit', approval['unit']),
              _buildDetailRow('Phone', approval['phone']),
              _buildDetailRow('Email', approval['email']),
              _buildDetailRow('Request Date', approval['requestDate']),
              _buildDetailRow('Document', approval['document']),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _approveRegistration(context, approval);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Approve'),
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

  void _approveRegistration(BuildContext context, Map<String, dynamic> approval) {
    // Approve registration logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${approval['name']} registration approved'),
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Remove from pending list
    setState(() {
      _pendingApprovals.removeWhere((item) => item['id'] == approval['id']);
    });
  }

  void _rejectRegistration(BuildContext context, Map<String, dynamic> approval) {
    // Reject registration logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reject Registration'),
          content: Text('Are you sure you want to reject ${approval['name']}\'s registration?'),
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
                    content: Text('${approval['name']} registration rejected'),
                    duration: const Duration(seconds: 2),
                  ),
                );
                
                // Remove from pending list
                setState(() {
                  _pendingApprovals.removeWhere((item) => item['id'] == approval['id']);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }
}