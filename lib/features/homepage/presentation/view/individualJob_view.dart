import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_finder/config/themes/theme_colors.dart';
import 'package:job_finder/core/common/common_text.dart';
import 'package:job_finder/core/common/snackbar/snackbar.dart';
import 'package:job_finder/core/shared_pref/user_shared_prefs.dart';
import 'package:job_finder/features/homepage/domain/entity/favorite_entity.dart';
import 'package:job_finder/features/homepage/domain/entity/jobs_entity.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/application_View_model.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/comment_View_model.dart';
import 'package:job_finder/features/homepage/presentation/viewmodel/favorite_View_model.dart';
import 'package:job_finder/features/homepage/presentation/widgets/company_tab.dart';
import 'package:job_finder/features/homepage/presentation/widgets/description_tab.dart';

// ignore: must_be_immutable
class JobDetail extends ConsumerStatefulWidget {
  final JobsEntity? jobs;
  bool? isLiked = false;
  JobDetail({this.jobs, this.isLiked});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobDetailState();
}

class _JobDetailState extends ConsumerState<JobDetail> {
  // bool isFavorite = false;
  late bool isFavorite;
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isLiked ?? false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .watch(commentViewModelProvider.notifier)
          .getComments(widget.jobs?.jobsId ?? "");
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(applicationViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userState.showMessage!) {
        showMySnackBar(
          message: userState.message ?? "",
          context: context,
          color: appCOlor,
        );
        ref.read(applicationViewModelProvider.notifier).resetMessage();
      }
    });
    return Scaffold(
      backgroundColor: appCOlor,
      appBar: AppBar(
        backgroundColor: appCOlor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: appwhite,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.jobs!.jobsTitle,
          style: appTitleStyle.copyWith(
              fontWeight: FontWeight.bold, color: appwhite),
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 3,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          decoration: const BoxDecoration(
            color: appwhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  // constraints: BoxConstraints(maxHeight: 250.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: NetworkImage(widget.jobs!.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        widget.jobs!.jobsTitle,
                        style: appTitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        widget.jobs!.salary,
                        style: appTitleStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Material(
                        color: appwhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color: kBlack.withOpacity(.2),
                          ),
                        ),
                        // borderRadius: BorderRadius.circular(12.0),
                        child: TabBar(
                          unselectedLabelColor: kBlackAccent,
                          indicator: BoxDecoration(
                            color: appCOlor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          tabs: const [
                            Tab(text: "Description"),
                            Tab(text: "Company"),
                            Tab(text: "Comments"),

                            // _buildCommentsSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    children: [
                      DescriptionTab(company: widget.jobs),
                      CompanyTab(jobs: widget.jobs),
                      // CompanyTab(jobs: widget.jobs),
                      _buildCommentsSection()
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Text("Comments"),
                // SizedBox( height:200,child: _buildCommentsSection()),
                // const SizedBox(height: 10),
                _buildCommentInputSection(widget.jobs?.jobsId ?? ""),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          padding: const EdgeInsets.only(left: 18.0, bottom: 25.0, right: 18.0),
          // margin: EdgeInsets.only(bottom: 25.0),
          color: appwhite,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: kBlack.withOpacity(.5)),
                  //   borderRadius: BorderRadius.circular(12.0),
                  // ),
                  child: IconButton(
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
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBookingDetailsDialog(widget.jobs!);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        "Apply for Job",
                        style: TextStyle(
                          color: appwhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showBookingDetailsDialog(JobsEntity jobsEntity) async {
    DateTime now = DateTime.now();
    DateTime? appliedBeforeTime = widget.jobs?.applyBefore != null
        ? DateTime.parse(widget.jobs!.applyBefore)
        : null;
    final user = await ref.read(userSharedPrefsProvider).getUser();
    final bool isVerified = user?['isVerified'] ?? false;

    if (!isVerified) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Application Closed')),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                commonText(
                    text: "You Are not Verified! Please verify Yourself!",
                    fontSize: 20),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );

      return;
    }
    if (appliedBeforeTime != null && now.isBefore(appliedBeforeTime)) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Apply Jobs ')),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                commonText(
                    text: "Do you want to apply for this job?", fontSize: 20),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref
                      .read(applicationViewModelProvider.notifier)
                      .createApplication(widget.jobs!.jobsId.toString());
                  Navigator.of(context).pop();
                },
                child: const Text('Apply'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Application Closed')),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                commonText(
                    text: "Sorry, the application deadline has passed.",
                    fontSize: 20),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  void _handleFavoriteAction() async {
    String? userId;
    var userData = await ref.read(userSharedPrefsProvider).getUser();

    if (userData != null) {
      userId = userData['_id']?.toString();
      FavoriteEntiry booking = FavoriteEntiry(
        userId: userId.toString(),
        jobsId: widget.jobs?.jobsId,
      );
      // ignore: use_build_context_synchronously
      ref
          .read(favoriteViewModelProvider.notifier)
          .createFavorite(booking, context);
    }
  }

  Widget _buildCommentsSection() {
    final commentState = ref.watch(commentViewModelProvider);
    if (commentState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Flexible(
        child: ListView.builder(
          itemCount: commentState.comment.length,
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final comment = commentState.comment[index];
            return ListTile(
              leading: _buildLeading(comment.image),
              title: Text(comment.firstName ?? ""),
              subtitle: Text(comment.comment!),
            );
          },
        ),
      );
    }
  }

  Widget _buildLeading(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      );
    } else {
      return CircleAvatar(
        child: Icon(Icons.person),
      );
    }
  }

  Widget _buildCommentInputSection(String jobId) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Write a comment...',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (_commentController.text.trim().isNotEmpty) {
              ref
                  .read(commentViewModelProvider.notifier)
                  .createComment(jobId, _commentController.text);
              _commentController.clear();
            } else {
              showMySnackBar(
                  message: "Comment cannot be empty",
                  context: context,
                  color: appRed);
            }
          },
          icon: const Icon(Icons.send, color: appCOlor),
          tooltip: 'Save',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
