enum DatePickerType {
  start,
  end,
}

//!-----------------(radio tile type)

enum SimulatorStatus { pending, completed, all, approval }

//!--------------------(used to differentiate textfield type)
enum TextFieldType {
  userName,
  password,
}

//*---------------(selection type)
enum SelectionType {
  firstOption,
  secondOption,
}

//!--------------------(used to differentiate loading status type)
enum LoadingStatus {
  initial,
  loading,
  success,
  failure,
}

//!--------------------(metric type)
enum MetricType {
  none,
  lbs,
  grams,
  ounces,
}

//!------------(shimmer type)
enum ShimmerType {
  list,
  box,
  table,
}

// Define an enum for different date formats
enum DateFormatType {
  dayMonthYear, // d MMMM yyyy
  dayMonthYearSlash, // dd/MM/yyyy
  yearMonthDaySlash, // yyyy/mm/dd
  dayMonYear,
}

// other list
enum OtherType {
  costOfSales,
  sellPriceAndDiscount,
  deliverySupply,
  sellExpense,
}

//dialog
enum DialogType {
  success,
  failure,
  none,
}
