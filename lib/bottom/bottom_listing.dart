import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/bottom/listing/add_listing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomSell extends StatefulWidget {
  const BottomSell({super.key});

  @override
  State<BottomSell> createState() => _BottomSellState();
}

class _BottomSellState extends State<BottomSell> {
  final userId = Supabase.instance.client.auth.currentUser!.id;
  
  Widget listingTile(BuildContext context, dynamic docs) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        color: Colors.white,
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AddListingPage(docs: docs),
              ),
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.network(
              docs['image'],
              width: 66,
              height: 66,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            'Цена: ${docs['price']}₽'.toString(),
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(docs['name'], style: TextStyle(fontWeight: FontWeight.w600)),
              Text(
                'Доступно: ${docs['count']}',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Мои объявления"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 8),
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => AddListingPage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Expanded(
            child: StreamBuilder(
              stream: Supabase.instance.client
                  .from('product')
                  .stream(primaryKey: ['id'])
                  .eq('user_id', userId),
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
                    return listingTile(context, prod[index]);
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