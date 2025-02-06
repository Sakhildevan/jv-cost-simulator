import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void updateTextController(TextEditingController controller, String? newText,
    {bool showPercentage = false}) {
  // Get the current cursor position before updating the text
  int currentCursorPosition = controller.selection.baseOffset;

  // Handle the case where newText is empty or null
  if (newText == null || newText.isEmpty) {
    controller.text = "";
    controller.selection = const TextSelection.collapsed(offset: 0);
    return;
  }

  // Strip percentage symbol if it exists
  if (newText.endsWith('%')) {
    newText = newText.replaceAll('%', '').trim();
  }

  // Append percentage symbol only if showPercentage is true
  if (showPercentage && !newText.endsWith('%')) {
    newText = '$newText%'; // Add the % symbol without an extra space
  }

  // Update the controller text only if it's different to avoid unnecessary updates
  if (controller.text != newText) {
    // Set the new text to the controller
    controller.text = newText;

    // Adjust cursor position if necessary
    if (currentCursorPosition > controller.text.length) {
      currentCursorPosition = controller.text.length;
    }

    // Ensure cursor doesn't move past the '%' symbol if showPercentage is true
    if (showPercentage && newText.endsWith('%')) {
      currentCursorPosition = newText.length - 1; // Place cursor before '%'
    }

    // Set the updated cursor position
    controller.selection =
        TextSelection.collapsed(offset: currentCursorPosition);
  }
}

// String formatWithThousandSeparator(String? value) {
//   if (value != null && value.isNotEmpty) {
//     try {
//       final double number = double.parse(value);
//       return NumberFormat("#,##0.###").format(number);
//     } catch (e) {
//       return value; // Return the original value if parsing fails
//     }
//   }
//   return '';
// }
String formatWithThousandSeparator(String? value) {
  if (value != null && value.isNotEmpty) {
    try {
      // Preserve the trailing dot if it exists for user input
      if (value.endsWith(".")) {
        return "${NumberFormat("#,##0.###").format(double.parse(value.substring(0, value.length - 1)))}.";
      }
      final double number = double.parse(value);
      return NumberFormat("#,##0.###").format(number);
    } catch (e) {
      return value; // Return the original value if parsing fails
    }
  }
  return '';
}
