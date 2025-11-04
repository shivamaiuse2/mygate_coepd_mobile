import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailCampaignsScreen extends StatefulWidget {
  const EmailCampaignsScreen({super.key});

  @override
  State<EmailCampaignsScreen> createState() => _EmailCampaignsScreenState();
}

class _EmailCampaignsScreenState extends State<EmailCampaignsScreen> {
  final List<Map<String, dynamic>> _emailCampaigns = [
    {
      'id': 1,
      'subject': 'Monthly Maintenance Reminder',
      'recipients': 'All Residents',
      'sentDate': '2023-05-01',
      'status': 'Sent',
      'openRate': '78%',
      'clickRate': '45%',
    },
    {
      'id': 2,
      'subject': 'Community Event Announcement',
      'recipients': 'Tower A, B',
      'sentDate': '2023-04-28',
      'status': 'Sent',
      'openRate': '82%',
      'clickRate': '60%',
    },
    {
      'id': 3,
      'subject': 'New Amenity Booking System',
      'recipients': 'All Residents',
      'sentDate': '2023-04-25',
      'status': 'Draft',
      'openRate': 'N/A',
      'clickRate': 'N/A',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Campaigns'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email campaigns description
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
                        'Email Campaigns',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Create and manage email campaigns for community communication.',
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
              // Create new campaign button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showCreateCampaignDialog(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create New Campaign'),
                ),
              ),
              SizedBox(height: 20.h),
              // Campaign statistics
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Text(
                        'Campaign Statistics',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatsCard(
                            context,
                            title: 'Total Campaigns',
                            value: _emailCampaigns.length.toString(),
                            icon: Icons.email,
                            color: Theme.of(context).primaryColor,
                          ),
                          _buildStatsCard(
                            context,
                            title: 'Sent',
                            value: _emailCampaigns.where((campaign) => campaign['status'] == 'Sent').length.toString(),
                            icon: Icons.send,
                            color: Colors.green,
                          ),
                          _buildStatsCard(
                            context,
                            title: 'Avg. Open Rate',
                            value: '80%',
                            icon: Icons.visibility,
                            color: Colors.blue,
                          ),
                        ],
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
                          hintText: 'Search email campaigns...',
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
                                labelText: 'Status',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Status')),
                                DropdownMenuItem(value: 'draft', child: Text('Draft')),
                                DropdownMenuItem(value: 'sent', child: Text('Sent')),
                              ],
                              onChanged: (value) {},
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Recipients',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'all', child: Text('All Recipients')),
                                DropdownMenuItem(value: 'all_residents', child: Text('All Residents')),
                                DropdownMenuItem(value: 'towers', child: Text('Specific Towers')),
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
              // Email campaigns list
              Text(
                'Email Campaigns',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _emailCampaigns.length,
                itemBuilder: (context, index) {
                  final campaign = _emailCampaigns[index];
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
                              Expanded(
                                child: Text(
                                  campaign['subject'],
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.r,
                                  vertical: 6.r,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(campaign['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  campaign['status'],
                                  style: TextStyle(
                                    color: _getStatusColor(campaign['status']),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'To: ${campaign['recipients']}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
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
                                'Sent: ${campaign['sentDate']}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          if (campaign['status'] == 'Sent') ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                _buildMetricChip(
                                  context,
                                  label: 'Open Rate',
                                  value: campaign['openRate'],
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 12.w),
                                _buildMetricChip(
                                  context,
                                  label: 'Click Rate',
                                  value: campaign['clickRate'],
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _viewCampaignDetails(context, campaign);
                                },
                                child: const Text('View Details'),
                              ),
                              SizedBox(width: 12.w),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditCampaignDialog(context, campaign);
                                  } else if (value == 'send') {
                                    _sendCampaign(context, campaign);
                                  } else if (value == 'delete') {
                                    _deleteCampaign(context, campaign);
                                  }
                                },
                                itemBuilder: (context) => [
                                  if (campaign['status'] == 'Draft')
                                    const PopupMenuItem(
                                      value: 'send',
                                      child: Text('Send Campaign'),
                                    ),
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit Campaign'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete Campaign'),
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

  Widget _buildStatsCard(
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'sent':
        return Colors.green;
      case 'draft':
        return Colors.orange;
      case 'scheduled':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget _buildMetricChip(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showCreateCampaignDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Email Campaign'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Subject',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Recipients',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Open recipient selection dialog
                  },
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  maxLines: 5,
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
                // Create campaign logic
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _viewCampaignDetails(BuildContext context, Map<String, dynamic> campaign) {
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
                    campaign['subject'],
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
              _buildDetailRow('Recipients', campaign['recipients']),
              _buildDetailRow('Sent Date', campaign['sentDate']),
              _buildDetailRow('Status', campaign['status']),
              if (campaign['status'] == 'Sent') ...[
                _buildDetailRow('Open Rate', campaign['openRate']),
                _buildDetailRow('Click Rate', campaign['clickRate']),
              ],
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

  void _showEditCampaignDialog(BuildContext context, Map<String, dynamic> campaign) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Email Campaign'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  campaign['subject'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Subject',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  controller: TextEditingController(text: campaign['subject']),
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Recipients',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  controller: TextEditingController(text: campaign['recipients']),
                  readOnly: true,
                  onTap: () {
                    // Open recipient selection dialog
                  },
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Content',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  controller: TextEditingController(text: 'Sample email content...'),
                  maxLines: 5,
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
                // Edit campaign logic
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _sendCampaign(BuildContext context, Map<String, dynamic> campaign) {
    // Send campaign logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Campaign "${campaign['subject']}" sent successfully'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteCampaign(BuildContext context, Map<String, dynamic> campaign) {
    // Delete campaign logic
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Email Campaign'),
          content: Text('Are you sure you want to delete "${campaign['subject']}"? This action cannot be undone.'),
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
                    content: Text('Campaign "${campaign['subject']}" deleted'),
                    duration: const Duration(seconds: 2),
                  ),
                );
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