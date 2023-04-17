class Coupon {
  final String code;
  final double discount;
  final DateTime validFrom;
  final DateTime validTo;

  Coupon({
    required this.code,
    required this.discount,
    required this.validFrom,
    required this.validTo,
  });
}
