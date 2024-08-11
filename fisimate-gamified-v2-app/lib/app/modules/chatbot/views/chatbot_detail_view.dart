import 'package:fisimate/app/config/state/result_state.dart';
import 'package:fisimate/app/models/generated_physics_exam.dart';
import 'package:fisimate/app/modules/chatbot/controllers/chatbot_controller.dart';
import 'package:fisimate/app/modules/chatbot/views/widgets/bubble_chat_widget.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/theme/sizing.dart';
import 'package:fisimate/app/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChatbotDetailView extends StatelessWidget {
  const ChatbotDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatbotController controller = Get.find<ChatbotController>();

    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: GetBuilder<ChatbotController>(
                  id: 'dropdown',
                  builder: (controller) {
                    return CustomDropdown(
                      dropdownItems: controller.dropdownItems,
                      onItemSelected: (String value) {
                        controller.selectedChapter = value;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: InkWell(
                    onTap: () {
                      if (controller.resultState != ResultState.loading) {
                        controller.addMessage(
                          controller.selectedChapter,
                        );
                      } else {
                        null;
                      }
                    },
                    child: GetBuilder<ChatbotController>(
                        id: 'sendButton',
                        builder: (controller) {
                          Color buttonColor;

                          switch (controller.resultState) {
                            case ResultState.initial:
                              buttonColor = CustomColor.bankRumus;
                              break;
                            case ResultState.loading:
                              buttonColor = CustomColor.darkGreyColor;
                              break;
                            case ResultState.hasData:
                              buttonColor = CustomColor.bankRumus;
                              break;
                            default:
                              buttonColor = CustomColor.bankRumus;
                              break;
                          }

                          return Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: AnimatedContainer(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: buttonColor,
                              ),
                              duration: Durations.medium2,
                              child: GetBuilder<ChatbotController>(
                                id: 'sendButton',
                                builder: (controller) {
                                  switch (controller.resultState) {
                                    case ResultState.initial:
                                      return SvgPicture.asset(
                                        'assets/icons/send.svg',
                                      );
                                    case ResultState.loading:
                                      return CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          CustomColor.whiteColor,
                                        ),
                                      );
                                    case ResultState.hasData:
                                      return SvgPicture.asset(
                                        'assets/icons/send.svg',
                                      );
                                    default:
                                      return SvgPicture.asset(
                                        'assets/icons/send.svg',
                                      );
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () {
          return Stack(
            children: <Widget>[
              Center(
                  child: Opacity(
                opacity: 0.4,
                child: SvgPicture.asset(
                  'assets/logos/fisimate_logo.svg',
                  height: 150,
                ),
              )),
              ListView(
                controller: controller.scrollController,
                children: [
                  for (var message in controller.chatMessages)
                    if (message is Message)
                      BubbleChatWidget(
                        text: message.text,
                        isSender: message.isSender,
                        isTail: message.isTail,
                      )
                    else if (message is AnswerImage)
                      BubbleChatWidget.image(
                        imageUrl: message.imageUrl,
                        isSender: false,
                        isTail: false,
                      )
                    else if (message is CircularProgressIndicator)
                      const CircularProgressIndicator()
                    else if (message is GeneratedPhycsicsExam)
                      BubbleChatWidget.generated(
                        question: message.question,
                        optionList: message.optionList,
                        rightAnswer: message.rightAnswer,
                        explanation: message.explanation,
                        isSender: false,
                        isTail: false,
                        onTrueAnswer: () {
                          debugPrint("The answer is correct");
                          controller.setIsQuizAnswerAlertDisplayed(
                            value: true,
                            isAnswerCorrect: true,
                          );
                        },
                        onFalseAnswer: () {
                          debugPrint("The answer is wrong");
                          controller.setIsQuizAnswerAlertDisplayed(
                            value: true,
                            isAnswerCorrect: false,
                          );
                        },
                      )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class BubbleChat extends StatelessWidget {
  final bool isMe;
  const BubbleChat({
    super.key,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            constraints: BoxConstraints(
              maxWidth: CustomSize.maxWidth * 0.6,
            ),
            decoration: BoxDecoration(
              color: CustomColor.bankRumus,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Apa itu Hukum Newton?',
                  style: subHeadingRegular.copyWith(
                    color: CustomColor.whiteColor,
                  ),
                ),
                const Gap(5.0),
                Text(
                  '10:00',
                  style: bodyMedium.copyWith(
                    fontSize: 12,
                    color: CustomColor.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            constraints: BoxConstraints(
              maxWidth: CustomSize.maxWidth * 0.6,
            ),
            decoration: BoxDecoration(
              color: CustomColor.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Hi, Nabila! Tanyakan apapun tentang fisika dengan My Fisimate',
                  style: subHeadingRegular,
                  overflow: TextOverflow.visible,
                ),
                const Gap(5.0),
                Text(
                  '10:00',
                  style: bodyMedium.copyWith(
                    fontSize: 12,
                    color: CustomColor.darkGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
