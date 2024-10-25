
class Order{
  int id;
  double quantity;
  double price;
  String? address;
  int offerId;
  String buyerId;
  String sellerId;
  DateTime? dateOrdered;
  DateTime? dateDelivered;
  bool isDelivered;
  String title;
  int? offerTypeId;

  Order({ this.id=0,  this.quantity=0, this.price=0,
     this.address, required this.offerId,
    required this.buyerId, required this.sellerId, this.dateOrdered, this.title = "none", this.dateDelivered, required this.isDelivered, this.offerTypeId});

  factory Order.fromJson(Map<String, dynamic> json) {
    Order res = Order(
      id: json['id'] as int,
      quantity: json['quantity']+.0 as double,
      price: json['price']+.0 as double,
      address: json['address'] as String,
      offerId: json['offerId'] as int,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      dateOrdered: DateTime.parse(json['dateOrdered']),
      dateDelivered: json['dateDelivered'] != null ? DateTime.parse(json['dateDelivered']) : null,
      title: json['title'] as String,
      isDelivered: json['isDelivered'] as bool,
    );
    return res;
  }

  factory Order.fromStorageJson(Map<String, dynamic> json) {
    Order res = Order(
      id: json['id'] as int,
      quantity: json['quantity']+.0 as double,
      price: json['price']+.0 as double,
      offerId: json['offerId'] as int,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      title: json['title'] as String,
      offerTypeId: json['offerTypeId'] as int,
      isDelivered: false,
    );
    return res;
  }

  // Method to convert User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'address': address,
      'offerId': offerId,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'title': title,
      'offerTypeId': offerTypeId,
    };
  }
}