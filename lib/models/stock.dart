
class Stock {
  int id;
  int offerTypeId;
  String title;
  String sellerId;
  double quantity;
  // Constructor
  Stock({required this.id, required this.title, required this.sellerId, required this.quantity, required this.offerTypeId});

  factory Stock.fromJson(Map<String, dynamic> json) {
    Stock res = Stock(
      id: json['id'] as int,
      title: json['title'] as String,
      sellerId: json['sellerId'] as String,
      offerTypeId: json['offerTypeId'] as int,
      quantity: json['quantity']+.0,
    );
    return res;
  }

  // Method to convert User instance to a JSON map
  Map<String, dynamic> toJson() {
    //TODO: Add all types when fix api
    return {
      'id': id,
      'title': title,
      'sellerId': sellerId,
      'quantity': quantity,
      'offerTypeId': offerTypeId,
    };
  }
}