class DeliveryAddressModel {
  String firstName;
  String lastName;
  String mobileNo;
  String alternateMobileNo;
  String scoirty;
  String street;
  String landMark;
  String city;
  String aera;
  String pinCode;
  String addressType;

  DeliveryAddressModel({
    required this.addressType,
    required this.aera,
    required this.alternateMobileNo,
    required this.city,
    required this.firstName,
    required this.landMark,
    required this.lastName,
    required this.mobileNo,
    required this.pinCode,
    required this.street,
    required this.scoirty,
  });
}