// import 'package:flutter/material.dart';
// import 'product_service.dart';
// import 'product.dart';

// class ProductsPage extends StatefulWidget {
//   const ProductsPage({super.key});

//   @override
//   State<ProductsPage> createState() => _ProductsPageState();
// }

// class _ProductsPageState extends State<ProductsPage> {
//   final _svc = ProductService.instance;
//   final _ctrl = TextEditingController();

//   @override
//   void dispose() {
//     _ctrl.dispose();
//     super.dispose();
//   }

//   Future<void> _add(String text) async {
//     final name = text.trim();
//     if (name.isEmpty) return;
//     await _svc.add(name); // הוספה ל-Firestore
//     _ctrl.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('ניהול מקרר')),
//       body: Column(
//         children: [
//           // שורת הוספה מהירה
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _ctrl,
//                     decoration: const InputDecoration(
//                       labelText: 'שם פריט להוספה',
//                       border: OutlineInputBorder(),
//                     ),
//                     onSubmitted: _add,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton.icon(
//                   onPressed: () => _add(_ctrl.text),
//                   icon: const Icon(Icons.add),
//                   label: const Text('הוסף'),
//                 ),
//               ],
//             ),
//           ),

//           // רשימה “לייב” מה-Firestore
//           Expanded(
//             child: StreamBuilder<List<Product>>(
//               stream: _svc.watch(),
//               builder: (context, snap) {
//                 if (snap.hasError) {
//                   return Center(child: Text('שגיאה: ${snap.error}'));
//                 }
//                 if (!snap.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final items = snap.data!;
//                 if (items.isEmpty) {
//                   return const Center(child: Text('אין מוצרים. הוסף משהו 🙂'));
//                 }

//                 return ListView.separated(
//                   itemCount: items.length,
//                   separatorBuilder: (_, __) => const Divider(height: 1),
//                   itemBuilder: (_, i) {
//                     final p = items[i];
//                     return ListTile(
//                       title: Text(p.name),
//                       subtitle: Text('כמות: ${p.qty}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             tooltip: 'הפחת כמות',
//                             onPressed: p.id == null ? null : () => _svc.inc(p.id!, -1),
//                             icon: const Icon(Icons.remove),
//                           ),
//                           IconButton(
//                             tooltip: 'הוסף כמות',
//                             onPressed: p.id == null ? null : () => _svc.inc(p.id!, 1),
//                             icon: const Icon(Icons.add),
//                           ),
//                           IconButton(
//                             tooltip: 'מחק',
//                             onPressed: p.id == null ? null : () => _svc.remove(p.id!),
//                             icon: const Icon(Icons.delete_outline),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 👈 needed for UID
import 'product_service.dart';
import 'product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductService _svc; // 👈 not singleton—scoped to the signed-in user
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Assumes you've already signed in (e.g., signInAnonymously in main()).
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _svc = ProductService(uid); // 👈 /users/{uid}/products
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _add(String text) async {
    final name = text.trim();
    if (name.isEmpty) return;
    await _svc.add(name);
    _ctrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ניהול מקרר')),
      body: Column(
        children: [
          // שורת הוספה מהירה
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      labelText: 'שם פריט להוספה',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _add,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => _add(_ctrl.text),
                  icon: const Icon(Icons.add),
                  label: const Text('הוסף'),
                ),
              ],
            ),
          ),

          // רשימה “לייב” מה-Firestore
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: _svc.watch(),
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(child: Text('שגיאה: ${snap.error}'));
                }
                if (!snap.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = snap.data!;
                if (items.isEmpty) {
                  return const Center(child: Text('אין מוצרים. הוסף משהו 🙂'));
                }

                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final p = items[i];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('כמות: ${p.qty}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'הפחת כמות',
                            onPressed: p.id == null ? null : () => _svc.inc(p.id!, -1),
                            icon: const Icon(Icons.remove),
                          ),
                          IconButton(
                            tooltip: 'הוסף כמות',
                            onPressed: p.id == null ? null : () => _svc.inc(p.id!, 1),
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            tooltip: 'מחק',
                            onPressed: p.id == null ? null : () => _svc.remove(p.id!),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

