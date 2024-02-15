import 'package:fisimate/app/theme/colors.dart';
import 'package:fisimate/app/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatbotDetailView extends StatelessWidget {
  const ChatbotDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColor.greyColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ketik pesan di sini...',
                    hintStyle: subHeadingRegular,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CustomColor.bankRumus,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.send,
                    color: CustomColor.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        reverse: true,
        children: const [
          BubbleChat(isMe: true),
          BubbleChat(),
        ],
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
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
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
              style: subHeadingRegular.copyWith(color: CustomColor.whiteColor),
            ),
            const Gap(5.0),
            Text(
              '10:00',
              style: bodyMedium.copyWith(
                  fontSize: 12, color: CustomColor.whiteColor),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: CustomColor.greyColor.withOpacity(0.3),
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
            ),
            const Gap(5.0),
            Text(
              '10:00',
              style: bodyMedium.copyWith(
                  fontSize: 12, color: CustomColor.darkGreyColor),
            ),
          ],
        ),
      );
    }
  }
}
