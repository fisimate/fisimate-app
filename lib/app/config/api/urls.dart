abstract class URLs {
  static const String baseUrl = 'http://47.236.10.27/api/v1/';

  // START - Auth

  // POST - Login
  static const String login = 'auth/login';
  // POST - Register
  static const String register = 'auth/register';
  // GET - Login w/ Google
  static const String loginWithGoogle = 'auth/google';
  // GET - Refresh Token
  static const String refreshToken = 'auth/token/refresh';
  // POST - Logout
  static const String logout = 'auth/logout';

  // END - Auth

  // START - Exam Bank
  static const String examBank = 'exam-banks';
  static const String materialBank = 'material-banks';
  static const String formulaBank = 'formula-banks';
}
