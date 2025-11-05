import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  bool _biometricEnabled = false;
  bool _notificationsEnabled = true;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredFamilyMembers = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _profileSections = [
    {
      'title': 'Personal Information',
      'items': [
        {'label': 'Name', 'value': 'John Doe'},
        {'label': 'Email', 'value': 'john.doe@example.com'},
        {'label': 'Phone', 'value': '+91 9876543210'},
        {'label': 'Unit', 'value': 'A-101'},
        {'label': 'Society', 'value': 'Green Valley Apartments'},
      ],
    },
    {
      'title': 'Family Members',
      'items': [
        {
          'name': 'Jane Doe',
          'relationship': 'Spouse',
          'image':
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100&h=100'
        },
        {
          'name': 'Jimmy Doe',
          'relationship': 'Son',
          'image':
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=100&h=100'
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _settings = [
    {
      'title': 'Biometric Authentication',
      'subtitle': 'Use fingerprint or face recognition to login',
      'icon': Icons.fingerprint,
    },
    {
      'title': 'Notifications',
      'subtitle': 'Receive alerts and updates',
      'icon': Icons.notifications,
    },
    {
      'title': 'Privacy Settings',
      'subtitle': 'Manage your privacy preferences',
      'icon': Icons.privacy_tip,
    },
    {
      'title': 'Language',
      'subtitle': 'Change app language',
      'icon': Icons.language,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize filtered family members with all members
    _filteredFamilyMembers = List<Map<String, dynamic>>.from(
        _profileSections
            .firstWhere((section) => section['title'] == 'Family Members')['items']);
    _searchController.addListener(_filterFamilyMembers);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Start animations after a small delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  void _filterFamilyMembers() {
    setState(() {
      String searchTerm = _searchController.text.toLowerCase();
      
      List<Map<String, dynamic>> allFamilyMembers = 
          List<Map<String, dynamic>>.from(
              _profileSections
                  .firstWhere((section) => section['title'] == 'Family Members')['items']);
      
      _filteredFamilyMembers = allFamilyMembers.where((member) {
        return searchTerm.isEmpty || 
            member['name'].toLowerCase().contains(searchTerm) ||
            member['relationship'].toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterFamilyMembers);
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          ScaleTransition(
            scale: _fadeAnimation,
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: _showSearchBar,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            const SizedBox(height: 20),
            // Profile Sections
            _buildProfileSections(),
            const SizedBox(height: 20),
            // Settings
            ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0.6, 0.9, curve: Curves.elasticOut),
                ),
              ),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ..._settings.asMap().entries.map((entry) {
                      final index = entry.key;
                      final setting = entry.value;
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                setting['icon'],
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            title: Text(setting['title']),
                            subtitle: Text(setting['subtitle']),
                            trailing: index < 2
                                ? Switch(
                                    value: index == 0 ? _biometricEnabled : _notificationsEnabled,
                                    onChanged: (value) {
                                      setState(() {
                                        if (index == 0) {
                                          _biometricEnabled = value;
                                        } else {
                                          _notificationsEnabled = value;
                                        }
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                  )
                                : const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: index >= 2 ? () {} : null,
                          ),
                          if (index < _settings.length - 1)
                            const Divider(
                              height: 1,
                              indent: 70,
                            ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: const Interval(0.7, 1.0, curve: Curves.elasticOut),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Show logout confirmation
                      _showLogoutConfirmation();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Row(
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.0, 0.3, curve: Curves.elasticOut),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: CachedNetworkImageProvider(
                      'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=100&h=100',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 16,
                      color: Color(0xFF006D77),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: const Text(
                    'Resident • A-101',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Text(
                      'Verified Resident',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSections() {
    return Column(
      children: _profileSections.map((section) {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  section['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (section['title'] == 'Personal Information')
                _buildPersonalInfoSection(section['items'])
              else if (section['title'] == 'Family Members')
                _buildFamilyMembersSection(section['items'])
              else
                _buildGenericSection(section['items']),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPersonalInfoSection(List<dynamic> items) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).cardTheme.color!,
              Theme.of(context).cardTheme.color!.withValues(alpha: 0.95),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: items.map((item) {
            return ListTile(
              title: Text(
                item['label'],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Text(
                item['value'],
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                _showEditInfoDialog(item['label'], item['value']);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFamilyMembersSection(List<dynamic> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).cardTheme.color!,
                    Theme.of(context).cardTheme.color!.withValues(alpha: 0.95),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ...items.map((member) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(member['image']),
                      ),
                      title: Text(member['name']),
                      subtitle: Text(member['relationship']),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey.shade600,
                        ),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditFamilyMemberDialog(member);
                          } else if (value == 'delete') {
                            _showDeleteFamilyMemberDialog(member);
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
                    );
                  }).toList(),
                  Divider(
                    color: Colors.grey.withValues(alpha: 0.3),
                    height: 1,
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: const Text('Add Family Member'),
                    onTap: _showAddFamilyMemberDialog,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenericSection(List<dynamic> items) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).cardTheme.color!,
              Theme.of(context).cardTheme.color!.withValues(alpha: 0.95),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: items.map((item) {
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item['icon'] == Icons.fingerprint
                      ? (_biometricEnabled
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.grey.withValues(alpha: 0.1))
                      : item['icon'] == Icons.notifications
                          ? (_notificationsEnabled
                              ? Colors.blue.withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.1))
                          : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'],
                  color: item['icon'] == Icons.fingerprint
                      ? (_biometricEnabled ? Colors.green : Colors.grey)
                      : item['icon'] == Icons.notifications
                          ? (_notificationsEnabled ? Colors.blue : Colors.grey)
                          : Colors.grey,
                ),
              ),
              title: Text(item['title']),
              subtitle: Text(item['subtitle']),
              trailing: item['icon'] == Icons.fingerprint
                  ? Switch(
                      value: _biometricEnabled,
                      onChanged: (value) {
                        setState(() {
                          _biometricEnabled = value;
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                    )
                  : item['icon'] == Icons.notifications
                      ? Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        )
                      : const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                if (item['icon'] == Icons.language) {
                  _showLanguageDialog();
                } else if (item['icon'] == Icons.privacy_tip) {
                  _showPrivacyDialog();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showEditInfoDialog(String label, String value) {
    final TextEditingController _controller = TextEditingController(text: value);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter $label',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label updated successfully'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddFamilyMemberDialog() {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _relationshipController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Family Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _relationshipController,
                decoration: const InputDecoration(
                  hintText: 'Relationship',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isNotEmpty &&
                    _relationshipController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                  _addFamilyMember(
                    _nameController.text.trim(),
                    _relationshipController.text.trim(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addFamilyMember(String name, String relationship) {
    // Add to family members list
    final newMember = {
      'name': name,
      'relationship': relationship,
      'image':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100&h=100'
    };

    setState(() {
      // Find family members section and add new member
      for (var i = 0; i < _profileSections.length; i++) {
        if (_profileSections[i]['title'] == 'Family Members') {
          _profileSections[i]['items'].add(newMember);
          break;
        }
      }
      _filterFamilyMembers(); // Refresh filtered list
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Family member added successfully'),
      ),
    );
  }

  void _showEditFamilyMemberDialog(Map<String, dynamic> member) {
    final TextEditingController _nameController =
        TextEditingController(text: member['name']);
    final TextEditingController _relationshipController =
        TextEditingController(text: member['relationship']);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Family Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _relationshipController,
                decoration: const InputDecoration(
                  hintText: 'Relationship',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.trim().isNotEmpty &&
                    _relationshipController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                  _editFamilyMember(
                    member,
                    _nameController.text.trim(),
                    _relationshipController.text.trim(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editFamilyMember(
      Map<String, dynamic> member, String name, String relationship) {
    setState(() {
      // Find and update the family member
      for (var i = 0; i < _profileSections.length; i++) {
        if (_profileSections[i]['title'] == 'Family Members') {
          for (var j = 0; j < _profileSections[i]['items'].length; j++) {
            if (_profileSections[i]['items'][j]['name'] == member['name']) {
              _profileSections[i]['items'][j] = {
                'name': name,
                'relationship': relationship,
                'image': member['image'],
              };
              break;
            }
          }
          break;
        }
      }
      _filterFamilyMembers(); // Refresh filtered list
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Family member updated successfully'),
      ),
    );
  }

  void _showDeleteFamilyMemberDialog(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Family Member'),
          content: Text('Are you sure you want to delete ${member['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteFamilyMember(member);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFamilyMember(Map<String, dynamic> member) {
    setState(() {
      // Find and remove the family member
      for (var i = 0; i < _profileSections.length; i++) {
        if (_profileSections[i]['title'] == 'Family Members') {
          _profileSections[i]['items'].removeWhere(
              (item) => item['name'] == member['name']);
          break;
        }
      }
      _filterFamilyMembers(); // Refresh filtered list
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${member['name']} deleted successfully'),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                trailing: Radio<String>(
                  value: 'en',
                  groupValue: 'en',
                  onChanged: (value) {},
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language set to English'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Hindi'),
                trailing: Radio<String>(
                  value: 'hi',
                  groupValue: null,
                  onChanged: (value) {},
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Language set to Hindi'),
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Settings'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your privacy is important to us. We collect and use your information to provide and improve our services.',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 16),
                Text(
                  'Information We Collect:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '• Personal information (name, email, phone number)\n• Usage data\n• Device information',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 16),
                Text(
                  'How We Use Your Information:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '• To provide and maintain our service\n• To notify you about changes\n• To provide customer support',
                  style: TextStyle(height: 1.5),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSearchBar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search family members...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006D77),
                  ),
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform logout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                  ),
                );
                // Navigate to login screen
                Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}