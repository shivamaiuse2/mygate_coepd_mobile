import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredPosts = [];
  List<Map<String, dynamic>> _filteredMarketplaceItems = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'user': {
        'name': 'John Doe',
        'avatar':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=100&h=100',
        'unit': 'A-101',
      },
      'content':
          'Just moved to our new apartment! The community here is amazing. Looking forward to meeting everyone.',
      'image':
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&q=80&w=400&h=300',
      'time': '2 hours ago',
      'likes': 24,
      'comments': 8,
    },
    {
      'id': 2,
      'user': {
        'name': 'Sarah Johnson',
        'avatar':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=100&h=100',
        'unit': 'B-203',
      },
      'content':
          'Lost my cat yesterday near the community garden. Respond if you see him!',
      'time': '5 hours ago',
      'likes': 15,
      'comments': 12,
    },
    {
      'id': 3,
      'user': {
        'name': 'Mike Williams',
        'avatar':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=100&h=100',
        'unit': 'C-405',
      },
      'content':
          'Community garage sale this weekend! Come check out great deals on furniture, electronics, and more.',
      'image':
          'https://images.unsplash.com/photo-1521334884684-d80222895326?auto=format&fit=crop&q=80&w=400&h=300',
      'time': '1 day ago',
      'likes': 42,
      'comments': 18,
    },
  ];

  final List<Map<String, dynamic>> _marketplaceItems = [
    {
      'id': 1,
      'title': 'Sofa Set',
      'price': '₹15,000',
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&q=80&w=200&h=200',
      'user': 'John Smith',
      'unit': 'A-101',
    },
    {
      'id': 2,
      'title': 'Bicycle',
      'price': '₹8,500',
      'image':
          'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8?auto=format&fit=crop&q=80&w=200&h=200',
      'user': 'Priya Sharma',
      'unit': 'B-203',
    },
    {
      'id': 3,
      'title': 'Kitchen Appliances',
      'price': '₹12,000',
      'image':
          'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&q=80&w=200&h=200',
      'user': 'Raj Patel',
      'unit': 'C-405',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredPosts = _posts;
    _filteredMarketplaceItems = _marketplaceItems;
    _searchController.addListener(_filterContent);
    
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

  void _filterContent() {
    setState(() {
      String searchTerm = _searchController.text.toLowerCase();
      
      if (_currentIndex == 0) {
        // Filter posts
        _filteredPosts = _posts.where((post) {
          return searchTerm.isEmpty || 
              post['content'].toLowerCase().contains(searchTerm) ||
              post['user']['name'].toLowerCase().contains(searchTerm) ||
              post['user']['unit'].toLowerCase().contains(searchTerm);
        }).toList();
      } else {
        // Filter marketplace items
        _filteredMarketplaceItems = _marketplaceItems.where((item) {
          return searchTerm.isEmpty || 
              item['title'].toLowerCase().contains(searchTerm) ||
              item['user'].toLowerCase().contains(searchTerm) ||
              item['unit'].toLowerCase().contains(searchTerm);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterContent);
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tab bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ScaleTransition(
                    scale: _fadeAnimation,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _currentIndex = 0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentIndex == 0
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardTheme.color,
                        foregroundColor: _currentIndex == 0
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      child: const Text('Feed'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ScaleTransition(
                    scale: _fadeAnimation,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _currentIndex = 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentIndex == 1
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardTheme.color,
                        foregroundColor: _currentIndex == 1
                            ? Colors.white
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      child: const Text('Marketplace'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Content based on selected tab
          Expanded(
            child: _currentIndex == 0 ? _buildFeed() : _buildMarketplace(),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fadeAnimation,
        child: FloatingActionButton(
          onPressed: () {
            // Create new post
            _showCreatePostDialog();
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildFeed() {
    return _filteredPosts.isEmpty
        ? _buildEmptyFeedState()
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _filteredPosts.length,
            itemBuilder: (context, index) {
              final post = _filteredPosts[index];
              return ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      0.1 * index,
                      0.3 + (0.1 * index),
                      curve: Curves.elasticOut,
                    ),
                  ),
                ),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User info with gradient background
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                Theme.of(context).primaryColor.withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      CachedNetworkImageProvider(post['user']['avatar']),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['user']['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      post['user']['unit'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  post['time'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Post content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            post['content'],
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Post image
                        if (post['image'] != null)
                          Container(
                            height: 200,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(post['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        // Actions with visual enhancements
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      size: 18,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${post['likes']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      size: 18,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${post['comments']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  Icons.share,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildMarketplace() {
    return _filteredMarketplaceItems.isEmpty
        ? _buildEmptyMarketplaceState()
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: _filteredMarketplaceItems.length,
            itemBuilder: (context, index) {
              final item = _filteredMarketplaceItems[index];
              return ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      0.1 * index,
                      0.3 + (0.1 * index),
                      curve: Curves.elasticOut,
                    ),
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item image
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(item['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Item details
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['price'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF006D77),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item['user']} • ${item['unit']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        String hintText = _currentIndex == 0
            ? 'Search community posts...'
            : 'Search marketplace items...';
            
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
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
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

  void _showCreatePostDialog() {
    final TextEditingController _postController = TextEditingController();
    final TextEditingController _titleController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create New Post',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Post title (optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _postController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'What would you like to share with the community?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_postController.text.trim().isNotEmpty) {
                            Navigator.of(context).pop();
                            _createPost(
                              _titleController.text.trim(),
                              _postController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: const Text('Post'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _createPost(String title, String content) {
    // Create a new post object
    final newPost = {
      'id': _posts.length + 1,
      'user': {
        'name': 'John Doe',
        'avatar':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=100&h=100',
        'unit': 'A-101',
      },
      'content': content,
      'title': title,
      'time': 'Just now',
      'likes': 0,
      'comments': 0,
    };

    // Add to posts list
    setState(() {
      _posts.insert(0, newPost);
      _filterContent(); // Refresh filtered list
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post created successfully'),
      ),
    );
  }

  void _showPostOptions(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Post Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.thumb_up, color: Colors.blue),
                title: const Text('Like'),
                onTap: () {
                  Navigator.of(context).pop();
                  _likePost(post);
                },
              ),
              ListTile(
                leading: const Icon(Icons.comment, color: Colors.green),
                title: const Text('Comment'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showCommentDialog(post);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.orange),
                title: const Text('Share'),
                onTap: () {
                  Navigator.of(context).pop();
                  _sharePost(post);
                },
              ),
              ListTile(
                leading: const Icon(Icons.report, color: Colors.red),
                title: const Text('Report'),
                onTap: () {
                  Navigator.of(context).pop();
                  _reportPost(post);
                },
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _likePost(Map<String, dynamic> post) {
    setState(() {
      // Find and update the post
      for (var i = 0; i < _posts.length; i++) {
        if (_posts[i]['id'] == post['id']) {
          _posts[i] = Map<String, dynamic>.from(_posts[i])
            ..['likes'] = post['likes'] + 1;
          break;
        }
      }
      _filterContent(); // Refresh filtered list
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Liked post'),
      ),
    );
  }

  void _showCommentDialog(Map<String, dynamic> post) {
    final TextEditingController _commentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: TextField(
            controller: _commentController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: 'Write your comment...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_commentController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                  _addComment(post, _commentController.text.trim());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: const Text('Comment'),
            ),
          ],
        );
      },
    );
  }

  void _addComment(Map<String, dynamic> post, String comment) {
    setState(() {
      // Find and update the post
      for (var i = 0; i < _posts.length; i++) {
        if (_posts[i]['id'] == post['id']) {
          _posts[i] = Map<String, dynamic>.from(_posts[i])
            ..['comments'] = post['comments'] + 1;
          break;
        }
      }
      _filterContent(); // Refresh filtered list
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comment added'),
      ),
    );
  }

  void _sharePost(Map<String, dynamic> post) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post shared'),
      ),
    );
  }

  void _reportPost(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Post'),
          content: const Text('Are you sure you want to report this post?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Post reported'),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Report'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyFeedState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.groups,
              size: 50,
              color: Color(0xFF006D77),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Posts Found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _searchController.text.isEmpty
                ? 'There are no posts in the community feed'
                : 'No posts match your search',
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMarketplaceState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.shopping_cart,
              size: 50,
              color: Color(0xFF006D77),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Items Found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            _searchController.text.isEmpty
                ? 'There are no items in the marketplace'
                : 'No items match your search',
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}