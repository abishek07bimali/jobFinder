import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:all_sensors2/all_sensors2.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/features/homepage/presentation/view/recommendedJob._view.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/jobs_view_models.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/recommended_jobs_viewModel.dart';
import 'package:job_finder/features/homepage/presentation/widgets/JobsCard_view.dart';

import '../../../../core/shared_pref/user_shared_prefs.dart';
import '../../domain/entity/jobs_entity.dart';
import 'individualJob_view.dart';

class HomepageView extends ConsumerStatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageViewState();
}

class _HomepageViewState extends ConsumerState<HomepageView> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerRecommended = ScrollController();
  late StreamSubscription<ProximityEvent> _proximitySubscription;
  late FocusNode _searchFocusNode;
  List<JobsEntity> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDataFromSharedPrefs();
    _searchFocusNode = FocusNode();
    _proximitySubscription =
        proximityEvents!.listen((ProximityEvent event) async {
      if (event.proximity < 2) {
        ref.read(recommendedJobsViewModelProvider.notifier).resetState();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerRecommended.dispose();
    _proximitySubscription.cancel();
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  late String firstName = '';
  late String lastName = '';

  Future<void> _loadUserDataFromSharedPrefs() async {
    final userData = await ref.read(userSharedPrefsProvider).getUser();
    firstName = userData?['firstName']?.toString() ?? '';
    lastName = userData?['lastName']?.toString() ?? '';
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = ref
            .read(jobsViewModelProvider)
            .jobs
            .where((job) =>
                job.jobsTitle.toLowerCase().contains(query.toLowerCase()) ||
                job.companyName.toLowerCase().contains(query.toLowerCase()) ||
                job.workType.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobsViewModelProvider);
    final recommendedState = ref.watch(recommendedJobsViewModelProvider);
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(jobsViewModelProvider.notifier).getJobs();
          }
        }
        // if (notification is ScrollEndNotification) {
        //   if (_scrollControllerRecommended.position.extentAfter == 0) {
        //     ref
        //         .read(recommendedJobsViewModelProvider.notifier)
        //         .getRecommended();
        //   }
        // }

        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: appGrey,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        firstName + " " + lastName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: appCOlor,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.notifications_none_outlined),
                        onPressed: () {
                          // Handle notification button press
                        },
                        color: appCOlor,
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          width: 14,
                          height: 14,
                          child: const Text(
                            '1',
                            style: TextStyle(
                              color: appRed,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: appCOlor,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.search, color: appGrey),
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: _searchFocusNode,
                        controller: _searchController,
                        onChanged: (value) {
                          _performSearch(value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: _searchFocusNode.hasFocus && _searchResults.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Results',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: kBlackAccent,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final job = _searchResults[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JobDetail(jobs: job),
                            ));
                          },
                          child: Card(
                            margin: EdgeInsets.only(bottom: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: Image.network(job.image),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.jobsTitle,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          job.jobDescription,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Recommended Jobs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: kBlackAccent,
                    ),
                  ),
                  // You can add a "See more" button here if needed
                ],
              ),
              SizedBox(height: 16),
              Container(
                height: 150,
                child: recommendedState.jobs.isEmpty
                    ? Center(
                        child: Text(
                          'No recommended jobs available',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendedState.jobs.length,
                        controller: _scrollControllerRecommended,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final recommendedJob = recommendedState.jobs[index];
                          return Container(
                            width: 220,
                            margin: const EdgeInsets.only(right: 8.0),
                            child: RecommendedJobsWidget(job: recommendedJob),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    'Popular Jobs',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: kBlackAccent,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See more',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: appGrey),
                  ),
                ],
              ),
              SizedBox(height: 16),
              RefreshIndicator(
                color: appCOlor,
                onRefresh: () async {
                  ref.read(jobsViewModelProvider.notifier).resetState();
                },
                child: Container(
                  height: 570,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    controller: _scrollController,
                    itemCount: state.jobs.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < state.jobs.length) {
                        final jobs = state.jobs[index];
                        return JobCardWidget(job: jobs);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
