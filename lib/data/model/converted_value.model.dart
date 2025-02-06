class ConvertedValues {
  final double? grams;
  final double? kilograms;
  final double? ounces;
  final double? pounds;

  ConvertedValues({
    required this.grams,
    required this.kilograms,
    required this.ounces,
    required this.pounds,
  });

  @override
  String toString() {
    return 'ConvertedValues(grams: $grams, kilograms: $kilograms, ounces: $ounces, pounds: $pounds)';
  }
}
