import 'dart:convert';

import 'package:fisimate/app/config/services/chapter_api_service.dart';
import 'package:fisimate/app/config/services/storage_service.dart';
import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/domain/services/gemini_api_service.dart';
import 'package:fisimate/app/models/generated_physics_exam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';

class ChatbotController extends GetxController {
  final RxString _selectedChapter = ''.obs;
  String get selectedChapter => _selectedChapter.value;

  set selectedChapter(String value) {
    _selectedChapter.value = value;
  }

  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  RxBool isStartingChatbot = false.obs;

  late final GenerativeModel _model;
  GenerativeModel get model => _model;

  final RxList<dynamic> _chatMessages = [].obs;
  List<dynamic> get chatMessages => _chatMessages;

  final Rx<ResultState> _resultState = ResultState.initial.obs;
  ResultState get resultState => _resultState.value;

  final Logger _logger = Logger();
  Logger get logger => _logger;

  FocusNode focusNode = FocusNode();

  void unFocus() {
    focusNode.unfocus();
  }

  void addMessage(String messageText) {
    _chatMessages.add(
      Message(
        text: messageText,
        isSender: true,
        isTail: true,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });

    _resultState.value = ResultState.loading;
    update(['sendButton']);

    GeminiApiService.stringFromGemini(
      prompt: messageText,
    ).then(
      (response) {
        final generatedPhycsicsExam = GeneratedPhycsicsExam.fromJson(
          json.decode(
            response ?? '{}',
          ),
        );

        _resultState.value = ResultState.hasData;
        _chatMessages.add(
          GeneratedPhycsicsExam(
            question: generatedPhycsicsExam.question,
            optionList: generatedPhycsicsExam.optionList,
            rightAnswer: generatedPhycsicsExam.rightAnswer,
            explanation: generatedPhycsicsExam.explanation,
          ),
        );

        update(['sendButton']);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
      },
    ).catchError((error) {
      _resultState.value = ResultState.error;
      update(['sendButton']);
    });
  }

  final RxBool _isQuizAnswerAlertDisplayed = false.obs;
  bool get isQuizAnswerAlertDisplayed => _isQuizAnswerAlertDisplayed.value;

  final RxBool _isQuizAnswerCorrect = false.obs;
  bool get isQuizAnswerCorrect => _isQuizAnswerCorrect.value;

  void setIsQuizAnswerAlertDisplayed({
    required bool value,
    required bool isAnswerCorrect,
  }) {
    _isQuizAnswerAlertDisplayed.value = value;
    _isQuizAnswerCorrect.value = isAnswerCorrect;
    if (value) {
      Future.delayed(const Duration(seconds: 3), () {
        _isQuizAnswerAlertDisplayed.value = false;
      });
    }
  }

  final RxList<String> _dropdownItems = <String>[].obs;
  List<String> get dropdownItems => _dropdownItems;

  void getDropdownItems() async {
    final ChapterApiService chapterApiService = ChapterApiService();

    final dynamic = await chapterApiService.getAllChaptersName(
      accessToken: await StorageService.getAccessToken(),
    );

    if (dynamic is List<String>) {
      _dropdownItems.value = dynamic;
      update(['dropdown']);
      logger.i('Dropdown items fetched successfully');
    }
  }

  @override
  void onReady() {
    getDropdownItems();
    super.onReady();
  }
}

class Message {
  final String text;
  final bool isSender;
  final bool isTail;

  const Message({
    required this.text,
    required this.isSender,
    required this.isTail,
  });
}

class AnswerImage {
  final String imageUrl;

  const AnswerImage({
    required this.imageUrl,
  });
}
