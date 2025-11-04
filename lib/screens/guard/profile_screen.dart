// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_event.dart';
import 'package:mygate_coepd/blocs/auth/auth_state.dart';
import 'package:mygate_coepd/theme/app_theme.dart';
import 'package:mygate_coepd/screens/guard/details/multilingual_support_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GuardProfileScreen extends StatefulWidget {
  const GuardProfileScreen({super.key});

  @override
  State<GuardProfileScreen> createState() => _GuardProfileScreenState();
}

class _GuardProfileScreenState extends State<GuardProfileScreen> {
  bool _isOffline = false;
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  String _selectedLanguage = 'English';

  final List<String> _languages = [
    'English',
    'Hindi',
    'Kannada',
    'Gujarati',
    'Tamil',
    'Telugu',
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'title': 'Visitor Entry Approved',
      'description': 'Approved entry for Rahul Kumar to A-101',
      'time': '10:30 AM',
      'icon': Icons.person,
      'color': Colors.blue,
    },
    {
      'title': 'Patrol Completed',
      'description': 'Completed Main Gate Route patrol',
      'time': '09:15 AM',
      'icon': Icons.directions_walk,
      'color': Colors.green,
    },
    {
      'title': 'Attendance Marked',
      'description': 'Morning shift attendance marked',
      'time': '08:00 AM',
      'icon': Icons.check_circle,
      'color': Colors.orange,
    },
  ];

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthBloc>().add(LogoutRequested());
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ..._languages.map(
                (language) => RadioListTile<String>(
                  title: Text(language),
                  value: language,
                  groupValue: _selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToMultilingualSupport() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MultilingualSupportScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile'),
              actions: [
                IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 20,
                  children: [
                    // Offline Banner
                    if (_isOffline)
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.wifi_off, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Offline Mode',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isOffline = false;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Profile Header
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 6,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🧾 Left Side — Profile Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name
                                    Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 5),

                                    // Role Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primary.withValues(alpha: 
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Security Guard',
                                        style: TextStyle(
                                          color: AppTheme.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    // Info rows
                                    _buildInfoItem(
                                      Icons.email_outlined,
                                      user.email,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildInfoItem(
                                      Icons.phone_outlined,
                                      user.phone,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildInfoItem(
                                      Icons.location_on_outlined,
                                      'COEPD Society, Pune',
                                    ),
                                  ],
                                ),
                              ),

                              // 🧍 Right Side — Profile Image
                              const SizedBox(width: 16),
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primary
                                              .withValues(alpha: 0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          user.profileImage != null
                                          ? CachedNetworkImageProvider(
                                              user.profileImage!,
                                            )
                                          : null,
                                      child: user.profileImage == null
                                          ? const Icon(
                                              Icons.person,
                                              size: 50,
                                              color: AppTheme.primary,
                                            )
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        // edit profile image
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: AppTheme.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Account Settings
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.notifications),
                                title: const Text('Notifications'),
                                trailing: Switch(
                                  value: _notificationsEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      _notificationsEnabled = value;
                                    });
                                  },
                                  activeColor: AppTheme.primary,
                                ),
                              ),
                              const Divider(height: 0),
                              ListTile(
                                leading: const Icon(Icons.fingerprint),
                                title: const Text('Biometric Login'),
                                trailing: Switch(
                                  value: _biometricEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      _biometricEnabled = value;
                                    });
                                  },
                                  activeColor: AppTheme.primary,
                                ),
                              ),
                              const Divider(height: 0),
                              ListTile(
                                leading: const Icon(Icons.language),
                                title: const Text('Language'),
                                subtitle: Text(_selectedLanguage),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: _navigateToMultilingualSupport,
                              ),
                              const Divider(height: 0),
                              ListTile(
                                leading: const Icon(Icons.lock),
                                title: const Text('Change Password'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  // Change password action
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Recent Activity
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent Activity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: _recentActivities
                                .map(
                                  (activity) => ListTile(
                                    leading: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: activity['color'].withValues(alpha: 
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        activity['icon'],
                                        color: activity['color'],
                                      ),
                                    ),
                                    title: Text(activity['title']),
                                    subtitle: Text(activity['description']),
                                    trailing: Text(
                                      activity['time'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    // Support Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Support',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.help),
                                title: const Text('Help Center'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  // Help center action
                                },
                              ),
                              const Divider(height: 0),
                              ListTile(
                                leading: const Icon(Icons.feedback),
                                title: const Text('Send Feedback'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  // Feedback action
                                },
                              ),
                              const Divider(height: 0),
                              ListTile(
                                leading: const Icon(Icons.info),
                                title: const Text('About'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  // About action
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: AppTheme.primary, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
