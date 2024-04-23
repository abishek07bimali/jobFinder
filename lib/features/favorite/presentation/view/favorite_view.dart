import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/features/favorite/presentation/viewmodel/favorite_view_models.dart';
import 'package:job_finder/features/homepage/presentation/view/individualJob_view.dart';

class FavoriteJobsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<FavoriteJobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<FavoriteJobsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(favoriteViewModelProvider.notifier).resetState();
    });
  }

  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jobs'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    bool isLiked = true;
    final state = ref.watch(favoriteViewModelProvider);
    return RefreshIndicator(
      onRefresh: () async {
        await ref.watch(favoriteViewModelProvider.notifier).resetState();
      },
      child: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: state.jobs.isEmpty ? 1 : state.jobs.length,
              itemBuilder: (context, index) {
                if (state.jobs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: Text('No saved jobs found.')),
                  );
                } else {
                  final job = state.jobs[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            JobDetail(jobs: job.toJobsEntity(), isLiked: true),
                      ));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: Image.network(job.image),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.companyName,
                                      style: appTitleStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      job.jobsTitle,
                                      style: appTitleStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: isLiked ? appCOlor : appCOlor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: appCOlor),
                                Text(
                                  job.location,
                                  style: appTitleStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: appCOlor,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  job.workType,
                                  style: appTitleStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: appCOlor,
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
              },
            ),
    );
  }
}
