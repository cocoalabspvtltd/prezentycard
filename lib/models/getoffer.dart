// class GetCardOffersResponse {
//   bool? success;
//   int? statusCode;
//   String? message;
//   List<Cards>? cards;
//
//   GetCardOffersResponse(
//       {this.success, this.statusCode, this.message, this.cards});
//
//   GetCardOffersResponse.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     statusCode = json['status_code'];
//     message = json['message'];
//     if (json['cards'] != null) {
//       cards = <Cards>[];
//       json['cards'].forEach((v) {
//         cards!.add(new Cards.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['status_code'] = this.statusCode;
//     data['message'] = this.message;
//     if (this.cards != null) {
//       data['cards'] = this.cards!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Cards {
//   int? id;
//   String? title;
//   String? slug;
//   String? shortDescription;
//   String? amount;
//   int? registrationPoints;
//   String? longDescription;
//   int? referralPoints;
//   int? nonReferralPoints;
//   int? referredUserPoints;
//   int? physicalCardPrice;
//   String? image;
//   String? imageUrl;
//
//   Cards(
//       {this.id,
//         this.title,
//         this.slug,
//         this.shortDescription,
//         this.amount,
//         this.registrationPoints,
//         this.longDescription,
//         this.referralPoints,
//         this.nonReferralPoints,
//         this.referredUserPoints,
//         this.physicalCardPrice,
//         this.image,
//         this.imageUrl});
//
//   Cards.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     slug = json['slug'];
//     shortDescription = json['short_description'];
//     amount = json['amount'];
//     registrationPoints = json['registration_points'];
//     longDescription = json['long_description'];
//     referralPoints = json['referral_points'];
//     nonReferralPoints = json['non_referral_points'];
//     referredUserPoints = json['referred_user_points'];
//     physicalCardPrice = json['physical_card_price'];
//     image = json['image'];
//     imageUrl = json['image_url'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['slug'] = this.slug;
//     data['short_description'] = this.shortDescription;
//     data['amount'] = this.amount;
//     data['registration_points'] = this.registrationPoints;
//     data['long_description'] = this.longDescription;
//     data['referral_points'] = this.referralPoints;
//     data['non_referral_points'] = this.nonReferralPoints;
//     data['referred_user_points'] = this.referredUserPoints;
//     data['physical_card_price'] = this.physicalCardPrice;
//     data['image'] = this.image;
//     data['image_url'] = this.imageUrl;
//     return data;
//   }
// }