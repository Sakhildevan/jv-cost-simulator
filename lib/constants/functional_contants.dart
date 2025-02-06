import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/filter_master_list.model.dart';
import '../data/model/load_simulator.model.dart';
import '../utils/enums.dart';
import '../utils/string_const.dart';

class FunctionalConstants {
  double getResponsiveWidth(
    SizingInformation size, {
    required double smallValue,
    required double normalValue,
    required double largeValue,
    required double extraLargeValue,
  }) {
    switch (size.refinedSize) {
      case RefinedSize.small:
        return size.screenSize.width * smallValue;
      case RefinedSize.normal:
        return size.screenSize.width * normalValue;
      case RefinedSize.large:
        return size.screenSize.width * largeValue;
      default:
        return size.screenSize.width * extraLargeValue;
    }
  }

// A method that formats a date based on the selected DateFormatType
  String formatDate({
    required DateTime date,
    required DateFormatType formatType,
  }) {
    // Choose the date format based on the enum value
    DateFormat dateFormat;
    switch (formatType) {
      case DateFormatType.dayMonthYear:
        dateFormat = DateFormat('d MMMM yyyy');
        break;
      case DateFormatType.dayMonYear:
        dateFormat = DateFormat('d MMM yyyy');
        break;
      case DateFormatType.dayMonthYearSlash:
        dateFormat = DateFormat('dd/MM/yyyy');
        break;
      case DateFormatType.yearMonthDaySlash:
        dateFormat = DateFormat('yyyy/MM/dd');
        break;
    }
    // Format the date and return the string
    return dateFormat.format(date);
  }
  //!*-------(store login credential)

  //Store login credential in local storage
  Future<void> storeLoginCredentials({
    required String token,
    required String mailId,
    required String password,
    required String userFirstName,
    required String userId,
    required String userRole,
    required bool isAdmin,
  }) async {
    await SharedPreferences.getInstance().then(
      (SharedPreferences pref) async {
        //*---(login token)
        await pref.setString(
          StringConst.loginToken,
          token,
        );
        //*---(user mail)
        await pref.setString(
          StringConst.userMailId,
          mailId.trim(),
        );
        //*-------(password value)
        await pref.setString(
          StringConst.passwordValue,
          password.trim(),
        );
        //*-------(userFirst name value)
        await pref.setString(
          StringConst.userFirstNameValue,
          userFirstName.trim(),
        );
        //*-------(user ID value)
        await pref.setString(
          StringConst.userId,
          userId.trim(),
        );
        //*-------(user Role value)
        await pref.setString(
          StringConst.userRole,
          userRole.trim(),
        );
        //*-------(isAdmin)
        await pref.setBool(
          StringConst.isAdmin,
          isAdmin,
        );
        //*-------(isLoggedIn)
        await pref.setString(
          StringConst.isLoggedIn,
          "true",
        );
      },
    );
  }

//*---------------(remove loginCredential)
  //Remove login credential in local storage
  Future<void> removeLoginCredentials() async {
    await SharedPreferences.getInstance().then(
      (SharedPreferences pref) async {
        //*---(login token)
        await pref.remove(
          StringConst.loginToken,
        );
        //*---(is Logged In)
        pref.remove(
          StringConst.isLoggedIn,
        );
      },
    );
  }
  //*-----------(textfield validation)

  // ----------------(Validate  Methods)
  //?-----------(login validation)
  String? loginValidation(
      {required TextFieldType textFieldType, required String inputValue}) {
    //if the textfield type is userName
    if (textFieldType == TextFieldType.userName) {
      //checking the input is empty or not
      if (inputValue.trim().isEmpty) {
        return StringConst.pleaseInputYourEmailOrUserName;
      } else {
        return null;
      }
    } else {
      //if the textfield type is password
      if (inputValue.trim().isEmpty) {
        // checking the input is empty or not
        return StringConst.pleaseInputYourPassword;
      } else {
        return null;
      }
    }
  }

  //?-----------( validation)
  String? commonValidation({
    required String inputValue,
    required String errorMsg,
  }) {
    if (inputValue.trim().isEmpty) {
      return errorMsg;
    } else {
      return null;
    }
  }

  //*-----(get value from storage)
  Future<String> getValueFromStorage({required String value}) {
    return SharedPreferences.getInstance().then(
      (SharedPreferences pref) async {
        //*---(login token)
        return pref.getString(value) ?? "";
      },
    );
  }

  //*-----(get value from storage)
  Future<bool> getBoolValueFromStorage({required String value}) {
    return SharedPreferences.getInstance().then(
      (SharedPreferences pref) async {
        //*---(bool value)
        return pref.getBool(value) ?? false;
      },
    );
  }

//*-----------(remove percentage symbol)
  String removePercentageSymbol(String value) {
    // Use regular expression to remove the '%' symbol and trim extra spaces
    return value.replaceAll('%', '').trim();
  }

  //*-------simulator category status
  String simulatorCategoryStatus(SimulatorStatus status) {
    switch (status) {
      case SimulatorStatus.pending:
        return StringConst.pending.toLowerCase();
      case SimulatorStatus.completed:
        return StringConst.completed.toLowerCase();
      case SimulatorStatus.approval:
        return StringConst.approval.toLowerCase();
      case SimulatorStatus.all:
        return StringConst.all.toLowerCase();
      default:
        return '';
    }
  }

  DateTime? convertDate(End? date, {bool? isDatePrev}) {
    // Returning null if the date object is incomplete or invalid
    if (date == null ||
        date.day == null ||
        date.month == null ||
        date.year == null) {
      return null;
    }

    // Parsing and adjusting date values
    int day = int.parse(date.day!.padLeft(2, '0'));
    int month = int.parse(date.month!.padLeft(2, '0'));
    int year = int.parse(date.year!);

    // If isDatePrev is true, adjust the year
    if (isDatePrev ?? false) {
      year -= 1;
    }

    // Returning the DateTime object
    return DateTime(year, month, day);
  }

  String getFirstItemFromString(String items) {
    List<String> itemList = items.split(', ');
    if (itemList.isNotEmpty) {
      return itemList.first;
    } else {
      return 'No items available';
    }
  }

  String removeSquareBrackets(String input) {
    if (input.startsWith('[') && input.endsWith(']')) {
      return input.substring(1, input.length - 1);
    }
    return input
        .trim(); // Return the string as is if it does not have square brackets
  }

  List<String> splitString(String input) {
    return input.split(',').map((s) => s.trim()).toList();
  }

  num? parseStringToNum(String input) {
    // Trim the input to remove any leading or trailing whitespace
    input = input.trim();

    // Try parsing to an integer first
    try {
      return int.parse(input);
    } catch (e) {
      // If parsing to an integer fails, try parsing to a double
      try {
        return double.parse(input);
      } catch (e) {
        // If both parsing attempts fail, return null
        return null;
      }
    }
  }

  List<Map<String, String?>> convertOtherListToMapList({
    required List<Other> otherList,
    required Other? newOther,
    bool? isThereNewObject = false,
  }) {
    List<Other> dataList = [];
    dataList = List.from(otherList);
    // Check if the flag is true and add the newOther object
    if (newOther != null &&
        (newOther.label?.isNotEmpty ?? false) &&
        (newOther.value?.isNotEmpty ?? false)) {
      // Avoid duplicates based on label (or any other condition you prefer)

      bool exists = dataList.any((other) {
        return other.label == newOther.label && other.value == newOther.value;
      });

      if (!exists) {
        dataList.add(newOther);
      }
    }

    return dataList.map((other) {
      return {
        "label": other.label ?? "",
        "value": removeComma(other.value ?? ""),
      };
    }).toList();
  }

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  //remove Comma(),
  String removeComma(String value) {
    return value.replaceAll(',', '');
  }

  String extractUnit(String input) {
    final RegExp regex =
        RegExp(r'\D+$'); // Matches all non-digit characters at the end
    final match = regex.firstMatch(input);
    return match?.group(0)?.trim() ??
        ''; // Trim and return the unit, or empty if no match
  }

  String removeExtraSpaces(String input) {
    // Step 1: Split the input by commas
    List<String> parts = input.split(',');

    // Step 2: Trim each part to remove leading and trailing spaces
    List<String> trimmedParts = parts.map((part) => part.trim()).toList();

    // Step 3: Join the trimmed parts with a single ', ' separator
    return trimmedParts.join(', ');
  }

  String formatWithThousandSeparator(String number) {
    // Check if input is empty and return an empty string if true
    if (number.isEmpty) return '';

    // Determine if the input has a decimal part
    bool hasDecimal = number.contains('.');
    String integerPart;
    String decimalPart = '';

    if (hasDecimal) {
      // Split integer and decimal parts
      var parts = number.split('.');
      integerPart = parts[0];
      decimalPart = parts[1];
    } else {
      integerPart = number;
    }

    // Format the integer part with thousand separators
    String formattedIntegerPart = integerPart.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match match) => '${match.group(1)},',
    );

    // Combine integer part with decimal part if exists
    return hasDecimal
        ? '$formattedIntegerPart.$decimalPart'
        : formattedIntegerPart;
  }

  String updateSumWithList(List<Other> numList, String discountOthersStr) {
    // If the list is empty, use the discountOthersStr value directly
    if (numList.isEmpty) {
      final double discountOthers = double.tryParse(discountOthersStr) ?? 0;

      return discountOthers.toString();
    }

    // Parse the list of numerical values and sum them up
    final double totalSum = numList
        .map((numStr) =>
            double.tryParse(numStr.value ?? "0") ??
            0) // Convert each string to a double
        .reduce((sum, value) => sum + value); // Sum all the values

    // Parse the current discountOthers value
    final double discountOthers = double.tryParse(discountOthersStr) ?? 0;

    // Add the total sum of the list to discountOthers
    final updatedValue = discountOthers + totalSum;
    return updatedValue.toString();
  }

  List<String> extractMonths(List<String> labels) {
    return labels.map((label) {
      // Split the label by space and return the first part (month)
      return label.split(' ')[0];
    }).toList();
  }

  List<T> getLastSixValues<T>(List<T>? items) {
    // Check if the list is null or empty
    if (items == null || items.isEmpty) {
      return []; // Return an empty list if items is null or empty
    }

    // Check if the list length is greater than 6
    if (items.length > 6) {
      // Return the last 6 values using sublist
      return items.sublist(items.length - 6);
    }

    // If the list has 6 or fewer items, return the entire list
    return items;
  }

// // List sum up method
//   String updateSumWithList(List<Other> numList) {
//     // If the list is empty, return "0"
//     if (numList.isEmpty) {
//       return '0';
//     }

//     // Parse the list of numerical values and sum them up
//     final double totalSum = numList
//         .map((numStr) =>
//             double.tryParse(numStr.value ?? '0') ??
//             0) // Convert each string to a double
//         .reduce((sum, value) => sum + value); // Sum all the values

//     log('Total Sum: $totalSum');

//     return totalSum.toString();
//   }
}
