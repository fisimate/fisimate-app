String matchLeaderBoardIconByRank(int rank) {
  switch (rank) {
    case 1:
      return "assets/icons/first.png";
    case 2:
      return "assets/icons/second.png";
    case 3:
      return "assets/icons/third.png";
    default:
      return "assets/icons/first.png";
  }
}
