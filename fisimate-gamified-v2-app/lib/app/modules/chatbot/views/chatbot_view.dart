import 'package:fisimate/app/modules/chatbot/views/chatbot_detail_view.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:fisimate/app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/chatbot_controller.dart';

class ChatbotView extends GetView<ChatbotController> {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatbotController());
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: CustomColor.whiteColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: CustomColor.bankRumus,
              foregroundImage: const AssetImage(
                'assets/icons/chatbot.png',
              ),
            ),
            const Gap(10.0),
            Text(
              'My Fisimate',
              style: headingSemiBold,
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: CustomColor.bankRumus,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            offset: const Offset(0, 50),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Bersihkan Chat',
                    style: poppinsRegular.copyWith(
                      color: CustomColor.whiteColor,
                    ),
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                controller.chatMessages.clear();
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(
        () {
          if (!controller.isStartingChatbot.value) {
            return StartingChatbotView(
              onTap: () {
                controller.isStartingChatbot.value = true;
              },
            );
          } else {
            return const ChatbotDetailView();
          }
        },
      ),
    );
  }
}

class StartingChatbotView extends StatelessWidget {
  final Function()? onTap;
  const StartingChatbotView({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/chatbot.png',
            width: 300,
          ),
          const Gap(20.0),
          Text('Selamat Datang!', style: headingBold),
          const Gap(10.0),
          Text(
            'Temukan kemudahan dan kecerdasan baru dengan bergabung bersama fitur chat bot kami!',
            textAlign: TextAlign.center,
            style: subHeadingRegular.copyWith(color: CustomColor.greyColor),
          ),
          const Gap(20.0),
          CustomFilledButton(onTap: onTap, text: 'Mulai'),
        ],
      ),
    );
  }
}
