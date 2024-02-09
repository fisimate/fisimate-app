abstract class URLs {
  static const String baseUrl = 'http://47.236.10.27/api/v1/';

  // START - Auth

  // POST - Login
  static const String login = 'auth/login';
  // POST - Register
  static const String register = 'auth/register';
  // GET - Login w/ Google
  static const String loginWithGoogle = 'auth/google';

  // END - Auth

  // START - Exam Bank
  static const String examBank = 'exam-banks';
}
