import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:job_finder/config/constants/hive_table_constant.dart';
import 'package:job_finder/features/auth/data/model/user_hive_model.dart';
import 'package:job_finder/features/homepage/data/model/jobs_hive_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(JobsHiveModelAdapter());
  }

  Future<void> createUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<void> createJobs(JobsHiveModel jobs) async {
    var box = await Hive.openBox<JobsHiveModel>(HiveTableConstant.jobBox);
    await box.put(jobs.jobsId, jobs);
    print(jobs);
  }

  Future<List<JobsHiveModel>> getAllJobs() async {
    var box = await Hive.openBox<JobsHiveModel>(HiveTableConstant.jobBox);
    var jobs = box.values.toList();
    return jobs;
  }
}
