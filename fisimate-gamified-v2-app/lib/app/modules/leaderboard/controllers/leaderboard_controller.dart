import 'package:fisimate/app/config/services/dashboard_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/data/responses/dashboard/get_leaderboard.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  final RxList<LeaderboardData> _topLeaderboard = <LeaderboardData>[].obs;
  List<LeaderboardData> get topLeaderboard => _topLeaderboard;

  final RxList<LeaderboardData> _regularLeaderboard = <LeaderboardData>[].obs;
  List<LeaderboardData> get regularLeaderboard => _regularLeaderboard;

  Future<void> getLeaderboard() async {
    final DashboardApiService dashboardApiService = DashboardApiService();
    final leaderboard = await dashboardApiService.getLeaderboard(
      accessToken: await StorageService.getAccessToken(),
    );

    if (leaderboard is Leaderboard) {
      _topLeaderboard.assignAll(leaderboard.data.take(3));
      _regularLeaderboard.assignAll(leaderboard.data.skip(3));
      update(['topLeaderboard']);
    }

    update(['regularLeaderboard', 'leaderboard_navigator']);
  }

  PageController pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );

  @override
  void onReady() async {
    await getLeaderboard();
    super.onReady();
  }
}
