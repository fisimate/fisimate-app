import 'dart:developer';

import 'package:get/get_utils/src/get_utils/get_utils.dart';

class ValidationHelper {
  static String? validateEmail(String value) {
    if (value.isEmpty || value == '') {
      return 'Masukkan email anda';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Masukkan email yang valid';
    }

    if (value.contains(' ') || value.contains('   ')) {
      return 'Email tidak boleh mengandung spasi';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty || value == '') {
      return 'Masukkan kata sandi';
    } else if (value.contains(' ')) {
      return 'Password tidak boleh mengandung spasi';
    } else if (!GetUtils.isLengthGreaterThan(value, 7)) {
      return 'Minimal 8 kata';
    } else if (!RegExp(r"^(?=.*[a-z])").hasMatch(value)) {
      return "Masukkan 1 huruf kecil";
    } else if (!RegExp(r"^(?=.*[A-Z])").hasMatch(value)) {
      return "Masukkan 1 huruf besar";
    } else if (!RegExp(r"^(?=.*\d)").hasMatch(value)) {
      return "Masukkan setidaknya 1 angka";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
      {required String confirmPassword, required String password}) {
    if (confirmPassword.isEmpty || confirmPassword == '') {
      return 'Masukkan ulang kata sandi';
    } else if (confirmPassword != password) {
      return 'Kata sandi tidak sesuai!';
    } else {
      return null;
    }
  }

  static String? validateName(String value) {
    if (value.isEmpty || value == ' ') {
      return 'Nama tidak boleh kosong';
    } else if (value.length < 4 || value.trim().length < 4) {
      return 'Minimal 4 karakter';
    } else if (RegExp(r'[0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\-]').hasMatch(value)) {
      return 'Nama tidak boleh mengandung angka dan simbol!';
    } else {
      return null;
    }
  }

  static String? validateNomorInduk(String value) {
    if (value.isEmpty || value == '') {
      log('Nomor harus diisi');
      return 'Nomor tidak boleh kosong!';
    } else if (!RegExp(r"^(?=.*\d)").hasMatch(value)) {
      return "Masukkan setidaknya 1 angka";
    }
    return null;
  }
}
