import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  TextEditingController searchcontroler = TextEditingController();
  Widget tileProduct (BuildContext context, dynamic docs){
    return ListTile(
      leading: Image.network(docs['image']),
      title: Text(docs['name']),
      subtitle: Text(docs['description']),
      trailing: Text(docs['price'].toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( // автоматически появляется кнопка назад
        backgroundColor: Colors.white,
        leading: SizedBox(
          child: IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.arrow_back_ios)
          )
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(60), 
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: searchcontroler,
            decoration: InputDecoration(
              suffixIcon: IconButton(onPressed: (){
                setState(() {});
              }, 
              icon: Icon(Icons.search)),
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
        ),
      ),

      body: StreamBuilder(stream: Supabase.instance.client.from('products').stream(primaryKey: ['id']), builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(color: Colors.orange),
          );
        }
        var prod = snapshot.data;
        if(searchcontroler.text.isNotEmpty){
          prod = prod!.where((element) => element['name'].toLowerCase().contains(searchcontroler.text.toLowerCase())).toList();
        }
        
        return ListView.builder(
          itemCount: prod!.length,
          itemBuilder: (context, index) {
            return tileProduct(context, prod![index]);
          });

      }),

    );
  }
}