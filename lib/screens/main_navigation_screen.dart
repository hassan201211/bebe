import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import '../widgets/custom_bottom_bar.dart';
import 'home_screen.dart';
import 'wallet_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialTabIndex;

  const MainNavigationScreen({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    _appState = AppState();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _appState,
      builder: (context, _) {
        final screens = [
          HomeScreen(
            appState: _appState,
            onNavigateTab: _onTabSelected,
          ),
          WalletScreen(appState: _appState),
          OrdersScreen(appState: _appState),
          ProfileScreen(appState: _appState),
        ];

        return Scaffold(
          backgroundColor: const Color(0xFF07080D),
          // تمديد محتوى الشاشة خلف شريط التنقل ليظهر التغبيش الزجاجي
          extendBody: true,
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: CustomBottomBar(
            currentIndex: _currentIndex,
            onTap: _onTabSelected,
          ),
        );
      },
    );
  }
}
