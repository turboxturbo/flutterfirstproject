import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FullProductPage extends StatefulWidget {
  const FullProductPage({super.key});

  @override
  State<FullProductPage> createState() => _FullProductPageState();
}

class _FullProductPageState extends State<FullProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Товары"), backgroundColor: Colors.white),
      body: StreamBuilder(
        stream: Supabase.instance.client
            .from('products')
            .stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }
          var prod = snapshot.data;
          return ListView.builder(
            itemCount: prod!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(prod[index]['image']),
                title: Text(prod[index]['price'].toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(prod[index]['name']),
                    Text(
                      'Доступно: ${prod[index]['count']}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Text('В корзину'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
