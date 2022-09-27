enum KindOfATM {
  Withdraw,
  Deposit,
  Both,
}

enum Density { Crowed, Medium, Not }

class ATM {
  final String bank;
  final String name;
  // final String id; // Tên PGD
  // final String avatarLink;
  final String address;
  final String phone;
  // final KindOfATM kindOfATM;
  // final int minimumLimit;
  // final bool cashThroughBank;
  // final Density density;
  final double latitude;
  final double longitude;

  const ATM(
      {required this.bank,
      required this.name,
      // required this.id,
      // required this.avatarLink,
      required this.address,
      required this.phone,
      // required this.kindOfATM,
      // required this.minimumLimit,
      // required this.cashThroughBank,
      // required this.density,
      required this.latitude,
      required this.longitude});
}
