import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/category/sort_category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FullCategoryPage extends StatefulWidget {
  const FullCategoryPage({super.key});

  @override
  State<FullCategoryPage> createState() => _FullCategoryPageState();
}

class _FullCategoryPageState extends State<FullCategoryPage> {
  Widget tileCategory(BuildContext context, dynamic docs) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Image.network(
          docs['image'],
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              docs['name'],
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => SortCategoryPage(docs: docs)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Categories'), backgroundColor: Colors.white),
      body: StreamBuilder(
        stream: Supabase.instance.client
            .from('product_categories')
            .stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          var cat = snapshot.data;
          
          return GridView.builder(
            itemCount: cat!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).devicePixelRatio * 0.4,
            ),
            itemBuilder: (context, index) {
              return tileCategory(context, cat[index]);
            },
          );
        },
      ),
    );
  }
}
