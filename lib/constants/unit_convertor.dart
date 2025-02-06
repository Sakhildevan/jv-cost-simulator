// import '../data/model/converted_value.model.dart';
// import '../utils/enums.dart';

// class UnitConverter {
//   // Conversion constants
//   static const double lbsToGms = 453.592;
//   static const double gmsToLbs = 1 / lbsToGms;
//   static const double gmsToKg = 0.001;
//   static const double gmsToOunces = 28.3495;

//   // Convert Pack Size
//   static ConvertedValues convertPackSize(double value, MetricType type) {
//     switch (type) {
//       case MetricType.lbs:
//         return _convertFromLbs(value);
//       case MetricType.grams:
//         return _convertFromGms(value);

//       default:
//         return ConvertedValues(
//           grams: null,
//           kilograms: null,
//           ounces: null,
//           pounds: null,
//         );
//     }
//     // return type== ? _convertFromLbs(value) : _convertFromGms(value);
//   }

//   // Convert Links/Package
//   static ConvertedValues convertLinkPackage(double value, MetricType type) {
//     switch (type) {
//       case MetricType.lbs:
//         return _convertFromLbs(value);
//       case MetricType.grams:
//         return _convertFromGms(value);

//       default:
//         return ConvertedValues(
//           grams: null,
//           kilograms: null,
//           ounces: null,
//           pounds: null,
//         );
//     }
//   }

//   // Convert Links
//   static ConvertedValues convertLinks(double value, MetricType type) {
//     switch (type) {
//       case MetricType.lbs:
//         return _convertFromLbs(value);
//       case MetricType.grams:
//         return _convertFromGms(value);

//       default:
//         return ConvertedValues(
//           grams: null,
//           kilograms: null,
//           ounces: null,
//           pounds: null,
//         );
//     }
//   }

//   // Convert Pack Per Case
//   static ConvertedValues convertPackPerCase(double value, MetricType type) {
//     switch (type) {
//       case MetricType.lbs:
//         return _convertFromLbs(value);
//       case MetricType.grams:
//         return _convertFromGms(value);

//       default:
//         return ConvertedValues(
//           grams: null,
//           kilograms: null,
//           ounces: null,
//           pounds: null,
//         );
//     }
//   }

//   // Helper method for converting from LBS
//   static ConvertedValues _convertFromLbs(double lbs) {
//     double grams = lbs * lbsToGms;
//     double kilograms = grams * gmsToKg;
//     double ounces = lbs * 16; // 1 lb = 16 oz
//     return ConvertedValues(
//       grams: grams,
//       kilograms: kilograms,
//       ounces: ounces,
//       pounds: lbs,
//     );
//   }

//   // Helper method for converting from GMS
//   static ConvertedValues _convertFromGms(double grams) {
//     double pounds = grams * gmsToLbs;
//     double kilograms = grams * gmsToKg;
//     double ounces = grams / gmsToOunces;
//     return ConvertedValues(
//       grams: grams,
//       kilograms: kilograms,
//       ounces: ounces,
//       pounds: pounds,
//     );
//   }
// }
import 'package:johnsonville_cost_simulator/data/model/converted_value.model.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';

class UnitConverter {
  // Conversion constants
  static const double lbsToGms = 453.592;
  static const double gmsToLbs = 1 / lbsToGms;
  static const double gmsToKg = 0.001;
  static const double gmsToOunces = 28.3495;

  // Convert Pack Size
  static ConvertedValues convertPackSize(double value, MetricType type) {
    switch (type) {
      case MetricType.lbs:
        return _convertFromLbs(value);
      case MetricType.grams:
        return _convertFromGms(value);
      case MetricType.ounces:
        return _convertFromOunces(value);
      default:
        return ConvertedValues(
          grams: null,
          kilograms: null,
          ounces: null,
          pounds: null,
        );
    }
  }

  // Convert Links/Package
  static ConvertedValues convertLinkPackage(double value, MetricType type) {
    switch (type) {
      case MetricType.lbs:
        return _convertFromLbs(value);
      case MetricType.grams:
        return _convertFromGms(value);
      case MetricType.ounces:
        return _convertFromOunces(value);
      default:
        return ConvertedValues(
          grams: null,
          kilograms: null,
          ounces: null,
          pounds: null,
        );
    }
  }

  // Convert Links
  static ConvertedValues convertLinks(double value, MetricType type) {
    switch (type) {
      case MetricType.lbs:
        return _convertFromLbs(value);
      case MetricType.grams:
        return _convertFromGms(value);
      case MetricType.ounces:
        return _convertFromOunces(value);
      default:
        return ConvertedValues(
          grams: null,
          kilograms: null,
          ounces: null,
          pounds: null,
        );
    }
  }

  // Convert Pack Per Case
  static ConvertedValues convertPackPerCase(double value, MetricType type) {
    switch (type) {
      case MetricType.lbs:
        return _convertFromLbs(value);
      case MetricType.grams:
        return _convertFromGms(value);
      case MetricType.ounces:
        return _convertFromOunces(value);
      default:
        return ConvertedValues(
          grams: null,
          kilograms: null,
          ounces: null,
          pounds: null,
        );
    }
  }

  // Helper method for converting from LBS
  static ConvertedValues _convertFromLbs(double lbs) {
    double grams = lbs * lbsToGms;
    double kilograms = grams * gmsToKg;
    double ounces = lbs * 16; // 1 lb = 16 oz
    return ConvertedValues(
      grams: grams,
      kilograms: kilograms,
      ounces: ounces,
      pounds: lbs,
    );
  }

  // Helper method for converting from GMS
  static ConvertedValues _convertFromGms(double grams) {
    double pounds = grams * gmsToLbs;
    double kilograms = grams * gmsToKg;
    double ounces = grams / gmsToOunces;
    return ConvertedValues(
      grams: grams,
      kilograms: kilograms,
      ounces: ounces,
      pounds: pounds,
    );
  }

  // Helper method for converting from OUNCES
  static ConvertedValues _convertFromOunces(double ounces) {
    double grams = ounces * gmsToOunces;
    double pounds = grams * gmsToLbs;
    double kilograms = grams * gmsToKg;
    return ConvertedValues(
      grams: grams,
      kilograms: kilograms,
      ounces: ounces,
      pounds: pounds,
    );
  }
}
