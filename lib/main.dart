import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'product.dart';
import 'product_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}

/// ---- MyApp ----
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fridge Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const ProductsPage(),
    );
  }
}

/// ---- ProductsPage ----
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductService _svc;
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    _svc = ProductService(uid); // ✅ עובד עם Firestore path: /users/{uid}/products
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    await _svc.add(_nameCtrl.text);
    _nameCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('המקרר שלי')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'שם מוצר חדש',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _add,
                  child: const Text('הוסף'),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: _svc.watch(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('שגיאה: ${snap.error}'));
                }
                final items = snap.data ?? [];
                if (items.isEmpty) {
                  return const Center(child: Text('אין מוצרים עדיין'));
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (context, i) {
                    final p = items[i];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('כמות: ${p.qty}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'הקטן כמות',
                            icon: const Icon(Icons.remove),
                            onPressed: () => _svc.inc(p.id!, -1),
                          ),
                          IconButton(
                            tooltip: 'הגדל כמות',
                            icon: const Icon(Icons.add),
                            onPressed: () => _svc.inc(p.id!, 1),
                          ),
                          IconButton(
                            tooltip: 'מחק',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _svc.remove(p.id!),
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
