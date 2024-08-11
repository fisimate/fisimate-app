import 'package:fisimate/app/utils/enums/button_nav_type_enum.dart';

abstract class TextHelper {
  static String matchSimulationNavigationLabelByIndex({
    required ButtonNavTypeEnum buttonType,
    required int sectionIndex,
    required int quizIndex,
    required int quizLength,
  }) {
    switch (sectionIndex) {
      case 0:
        if (buttonType == ButtonNavTypeEnum.next) {
          return "Percobaan";
        } else {
          return "Materi";
        }
      case 1:
        if (buttonType == ButtonNavTypeEnum.next) {
          return "Kuis";
        } else {
          return "Materi";
        }
      case 2:
        if (buttonType == ButtonNavTypeEnum.next) {
          if (quizIndex == quizLength - 1) {
            return "Selesai";
          } else {
            return "Soal Selanjutnya";
          }
        } else {
          if (quizIndex == 0) {
            return "Percobaan";
          } else {
            return "Soal Sebelumnya";
          }
        }
      default:
        return "Percobaan";
    }
  }
}
