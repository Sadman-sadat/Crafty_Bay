class Profile {
  final String? cusName;
  final String? cusAdd;
  final String? cusCity;
  final String? cusState;
  final String? cusPostcode;
  final String? cusCountry;
  final String? cusPhone;
  final String? cusFax;
  final String? shipName;
  final String? shipAdd;
  final String? shipCity;
  final String? shipState;
  final String? shipPostcode;
  final String? shipCountry;
  final String? shipPhone;

  Profile({
    this.cusName,
    this.cusAdd,
    this.cusCity,
    this.cusState,
    this.cusPostcode,
    this.cusCountry,
    this.cusPhone,
    this.cusFax,
    this.shipName,
    this.shipAdd,
    this.shipCity,
    this.shipState,
    this.shipPostcode,
    this.shipCountry,
    this.shipPhone,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      cusName: json['cus_name'],
      cusAdd: json['cus_add'],
      cusCity: json['cus_city'],
      cusState: json['cus_state'],
      cusPostcode: json['cus_postcode'],
      cusCountry: json['cus_country'],
      cusPhone: json['cus_phone'],
      cusFax: json['cus_fax'],
      shipName: json['ship_name'],
      shipAdd: json['ship_add'],
      shipCity: json['ship_city'],
      shipState: json['ship_state'],
      shipPostcode: json['ship_postcode'],
      shipCountry: json['ship_country'],
      shipPhone: json['ship_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cus_name": cusName,
      "cus_add": cusAdd,
      "cus_city": cusCity,
      "cus_state": cusState,
      "cus_postcode": cusPostcode,
      "cus_country": cusCountry,
      "cus_phone": cusPhone,
      "cus_fax": cusFax,
      "ship_name": shipName,
      "ship_add": shipAdd,
      "ship_city": shipCity,
      "ship_state": shipState,
      "ship_postcode": shipPostcode,
      "ship_country": shipCountry,
      "ship_phone": shipPhone,
    };
  }
}
