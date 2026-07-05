import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class URLs {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

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

  // START - Contents Bank

  // GET - Exam Bank
  static const String examBank = 'exam-banks';
  // GET - Material Bank
  static const String materialBank = 'material-banks';
  // GET - Formula Bank
  static const String formulaBank = 'formula-banks';

  // END - Contents Bank

  // START - Simulation

  // GET - Simulation
  static const String simulation = 'simulations';
  // GET - Simulation Quiz
  static const String simulationQuiz = 'quizzes';

  // END - Simulation

  // START - User Profile

  // GET - User Profile
  static const String userProfile = 'users/profile';

  // PUT - Update User Profile
  static const String updateUserProfile = 'users/update';

  // PUT - Update User Picture
  static const String updateUserPicture = 'users/profile/picture';

  // END - User Profile

  // START - Chatbot

  // POST - Generate Chatbot Question
  static const String chatbotGenerate = 'chatbot/generate-question';

  // END - Chatbot
}
