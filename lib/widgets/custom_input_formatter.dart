//!------(optimized 80%)
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DecimalFormatter extends TextInputFormatter {
  final int decimalDigits;

  DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Handle empty input
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Remove invalid characters (anything not a digit or a single decimal point)
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Avoid multiple decimals or invalid text formats
    if (newText.split('.').length > 2) {
      return oldValue;
    }

    // Handle leading decimal point
    if (newText.startsWith('.')) {
      newText = '0$newText';
    }

    // Split into integer and decimal parts
    List<String> parts = newText.split('.');
    String integerPart = parts[0];

    // Format the integer part with thousand separators
    String formattedInteger =
        NumberFormat('#,##0').format(int.parse(integerPart));

    // Build the final formatted string
    String formattedText = formattedInteger;
    if (parts.length > 1) {
      // Limit decimal places to the specified number
      String decimalPart =
          parts[1].substring(0, decimalDigits.clamp(0, parts[1].length));
      formattedText += '.$decimalPart';
    }

    // Calculate the cursor position
    int cursorPosition =
        formattedText.length - (newValue.text.length - newValue.selection.end);

    // Ensure the cursor position is within bounds
    cursorPosition = cursorPosition.clamp(0, formattedText.length);

    // Return the updated value
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}


// //!------(optimized 70%)
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

// class DecimalFormatter extends TextInputFormatter {
//   final int decimalDigits;

//   DecimalFormatter({this.decimalDigits = 2}) : assert(decimalDigits >= 0);

//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // If the new text is empty, return an empty value
//     if (newValue.text.isEmpty) {
//       return const TextEditingValue(
//         text: '',
//         selection: TextSelection.collapsed(offset: 0),
//       );
//     }

//     // Remove non-numeric and non-decimal characters
//     String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

//     // Prevent accepting alphabetic characters when the text field is empty
//     if (newText.isEmpty) {
//       return oldValue;
//     }

//     // Separate integer and decimal parts
//     List<String> parts = newText.split('.');

//     // Prevent multiple decimal points or excessive decimal places
//     if (parts.length > 2 ||
//         (parts.length > 1 && parts[1].length > decimalDigits)) {
//       return oldValue;
//     }

//     // Format integer part with thousand separators
//     String integerPart = parts[0];
//     String formattedInteger =
//         NumberFormat('#,##0').format(int.parse(integerPart));
//     var selectionIndexFromTheRight =
//         newValue.text.length - newValue.selection.end;
//     // Combine integer and decimal parts if available
//     String formattedText =
//         parts.length > 1 ? '$formattedInteger.${parts[1]}' : formattedInteger;

//     // Return formatted text with the current selection position
//     return TextEditingValue(
//       text: formattedText,
//       selection: TextSelection.collapsed(
//         offset: formattedText.length - selectionIndexFromTheRight,
//       ),
//     );
//   }
// }
