import 'package:multi_furniture_store/models/coupon_model.dart';

class CouponService {
  final double totalPrice = 0;
  final List<Coupon> _coupons = [
    Coupon(
      code: 'FLUTTER20',
      discount: 0.2,
      validFrom: DateTime(2023, 4, 1),
      validTo: DateTime(2023, 4, 30),
    ),
    Coupon(
      code: 'COUPON50',
      discount: 0.5,
      validFrom: DateTime(2023, 4, 1),
      validTo: DateTime(2023, 4, 30),
    ),
  ];

  bool isCouponValid(String code) {
    final now = DateTime.now();
    final coupon = _coupons.firstWhere(
      (c) => c.code == code,
      orElse: () => Coupon(
        code: '',
        discount: 0,
        validFrom: now,
        validTo: now,
      ),
    );

    return coupon.code.isNotEmpty &&
        now.isAfter(coupon.validFrom) &&
        now.isBefore(coupon.validTo);
  }

  double calculateDiscount(String code, double totalPrice) {
    final coupon = _coupons.firstWhere(
      (c) => c.code == code,
      orElse: () => Coupon(
        code: '',
        discount: 0,
        validFrom: DateTime(2023, 4, 1),
        validTo: DateTime(2023, 4, 30),
      ),
    );

    if (coupon.code.isNotEmpty) {
      return totalPrice = coupon.discount * totalPrice;
    } else {
      return 0.0;
    }
  }
}
