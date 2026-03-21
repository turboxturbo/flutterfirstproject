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
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      title: Text(docs['name']),
      subtitle: SizedBox(
        // width: MediaQuery.of(context).size.width * 0.8,
        // height: MediaQuery.of(context).size.height * 0.045,
        child: ElevatedButton(
          onPressed: () {
            //Navigator.popAndPushNamed(context, '/home');
          },
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(25),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(Colors.orange),
          ),
          child: Text(
            'Добавить в корзину',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.docs['name'])),
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
