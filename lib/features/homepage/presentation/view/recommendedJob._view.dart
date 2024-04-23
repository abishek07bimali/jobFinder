import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/presentation/view/individualJob_view.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/favorite_View_model.dart';

class RecommendedJobsWidget extends ConsumerStatefulWidget {
  final JobsEntity job;

  const RecommendedJobsWidget({Key? key, required this.job}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecommendedJobsWidgetState();
}

class _RecommendedJobsWidgetState extends ConsumerState<RecommendedJobsWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(favoriteViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userState.showMessage!) {
        ref.read(favoriteViewModelProvider.notifier).resetMessage();
      }
    });
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => JobDetail(jobs: widget.job),
        ));
      },
      child: Card(
        child: Stack(
          children: [
            Image.network(
              widget.job.image,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(top: 4.0, left: 8),
                color: Colors.black.withOpacity(0.5),
                child: SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.companyName,
                        style: const TextStyle(
                          color: appwhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.job.jobsTitle,
                        style: const TextStyle(
                          color: appwhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.job.workType,
                        style: const TextStyle(
                          color: appwhite,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: appwhite, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            widget.job.location,
                            style: const TextStyle(color: appwhite),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: isFavorite ? appCOlor : appwhite,
                            ),
                            onPressed: () {
                              setState(() async {
                                isFavorite = !isFavorite;
                                String? userId;
                                var userData = await ref
                                    .read(userSharedPrefsProvider)
                                    .getUser();

                                if (userData != null) {
                                  userId = userData['_id']?.toString();
                                  FavoriteEntiry booking = FavoriteEntiry(
                                    userId: userId.toString(),
                                    jobsId: widget.job.jobsId.toString(),
                                  );
                                  // ignore: use_build_context_synchronously
                                  ref
                                      .read(favoriteViewModelProvider.notifier)
                                      .createFavorite(booking,context);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
