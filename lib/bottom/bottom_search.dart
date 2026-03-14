import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/bottom/search/search_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomSearch extends StatefulWidget {
  const BottomSearch({super.key});

  @override
  State<BottomSearch> createState() => _BottomSearchState();
}

class _BottomSearchState extends State<BottomSearch> {
  Widget cardCategory(BuildContext context, dynamic docs){
    return 
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
            //hintText: 'Введите email',
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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  "Срочный оффер",
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
            child: Row(
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Color(0xff5d7bff))
                  ),
                  onPressed: () {}, 
                  child: Text(
                    'All'
                  )
                )
              ],
            ),
          ),

          Expanded(
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: MediaQuery.of(context).devicePixelRatio * 0.29,
                  ),
                  itemBuilder: (context, snapshot) {
                    return
                  })
                
              }
            ),
          ),
          
          StreamBuilder(
            stream: Supabase.instance.client.from('products').stream(primaryKey: ['id']),
           builder: (context, snapshot){
            if (!snapshot.hasData){
              
            }
           })

        ],
      ),
    );
  }
}
