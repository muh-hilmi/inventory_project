import 'package:cloud_firestore/cloud_firestore.dart';

class Inventory {
  final String title;
  final String quantity;
  final String price;
  final String totalPrice;
  final String note;
  final String updatedAt;
  final String imageUrl;

  Inventory(
      {required this.title,
      required this.quantity,
      required this.price,
      required this.totalPrice,
      required this.note,
      required this.updatedAt,
      required this.imageUrl});

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        totalPrice: json['totalPrice'],
        note: json['note'],
        updatedAt: json['updatedAt'],
        imageUrl: json['imageUrl'],
      );

  factory Inventory.fromQueryDocumentSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> json) =>
      Inventory(
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        totalPrice: json['totalPrice'],
        note: json['note'],
        updatedAt: json['updatedAt'],
        imageUrl: json['imageUrl'],
      );

  factory Inventory.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      Inventory(
        title: json['title'],
        quantity: json['quantity'],
        price: json['price'],
        totalPrice: json['totalPrice'],
        note: json['note'],
        updatedAt: json['updatedAt'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'quantity': quantity,
        'price': price,
        'totalPrice': totalPrice,
        'note': note,
        'updatedAt': updatedAt,
        'imageUrl': imageUrl,
      };
}
