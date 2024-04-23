import 'package:flutter/material.dart';
import 'package:job_finder/features/favorite/presentation/view/favorite_view.dart';
import 'package:job_finder/features/homepage/presentation/view/application_view.dart';
import 'package:job_finder/features/homepage/presentation/view/homepage_view.dart';
import 'package:job_finder/features/profile/presentation/view/profile_view.dart';

class HomeState {
  final int index;
  final List<Widget> lstWidgets;

  HomeState({required this.index, required this.lstWidgets});

  HomeState.initialState()
      : index = 0,
        lstWidgets = [
          const HomepageView(),
          AppliedJobsScreen(),
          FavoriteJobsPage(),
          const UserProfileView(),
        ];

  // CopyWith function to change the index no
  HomeState copyWith({
    int? index,
  }) {
    return HomeState(
      index: index ?? this.index,
      lstWidgets: lstWidgets,
    );
  }
}
