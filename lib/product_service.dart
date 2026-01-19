import 'package:cloud_firestore/cloud_firestore.dart';
import 'product.dart';

class ProductService {
  final String uid;
  ProductService(this.uid); // ✅ קונסטרקטור חדש שמקבל uid

  final _db = FirebaseFirestore.instance;

  CollectionReference<Product> get _col =>
      _db.collection('users').doc(uid).collection('products').withConverter<Product>(
            fromFirestore: (snap, _) => Product.fromFirestore(snap),
            toFirestore: (p, _) => p.toFirestore(),
          );

  Stream<List<Product>> watch() {
    return _col
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((q) => q.docs.map((d) => d.data()).toList());
  }

  Future<void> add(String name, {int qty = 1, DateTime? expiry}) {
    final p = Product(id: null, name: name.trim(), qty: qty, expiry: expiry);
    return _col.add(p);
  }

  Future<void> inc(String id, int delta) {
    return _col.doc(id).update({
      'qty': FieldValue.increment(delta),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> remove(String id) => _col.doc(id).delete();
}
