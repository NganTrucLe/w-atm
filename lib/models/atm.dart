import '../widgets/status_tag.dart';

enum Type {
  Withdraw,
  Deposit,
  Both,
}

class ATM {
  final String bank;
  final String name;
  // final String avatarLink;
  final String address;
  final String phone;
  final Type type;
  final Status status;
  // final int minimumLimit;
  final bool cashThroughBank;
  final double latitude;
  final double longitude;

  const ATM(
      {required this.bank,
      required this.name,
      required this.address,
      required this.phone,
      required this.type,
      // required this.minimumLimit,
      required this.cashThroughBank,
      required this.status,
      // required this.density,
      required this.latitude,
      required this.longitude});
}
