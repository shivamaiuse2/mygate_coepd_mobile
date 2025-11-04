import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_bloc.dart';
import 'package:mygate_coepd/blocs/auth/auth_state.dart';
import 'package:mygate_coepd/screens/guard/guard_dashboard_screen.dart';
import 'package:mygate_coepd/screens/guard/visitor_management_screen.dart';
import 'package:mygate_coepd/screens/guard/attendance_screen.dart';
import 'package:mygate_coepd/screens/guard/profile_screen.dart';

class GuardMainScreen extends StatefulWidget {
  const GuardMainScreen({super.key});

  @override
  State<GuardMainScreen> createState() => _GuardMainScreenState();
}

class _GuardMainScreenState extends State<GuardMainScreen> {
  int _currentIndex = 0;
  
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const GuardDashboardScreen(),
      const VisitorManagementScreen(),
      const AttendanceScreen(),
      const GuardProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            body: _screens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Visitors',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.checklist),
                  label: 'Attendance',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}