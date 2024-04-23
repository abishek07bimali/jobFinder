import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/presentation/view/individualJob_view.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/favorite_View_model.dart';

class JobCardWidget extends ConsumerStatefulWidget {
  final JobsEntity job;

  const JobCardWidget({Key? key, required this.job}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobCardWidgetState();
}

class _JobCardWidgetState extends ConsumerState<JobCardWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // final userState = ref.watch(favoriteViewModelProvider);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (userState.showMessage!) {
    //     showMySnackBar(
    //       message: userState.message ?? "",
    //       context: context,
    //       color: appCOlor,
    //     );
    //     ref.read(favoriteViewModelProvider.notifier).resetMessage();
    //   }
    // });
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => JobDetail(jobs: widget.job),
        ));
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 8.0),
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
                    child: Image.network(widget.job.image),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.job.companyName,
                        style: appTitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.job.jobsTitle,
                        style: appTitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: isFavorite ? appCOlor : appCOlor,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      _handleFavoriteAction();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.location_on, color: appCOlor),
                  Text(
                    widget.job.location,
                    style: appTitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: appCOlor),
                  ),
                  Spacer(),
                  Text(
                    widget.job.workType,
                    style: appTitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: appCOlor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _handleFavoriteAction() async {
    String? userId;
    var userData = await ref.read(userSharedPrefsProvider).getUser();

    if (userData != null) {
      userId = userData['_id']?.toString();
      FavoriteEntiry booking = FavoriteEntiry(
        userId: userId.toString(),
        jobsId: widget.job.jobsId,
      );
      // ignore: use_build_context_synchronously
      ref
          .read(favoriteViewModelProvider.notifier)
          .createFavorite(booking, context);
    }
  }
}
