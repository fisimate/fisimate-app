import 'package:fisimate_flutter_app/app/theme/colors.dart';
import 'package:fisimate_flutter_app/app/theme/fonts.dart';
import 'package:fisimate_flutter_app/app/theme/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ChatbotDetailView extends StatelessWidget {
  const ChatbotDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TextField(
                      style: subHeadingRegular,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan di sini...',
                        hintStyle: subHeadingRegular.copyWith(
                          color: CustomColor.greyColor,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/icons/emoji.svg',
                            height: 25,
                          ),
                        ),
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
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/send.svg',
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                  style:
                      subHeadingRegular.copyWith(color: CustomColor.whiteColor),
                ),
                const Gap(5.0),
                Text(
                  '10:00',
                  style: bodyMedium.copyWith(
                      fontSize: 12, color: CustomColor.whiteColor),
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
