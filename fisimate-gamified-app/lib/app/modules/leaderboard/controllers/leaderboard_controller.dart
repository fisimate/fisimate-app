import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  final List topLeaderboard = [
    {'position': 2, 'name': 'Rafi Aditya', 'score': 100},
    {'position': 1, 'name': 'Nabila Norhaliza', 'score': 100},
    {'position': 3, 'name': 'Rizky Ramadhan', 'score': 100},
  ];

  final List regularLeaderboard = [
    {'position': 4, 'name': 'You', 'score': 100},
    {'position': 5, 'name': 'Rafi Aditya', 'score': 90},
    {'position': 6, 'name': 'Nabila Norhaliza', 'score': 80},
    {'position': 7, 'name': 'Rizky Ramadhan', 'score': 70},
    {'position': 8, 'name': 'Rafi Aditya', 'score': 60},
    {'position': 9, 'name': 'Nabila Norhaliza', 'score': 50},
    {'position': 10, 'name': 'Rizky Ramadhan', 'score': 40},
    {'position': 10, 'name': 'Rizky Ramadhan', 'score': 40},
    {'position': 10, 'name': 'Rizky Ramadhan', 'score': 40},
    {'position': 10, 'name': 'Rizky Ramadhan', 'score': 40},
  ];

  PageController pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 1,
  );
}
