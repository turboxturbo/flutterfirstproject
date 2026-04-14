import 'dart:io';

import 'package:benove_mobile/database/product_table/product_table.dart';
import 'package:benove_mobile/database/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class AddListingPage extends StatefulWidget {
  dynamic docs;

  AddListingPage({super.key, this.docs});

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  StorageCloud storageCloud = StorageCloud();
  ProductTable productTable = ProductTable();
  SupabaseClient supabase = Supabase.instance.client;
  String userId = Supabase.instance.client.auth.currentUser!.id;
  String? selectedCategoryName;
  int? selectedCategoryId;
  String? imageUrl;
  File? selectFile;
  XFile? file;
  int? _editingProductId;

  @override
  void initState() {
    super.initState();
    final d = widget.docs;
    if (d != null) {
      final rawId = d['id'];
      _editingProductId = rawId is int ? rawId : int.tryParse(rawId.toString());
      nameController.text = d['name']?.toString() ?? '';
      descriptionController.text = d['description']?.toString() ?? '';
      priceController.text = d['price']?.toString() ?? '';
      countController.text = d['count']?.toString() ?? '';
      final cid = d['category_id'];
      selectedCategoryId =
          cid is int ? cid : int.tryParse(cid.toString());
      imageUrl = d['image']?.toString();
      Future.microtask(() => _loadCategoryName(selectedCategoryId)); 
    }
  }

  Future<void> _loadCategoryName(int? id) async {
    if (id == null) return;
    try {
      final rows = await supabase
          .from('product_categories')
          .select('name')
          .eq('id', id)
          .limit(1);
        
      setState(() => selectedCategoryName = rows[0]['name']);
    } catch (e) {}
  }

  Future<void> selectImageGallery() async {
    final returnImage = await ImagePicker().pickImage( // image_picker отдает xfile
      source: ImageSource.gallery,
    );

    if (returnImage == null) return;

    setState(() {
      file = returnImage;
      selectFile = File(returnImage.path);
    });
  }

  Future<void> uploadImage() async {
    try {
      await storageCloud.addImageCloud(file!);
    } catch (e) {
      return;
    }
  }

  Future<void> downloadUrl() async {
    try {
      final fileName = path.basename(file!.path);
      final image = supabase.storage.from('Storage').getPublicUrl(fileName);

      setState(() {
        imageUrl = image;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> openCategoryPicker() async {
    try {
      final categories = await supabase
          .from('product_categories')
          .select('id, name');

      if (!mounted) return;

      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(
                    category['name'],
                    style: const TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    setState(() {
                      selectedCategoryId = category['id'];
                      selectedCategoryName = category['name'];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
        },
      );
    } catch (e) {
      return;
    }
  }

  Future<void> pushListingSupabase() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            const Center(child: CircularProgressIndicator(color: Colors.orange)),
      );

      if (selectFile != null) {
        await uploadImage();
        await Future.delayed(const Duration(seconds: 2));
        await downloadUrl();
      }

      final String finalImageUrl = imageUrl!;

      if (widget.docs != null) {
        await productTable.updateProductTable(
          _editingProductId!,
          selectedCategoryId!,
          nameController.text,
          finalImageUrl,
          descriptionController.text,
          num.parse(priceController.text),
          int.parse(countController.text),
        );
      } else {
        final newId = await productTable.addProductTable(
          selectedCategoryId!,
          userId,
          nameController.text,
          descriptionController.text,
          num.parse(priceController.text),
          int.parse(countController.text),
        );
        if (newId == null) throw StateError('Не удалось создать объявление');
        await productTable.updateImage(finalImageUrl, newId);
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.docs != null
                ? 'Объявление обновлено!'
                : 'Объявление опубликовано!',
          ),
          backgroundColor: const Color.fromARGB(156, 27, 12, 34),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.docs != null
              ? 'Изменить объявление'
              : 'Создать объявление',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () async {
                      await selectImageGallery();
                    },
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      color: Colors.orange,
                      size: 20,
                    ),
                    label: Text(
                      widget.docs != null
                          ? 'Заменить фото'
                          : 'Добавить фото',
                      style: const TextStyle(color: Colors.orange, fontSize: 16),
                    ),
                  ),
                ),
              ),
              if (selectFile != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    selectFile!,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.22,
                    fit: BoxFit.cover,
                  ),
                )
              else if (imageUrl != null && imageUrl!.trim().isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl!,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.22,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    side: const BorderSide(color: Colors.black26),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await openCategoryPicker();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCategoryName ?? 'Выберите категорию',
                        style: TextStyle(
                          color: selectedCategoryName == null
                              ? Colors.black54
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Название',
                    hintText: 'Например: iPhone 13, 128 ГБ',
                    prefixIcon: const Icon(Icons.shopping_bag),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: descriptionController,
                  cursorColor: Colors.black,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Описание',
                    hintText: 'Опишите товар',
                    prefixIcon: const Icon(Icons.description),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: priceController,
                  cursorColor: Colors.black,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Цена',
                    hintText: 'Введите цену',
                    prefixIcon: const Icon(Icons.payments),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: countController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Количество',
                    hintText: 'Введите количество товара',
                    prefixIcon: const Icon(Icons.numbers),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    backgroundColor: const WidgetStatePropertyAll(Colors.orange),
                  ),
                  onPressed: () async {
                    if ((selectFile == null &&
                            (imageUrl == null ||
                                imageUrl!.trim().isEmpty)) ||
                        selectedCategoryId == null ||
                        nameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        countController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Заполните поля!"),
                          backgroundColor: Colors.black,
                        ),
                      );
                    } else {
                      await pushListingSupabase();
                    }
                  },
                  child: Text(
                    widget.docs != null ? 'Изменить' : 'Опубликовать',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}