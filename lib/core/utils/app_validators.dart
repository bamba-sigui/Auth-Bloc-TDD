import '../error/error_message.dart';
import 'app_constants.dart';
import 'package:flutter/material.dart';

class AppInputValidators {
  static String? emptyValue(value) {
    if (value.isEmpty || value.trim() == "") {
      return 'Veuillez renseigner une valeur';
    }
    return null;
  }

  static Function civMsisdn = (String value) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else if (value.isNotEmpty && value.length != 10) {
      return 'Numéro non valide';
    }
    return null;
  };

  static Function msisdn = (String value, int length) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else if (value.isNotEmpty && value.length != length) {
      return 'Numéro non valide';
    }
    return null;
  };

  static Function uemoaMsisdn = (String value) {
    final uemoaCountryCode = ["+228", "+229", "+226", "+225", "+245", "+223", "+227", "+221"];

    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else if (!value.startsWith("+")) {
      return AppErrorMessage.phoneNumberPrefixNotPresent;
    } else if (value.split("+").length > 2) {
      return AppErrorMessage.phoneNumberNotValid;
    } else if (value.length >= 4 && !uemoaCountryCode.contains(value.substring(0, 4))) {
      return AppErrorMessage.phoneNumberNotValid;
    } else {
      if (value.length >= 4) {
        String preffix = value.substring(0, 4);
        final phoneNumberWithoutPrefix = value.replaceAll(preffix, "");
        int minMsisdnValue = 8;
        int maxMsidnValue = 10;

        if (preffix == "+245") {
          minMsisdnValue = 6;
        }
        if (!(phoneNumberWithoutPrefix.length >= minMsisdnValue && phoneNumberWithoutPrefix.length <= maxMsidnValue)) return AppErrorMessage.phoneNumberNotValid;
      } else {
        return AppErrorMessage.phoneNumberNotValid;
      }
    }

    return null;
  };

  static Function text = (String value) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    }
    return null;
  };

  static Function passCode = (String value) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else {
      if (value.length == AppConstants.pass_code_valid_input_length) {
        if (value.replaceAll(value[0], "") == "") {
          return AppErrorMessage.passCodeConsecutiveCharacters;
        }
      } else {
        return "${AppConstants.pass_code_valid_input_length} caractères requis";
      }
    }
    return null;
  };

  static Function email = (String value) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else {
      RegExp emailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.+-^_]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (emailPattern.hasMatch(value) != true || value.split("@").length > 2) {
        return AppErrorMessage.emailNotValid;
      }
    }

    return null;
  };

  static Function otp = (String value, int length) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else {
      if (value.length != length) {
        return "$length caractères requis";
      }
    }
    return null;
  };

  static Function amount = (String value, double min, double max) {
    if (emptyValue(value) != null) {
      return emptyValue(value);
    } else {
      double _doubleValue = double.parse(value);
      if (_doubleValue < min) {
        return "Entrer un montant supérieur à ${min.toInt()} F CFA";
      } else if (_doubleValue > max) {
        return "Le montant dépasse le maximum autorisé";
      }
    }
    return null;
  };

  static bool dateGreaterThanMinimumDays(DateTime targetDate, [int minimumDays = 7]) {
    final _minimumDateTime = DateUtils.dateOnly(DateTime.now()).add(Duration(days: minimumDays));
    final bool _isDateValid = (targetDate.compareTo(_minimumDateTime) >= 0);
    return _isDateValid;
  }
}