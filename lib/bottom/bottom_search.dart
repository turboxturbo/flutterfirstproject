import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/bottom/search/search_product.dart';
import 'package:flutter_application_1_test/category/full_category.dart';
import 'package:flutter_application_1_test/category/sort_category.dart';
import 'package:flutter_application_1_test/product/full_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomSearch extends StatefulWidget {
  const BottomSearch({super.key});

  @override
  State<BottomSearch> createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  Widget cardCategory(BuildContext context, dynamic docs){
    return Card(
      color: Colors.white,
      child: ListTile(
      title: Image.network(docs['image']),
      subtitle: Text(docs['name']),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => SearchProductPage()),
            );
          },
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(Icons.search),
            labelText: 'Search items ',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(25),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(25),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff5d7bff),
                        Color(0xff7b94ff),
                      ],
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Срочный оффер",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Категории",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        Color(0xff5d7bff),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute( // переход справа налево 
                          builder: (context) => FullCategoryPage(),
                        ),
                      );
                    },
                    child: Text('All'),
                  ),
                ],
              ),
            ),
        
            Expanded(
              flex: 2,
              child: StreamBuilder(
                stream: Supabase.instance.client.from('product_categories').stream(primaryKey: ['id']), 
                builder: (context, snapshot){
                  if (!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }
                  var cat = snapshot.data;
                  return GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: MediaQuery.of(context).devicePixelRatio * 0.29,
                    ),
                    itemBuilder: (context, index) {
                      return cardCategory(context, cat![index]);
                    });
                  
                }
              ),
            ),
            
        
            Expanded(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Товары",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          Color(0xff5d7bff),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => FullProductPage(),
                          ),
                        );
                      },
                      child: Text('All'),
                    ),
                  ],
                ),
              ),
            ),
        
        
            Expanded(
              child: StreamBuilder(
                stream: Supabase.instance.client
                .from('products')
                .stream(primaryKey: ['id']),
               builder: (context, snapshot){
                if (!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  );
                }
                var prod = snapshot.data;
                return ListView.builder(
                  itemCount: prod!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(prod![index]['image']),
                      title: Text(prod[index]['price'].toString()),
                      subtitle: Text(prod[index]['name']),
                    );
                  },);
                }
              ),
            )
        
          ],
        ),
      ),
    );
  }
}
