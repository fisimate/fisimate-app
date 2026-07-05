import 'package:fisimate/app/config/services/dashboard_api_service.dart';
import 'package:fisimate/app/config/services/question_api_service.dart';
import 'package:fisimate/app/config/services/quiz_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/data/responses/dashboard/get_leaderboard.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/get_quiz_result_response.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/get_quiz_review_response.dart';
import 'package:fisimate/app/data/responses/simulation/quiz/post_answer_response.dart';
import 'package:fisimate/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SimulationResultController extends GetxController {
  final RxInt _quizScore = 0.obs;
  int get quizScore => _quizScore.value;

  final RxInt _answeredQuestions = 0.obs;
  int get answeredQuestions => _answeredQuestions.value;

  final RxInt _notAnsweredQuestions = 0.obs;
  int get notAnsweredQuestions => _notAnsweredQuestions.value;

  final RxInt _wrongAnswers = 0.obs;
  int get wrongAnswers => _wrongAnswers.value;

  final RxInt _correctAnswers = 0.obs;
  int get correctAnswers => _correctAnswers.value;

  final RxList<LeaderboardData> _leaderboardData = <LeaderboardData>[].obs;
  List<LeaderboardData> get leaderboardData => _leaderboardData;

  void getQuizResultOverview() async {
    final PostAnswerResponse passedResultData = Get.arguments['postAnswerResponse'];
    _quizScore.value = passedResultData.score;
    _answeredQuestions.value = passedResultData.answered;
    _notAnsweredQuestions.value = passedResultData.notAnswered;

    final String simulationId = Get.arguments['simulationId'];
    final dynamic quizResultResponse = await QuestionApiService().getQuizResult(
      accessToken: await StorageService.getAccessToken() ?? '',
      simulationId: simulationId,
    );
    if (quizResultResponse is QuizResultResponse) {
      _correctAnswers.value = quizResultResponse.data.correctResponses;
      _wrongAnswers.value = quizResultResponse.data.incorrectResponses;
    }
  }

  void getLeaderboard() async {
    final dynamic leaderboardResponse = await DashboardApiService().getLeaderboard(
      accessToken: await StorageService.getAccessToken() ?? '',
    );

    if (leaderboardResponse is Leaderboard) {
      _leaderboardData.value = leaderboardResponse.data.take(3).toList();
    }
  }

  RxString filePath = ''.obs;

  Future<void> getQuizReview() async {
    final QuizApiService quizApiService = QuizApiService();
    final response = await quizApiService.getQuizReviewBySimulationId(
      accessToken: await StorageService.getAccessToken() ?? '',
      simulationId: Get.arguments['simulationId'],
    );

    if (response is GetQuizReviewResponse) {
      print(response.data.filePath);
      filePath.value = response.data.filePath ?? '';
    }
  }

  void moveToQuizReview() {
    Get.toNamed(
      Routes.MODULE_VIEWER,
      arguments: {
        'type': 'quiz_review',
        'data': filePath.value,
      },
    );
  }

  @override
  void onInit() {
    getQuizResultOverview();
    super.onInit();
  }

  @override
  void onReady() {
    getLeaderboard();
    getQuizReview();
    super.onReady();
  }
}
