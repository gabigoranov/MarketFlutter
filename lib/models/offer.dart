import 'package:market/models/user.dart';

class Offer {
  // public int Id { get; set; }
  // public string Title { get; set; }
  // public double PricePerKG { get; set; }
  // public Guid OwnerId { get; set; }
  // public User Owner { get; set; }
  // public bool inSeason { get; set; }
  // public int OfferTypeId { get; set; }
  // public OfferType OfferType { get; set; }


  int id;
  String title;
  double pricePerKG;
  String ownerId;
  bool inSeason;
  int offerTypeId;
  // Constructor
  Offer({required this.id, required this.title, required this.pricePerKG, required this.ownerId,
    required this.inSeason, required this.offerTypeId});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as int,
      title: json['title'] as String,
      pricePerKG: json['pricePerKG'] as double,
      ownerId: json['ownerId'] as String,
      inSeason: json['inSeason'] as bool,
      offerTypeId: json['offerTypeId'] as int,
    );
  }

  // Method to convert User instance to a JSON map
  Map<String, dynamic> toJson() {
    //TODO: Add all types when fix api
    return {
      'id': id,
      'title': title,
      'pricePerKG': pricePerKG,
      'ownerId': ownerId,
      'inSeason': inSeason,
      'offerTypeId': offerTypeId,
    };
  }
}