import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/home_viewmodel.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({super.key});

  @override
  ConsumerState<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerState<NavigationView> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    return Scaffold(
      body: homeState.lstWidgets[homeState.index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_axis),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        selectedItemColor: appCOlor,
        currentIndex: homeState.index,
        onTap: (index) {
          ref.read(homeViewModelProvider.notifier).changeIndex(index);
        },
      ),
    );
  }
}
