import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_nav.dart';
import 'home/home_tab.dart';
import 'mocks/mocks_tab.dart';
import 'settings/settings_screen.dart';
import 'sira/sira_tab.dart';
import 'study/study_tab.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  NavTab _tab = NavTab.home;

  Widget _bodyFor(NavTab tab) {
    switch (tab) {
      case NavTab.home:
        return const HomeTab();
      case NavTab.sira:
        return const SiraTab();
      case NavTab.mocks:
        return const MocksTab();
      case NavTab.study:
        return const StudyTab();
    }
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.c.bg,
      extendBody: true,
      body: AppBackground(
        child: Column(
          children: [
            AppHeader(onMenu: _openSettings),
            Expanded(
              child: IndexedStack(
                index: NavTab.values.indexOf(_tab),
                children: [
                  for (final tab in NavTab.values)
                    Offstage(
                      offstage: tab != _tab,
                      child: TickerMode(enabled: tab == _tab, child: _bodyFor(tab)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        current: _tab,
        onChanged: (t) => setState(() => _tab = t),
      ),
    );
  }
}
