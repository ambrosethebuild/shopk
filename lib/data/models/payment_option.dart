class PaymentOption {
  int id;
  String name;
  String slug;
  String type;
  String logo;
  String description;
  String secretKey;
  String publicKey;
  String secretHash;

  PaymentOption({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.logo,
    this.description,
    this.secretKey,
    this.publicKey,
    this.secretHash,
  });

  factory PaymentOption.fromJSON({
    dynamic jsonObject,
  }) {
    final paymentOption = PaymentOption();
    paymentOption.id = jsonObject["id"];
    paymentOption.logo = jsonObject["logo"];
    paymentOption.name = jsonObject["name"];
    paymentOption.slug = jsonObject["slug"];
    paymentOption.type = jsonObject["type"];
    paymentOption.description = jsonObject["description"];
    paymentOption.secretKey = jsonObject["secret_key"];
    paymentOption.secretHash = jsonObject["secret_hash"];
    paymentOption.publicKey = jsonObject["public_key"];
    return paymentOption;
  }

  bool get isCard => this.type.toLowerCase() == "card";
  bool get isWallet => this.type.toLowerCase() == "wallet";
  bool get isCash => this.type.toLowerCase() == "cash";
}
