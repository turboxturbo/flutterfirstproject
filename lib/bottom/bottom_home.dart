import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/bottom/bottom_search.dart';
import 'package:flutter_application_1_test/category/full_category.dart';
import 'package:flutter_application_1_test/product/full_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomHome extends StatefulWidget {
  const BottomHome({super.key});

  @override
  State<BottomHome> createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  Widget cardCategory(BuildContext content, dynamic docs) {
    return Card(
      color: Colors.white,
      child: ListTile(
        // Лист тайтл дает title and subtitle
        title: Image.network(docs['image']),
        subtitle: Text(docs['name']),
        onTap: () {},
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
              CupertinoPageRoute(builder: (context) => BottomSearch()),
            );
          },
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            prefixIcon: const Icon(Icons.search),
            labelText: 'Поиск товаров, услуг, недвижимости',
            hintText: 'Что найти?',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black26),
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
              width: MediaQuery.of(context).size.height * 0.41,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Color(0xff5d7bff), Color(0xff7b94ff)],
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "    Срочные предложения",
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
                    child: Text('Все'),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: StreamBuilder(
                stream: Supabase
                    .instance
                    .client // stream - автоматически обновляет данные при изменении 
                    .from('product_categories')
                    .stream(primaryKey: ['id']),
                builder: (context, snapshot) {
                  // builder - возвращает текущую состоянию потока
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }

                  var cat = snapshot.data; // данные из потока
                  return GridView.builder(
                    // создаем сетку для категорий
                    itemCount: cat!.length, // количество карточек
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // три колонки в строке
                      childAspectRatio: // отношение высоты к ширине
                          MediaQuery.of(context).devicePixelRatio * 0.29,
                    ),
                    itemBuilder: (context, index) {
                      // itemBuilder — это функция, которую он вызывает для каждого шага цикла.
                      return cardCategory(
                        context,
                        cat[index],
                      ); // берется конкретная категория по индексу
                    },
                  );
                },
              ),
            ),

            // GridView отвечает за расположение множества элементов.
            // ListTile отвечает за внешний вид одного элемента.
            // ListView — это прокручиваемый список элементов в одну ось (обычно вертикально)
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
                      child: Text('Все'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: Supabase.instance.client
                    .from('product')
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
                        title: Text('${prod[index]['price']}₽'.toString()),
                        subtitle: Text(prod[index]['name']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}