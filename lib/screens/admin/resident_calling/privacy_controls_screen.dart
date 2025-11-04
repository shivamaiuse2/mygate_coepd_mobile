import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyControlsScreen extends StatefulWidget {
  const PrivacyControlsScreen({super.key});

  @override
  State<PrivacyControlsScreen> createState() => _PrivacyControlsScreenState();
}

class _PrivacyControlsScreenState extends State<PrivacyControlsScreen> {
  bool _hideCallerId = true;
  bool _requireOptIn = true;
  bool _limitCallDuration = true;
  int _maxCallDuration = 30; // in minutes

  final List<Map<String, dynamic>> _residentPreferences = [
    {
      'id': 1,
      'resident': 'Rajesh Kumar',
      'unit': 'A-101',
      'callingEnabled': true,
      'privacyMode': true,
    },
    {
      'id': 2,
      'resident': 'Priya Sharma',
      'unit': 'A-102',
      'callingEnabled': true,
      'privacyMode': false,
    },
    {
      'id': 3,
      'resident': 'Amit Patel',
      'unit': 'B-201',
      'callingEnabled': false,
      'privacyMode': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Controls'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy controls description
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
                        'Privacy Controls',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Manage privacy settings for resident calling feature.',
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
              // Global privacy settings
              Text(
                'Global Privacy Settings',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              _buildSettingCard(
                context,
                title: 'Hide Caller ID',
                description: 'Hide caller information from recipients',
                value: _hideCallerId,
                onChanged: (value) {
                  setState(() {
                    _hideCallerId = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildSettingCard(
                context,
                title: 'Require Opt-in',
                description: 'Residents must opt-in to receive calls',
                value: _requireOptIn,
                onChanged: (value) {
                  setState(() {
                    _requireOptIn = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              _buildSettingCard(
                context,
                title: 'Limit Call Duration',
                description: 'Set maximum call duration to prevent long calls',
                value: _limitCallDuration,
                onChanged: (value) {
                  setState(() {
                    _limitCallDuration = value;
                  });
                },
              ),
              if (_limitCallDuration) ...[
                SizedBox(height: 16.h),
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
                          'Maximum Call Duration',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                value: _maxCallDuration.toDouble(),
                                min: 5,
                                max: 120,
                                divisions: 23,
                                label: '${_maxCallDuration} mins',
                                onChanged: (value) {
                                  setState(() {
                                    _maxCallDuration = value.toInt();
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              '${_maxCallDuration} mins',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 30.h),
              // Resident preferences
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Resident Preferences',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showBulkUpdateDialog(context);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Bulk Update'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _residentPreferences.length,
                itemBuilder: (context, index) {
                  final resident = _residentPreferences[index];
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
                                resident['resident'],
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
                                  color: resident['callingEnabled'] 
                                      ? Colors.green.withOpacity(0.1) 
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  resident['callingEnabled'] ? 'Enabled' : 'Disabled',
                                  style: TextStyle(
                                    color: resident['callingEnabled'] ? Colors.green : Colors.red,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Unit: ${resident['unit']}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Expanded(
                                child: _buildResidentSetting(
                                  context,
                                  title: 'Calling Enabled',
                                  value: resident['callingEnabled'],
                                  onChanged: (value) {
                                    // Update resident calling setting
                                  },
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: _buildResidentSetting(
                                  context,
                                  title: 'Privacy Mode',
                                  value: resident['privacyMode'],
                                  onChanged: (value) {
                                    // Update resident privacy setting
                                  },
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
                                  _viewResidentDetails(context, resident);
                                },
                                child: const Text('View Details'),
                              ),
                              SizedBox(width: 12.w),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditResidentDialog(context, resident);
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit Preferences'),
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

  Widget _buildResidentSetting(
    BuildContext context, {
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          dense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  void _viewResidentDetails(BuildContext context, Map<String, dynamic> resident) {
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
                    resident['resident'],
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
              _buildDetailRow('Unit', resident['unit']),
              _buildDetailRow('Calling Enabled', resident['callingEnabled'] ? 'Yes' : 'No'),
              _buildDetailRow('Privacy Mode', resident['privacyMode'] ? 'Enabled' : 'Disabled'),
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
            width: 130.w,
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

  void _showEditResidentDialog(BuildContext context, Map<String, dynamic> resident) {
    bool callingEnabled = resident['callingEnabled'];
    bool privacyMode = resident['privacyMode'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${resident['resident']} Preferences'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Calling Enabled'),
                  value: callingEnabled,
                  onChanged: (value) {
                    callingEnabled = value;
                  },
                ),
                SwitchListTile(
                  title: const Text('Privacy Mode'),
                  value: privacyMode,
                  onChanged: (value) {
                    privacyMode = value;
                  },
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
                // Update resident preferences logic
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showBulkUpdateDialog(BuildContext context) {
    bool hideCallerId = _hideCallerId;
    bool requireOptIn = _requireOptIn;
    bool limitCallDuration = _limitCallDuration;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bulk Update Preferences'),
          content: SizedBox(
            width: 400.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Hide Caller ID'),
                  value: hideCallerId,
                  onChanged: (value) {
                    hideCallerId = value;
                  },
                ),
                SwitchListTile(
                  title: const Text('Require Opt-in'),
                  value: requireOptIn,
                  onChanged: (value) {
                    requireOptIn = value;
                  },
                ),
                SwitchListTile(
                  title: const Text('Limit Call Duration'),
                  value: limitCallDuration,
                  onChanged: (value) {
                    limitCallDuration = value;
                  },
                ),
                if (limitCallDuration) ...[
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      const Text('Max Duration:'),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Slider(
                          value: _maxCallDuration.toDouble(),
                          min: 5,
                          max: 120,
                          divisions: 23,
                          label: '${_maxCallDuration} mins',
                          onChanged: (value) {
                            setState(() {
                              _maxCallDuration = value.toInt();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text('${_maxCallDuration} mins'),
                    ],
                  ),
                ],
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
                // Bulk update logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Resident preferences updated'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Update All'),
            ),
          ],
        );
      },
    );
  }
}