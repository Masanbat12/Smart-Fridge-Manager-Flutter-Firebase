// product.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;         // null כשמוסיפים
  final String name;
  final int qty;
  final DateTime? expiry;   // לא String!
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.qty,
    this.expiry,
    this.updatedAt,
  });

  Product copyWith({
    String? id,
    String? name,
    int? qty,
    DateTime? expiry,
    DateTime? updatedAt,
  }) => Product(
        id: id ?? this.id,
        name: name ?? this.name,
        qty: qty ?? this.qty,
        expiry: expiry ?? this.expiry,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  // ל־withConverter
  Map<String, Object?> toFirestore() => {
        'name': name,
        'qty': qty,
        'expiry': expiry != null ? Timestamp.fromDate(expiry!) : null,
        'updatedAt': FieldValue.serverTimestamp(),
      };

  static Product fromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
    final d = snap.data()!;
    return Product(
      id: snap.id,
      name: (d['name'] ?? '') as String,
      qty: (d['qty'] ?? 0) as int,
      expiry: d['expiry'] is Timestamp ? (d['expiry'] as Timestamp).toDate() : null,
      updatedAt: d['updatedAt'] is Timestamp ? (d['updatedAt'] as Timestamp).toDate() : null,
    );
  }
}
