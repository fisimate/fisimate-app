class Leaderboard {
  bool success;
  String message;
  List<LeaderboardData> data;

  Leaderboard({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      success: json['success'],
      message: json['message'],
      data: List<LeaderboardData>.from(
        json['data'].map(
          (x) => LeaderboardData.fromJson(x),
        ),
      ),
    );
  }
}

class LeaderboardData {
  LeaderboardSum sum;
  String userId;
  LeaderboardUser user;

  LeaderboardData({
    required this.sum,
    required this.userId,
    required this.user,
  });

  factory LeaderboardData.fromJson(Map<String, dynamic> json) {
    return LeaderboardData(
      sum: LeaderboardSum.fromJson(json['_sum']),
      userId: json['userId'],
      user: LeaderboardUser.fromJson(json['user']),
    );
  }
}

class LeaderboardSum {
  int score;

  LeaderboardSum({
    required this.score,
  });

  factory LeaderboardSum.fromJson(Map<String, dynamic> json) {
    return LeaderboardSum(
      score: json['score'],
    );
  }
}

class LeaderboardUser {
  String? id;
  String? email;
  String? fullname;
  String? nis;
  String? profilePicture;
  LeaderboardUserRole? role;

  LeaderboardUser({
    this.id,
    this.email,
    this.fullname,
    this.nis,
    this.profilePicture,
    this.role,
  });

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) {
    return LeaderboardUser(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      nis: json['nis'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      role: LeaderboardUserRole.fromJson(
        json['role'] ?? {},
      ),
    );
  }
}

class LeaderboardUserRole {
  String? name;

  LeaderboardUserRole({
    this.name,
  });

  factory LeaderboardUserRole.fromJson(Map<String, dynamic> json) {
    return LeaderboardUserRole(
      name: json['name'] ?? '',
    );
  }
}
