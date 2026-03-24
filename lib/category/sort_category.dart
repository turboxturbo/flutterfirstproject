import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SortCategoryPage extends StatefulWidget {
  dynamic docs;
  SortCategoryPage({super.key, this.docs});

  @override
  State<SortCategoryPage> createState() => _SortCategoryPageState();
}

class _SortCategoryPageState extends State<SortCategoryPage> {
  // доделать listtale чтобы было нарядно и красиво
  Widget tileProduct(BuildContext context, dynamic docs) {
    return ListTile(
      leading: Image.network(
        docs['image'],
        // fit: BoxFit.contain,
        // width: MediaQuery.of(context).size.width * 0.13,
        // height: MediaQuery.of(context).size.height * 0.3,
      ),
      title: Text(docs['name']),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(docs['name']),
          Text(
            'Доступно: ${docs['count']}',
            style: const TextStyle(color: Colors.black54),
          ),
        ]
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.docs['name']), backgroundColor: Colors.white,),
      body: StreamBuilder(
        stream: Supabase.instance.client
            .from("products")
            .stream(primaryKey: ['id'])
            .eq('category_id', widget.docs['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          var product = snapshot.data;

          return ListView.builder(
            itemCount: product!.length,
            itemBuilder: (context, index) {
              return tileProduct(context, product[index]);
            },
          );
        },
      ),
    );
  }
}
