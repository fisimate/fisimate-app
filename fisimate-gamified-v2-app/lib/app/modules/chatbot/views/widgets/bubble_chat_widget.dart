import 'package:fisimate/app/models/generated_physics_exam.dart';
import 'package:fisimate/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BubbleChatWidget extends StatefulWidget {
  const BubbleChatWidget({
    super.key,
    required this.text,
    required this.isTail,
    required this.isSender,
    this.isImage = false,
    this.isGeneratedFromGemini = false,
    this.imageUrl,
    this.question,
    this.optionList,
    this.rightAnswer,
    this.explanation,
    this.onTrueAnswer,
    this.onFalseAnswer,
  });

  // Named constructor for image bubbles
  const BubbleChatWidget.image({
    super.key,
    required this.imageUrl,
    required this.isTail,
    required this.isSender,
  })  : text = '',
        isGeneratedFromGemini = false,
        question = null,
        optionList = null,
        rightAnswer = null,
        explanation = null,
        onTrueAnswer = null,
        onFalseAnswer = null,
        isImage = true;

  // Named constructor for generated messages from Gemini
  const BubbleChatWidget.generated({
    super.key,
    required this.question,
    required this.optionList,
    required this.rightAnswer,
    required this.explanation,
    required this.isTail,
    required this.isSender,
    required this.onTrueAnswer,
    required this.onFalseAnswer,
  })  : text = "",
        isImage = false,
        isGeneratedFromGemini = true,
        imageUrl = null;

  final bool isImage;
  final bool isGeneratedFromGemini;
  final String? question;
  final List<Option>? optionList;
  final String? rightAnswer;
  final String? explanation;
  final String? imageUrl;
  final String text;
  final bool isTail;
  final bool isSender;
  final Function()? onTrueAnswer;
  final Function()? onFalseAnswer;

  @override
  State<BubbleChatWidget> createState() => _BubbleChatWidgetState();
}

class _BubbleChatWidgetState extends State<BubbleChatWidget> {
  int _selectedIndex = -1;
  late int _answerIndex;

  bool isSubmitted = false;
  bool isTrue = false;
  bool isFalse = false;

  @override
  void initState() {
    widget.isGeneratedFromGemini
        ? _answerIndex =
            widget.optionList!.indexWhere((element) => element.correct == true)
        : _answerIndex = -1;
    super.initState();
  }

  void _onOptionSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSubmit() {
    if (_selectedIndex == _answerIndex) {
      widget.onTrueAnswer!();
      setState(() {
        isTrue = true;
      });
    } else {
      widget.onFalseAnswer!();
      setState(() {
        isFalse = true;
      });
    }
    setState(() {
      isSubmitted = true;

      final ChatbotController controller = Get.find<ChatbotController>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.scrollToBottom();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper5(
        type:
            widget.isSender ? BubbleType.sendBubble : BubbleType.receiverBubble,
      ),
      alignment: widget.isSender ? Alignment.topRight : Alignment.topLeft,
      shadowColor: CustomColor.transparentColor,
      margin: const EdgeInsets.only(
        left: 20,
        top: 5,
        right: 20,
        bottom: 5,
      ),
      backGroundColor:
          widget.isSender ? CustomColor.bankRumus : CustomColor.backgroundColor,
      child: widget.isImage
          ? Container(
              padding: EdgeInsets.only(
                right: widget.isSender ? 5 : 0,
                left: widget.isSender ? 0 : 5,
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  right: 5,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    widget.imageUrl!,
                  ),
                ),
              ),
            )
          : widget.isGeneratedFromGemini
              ? Container(
                  padding: EdgeInsets.only(
                    right: widget.isSender ? 5 : 0,
                    left: widget.isSender ? 0 : 5,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.question!,
                        style: subHeadingRegular.copyWith(
                          color: widget.isSender
                              ? CustomColor.whiteColor
                              : CustomColor.blackColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var option in widget.optionList!)
                        GestureDetector(
                          onTap: () {
                            isSubmitted == false
                                ? _onOptionSelected(
                                    widget.optionList!.indexOf(option))
                                : null;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 5,
                            ),
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(
                              minWidth: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedIndex ==
                                      widget.optionList!.indexOf(option)
                                  ? isTrue
                                      ? CustomColor.lightGreenColor
                                      : isFalse
                                          ? CustomColor.lightRedColor
                                          : CustomColor.seaBlueColor
                                  : CustomColor.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: CustomColor.bankRumus,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              option.option,
                              style: subHeadingRegular.copyWith(
                                color: CustomColor.blackColor,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 10),
                      isSubmitted == false
                          ? Center(
                              child: ElevatedButton(
                                onPressed:
                                    _selectedIndex == -1 ? null : _onSubmit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColor.bankRumus,
                                ),
                                child: Text(
                                  "Cek Jawaban".toUpperCase(),
                                  style: subHeadingBold.copyWith(
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      isSubmitted
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Gap(10),
                                Text(
                                  "Jawaban Benar:",
                                  style: subHeadingMedium,
                                ),
                                Text(
                                  widget.rightAnswer!,
                                  style: subHeadingRegular,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      isSubmitted
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Gap(10),
                                Text(
                                  "Pembahasan:",
                                  style: subHeadingMedium,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: subHeadingRegular.copyWith(
                                      color: CustomColor.blackColor,
                                    ),
                                    children: formatText(
                                      widget.explanation!,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(
                    right: widget.isSender ? 5 : 0,
                    left: widget.isSender ? 0 : 5,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    widget.text,
                    style: subHeadingRegular.copyWith(
                      color: widget.isSender
                          ? CustomColor.whiteColor
                          : CustomColor.blackColor,
                    ),
                  ),
                ),
    );
  }

  List<TextSpan> formatText(String text) {
    return text.split('\n').map((str) => TextSpan(text: '$str\n')).toList();
  }
}
