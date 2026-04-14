import 'package:supabase_flutter/supabase_flutter.dart';

class ProductTable {
  final Supabase supabase = Supabase.instance;

  Future<int?> addProductTable(
    int categoryId,
    String userId,
    String name,
    String description,
    num price,
    int count,
  ) async {
    try {
      final row = await supabase.client
          .from('product')
          .insert({
            'category_id': categoryId,
            'user_id': userId,
            'name': name,
            'image': null,
            'description': description,
            'price': price,
            'count': count,
            'is_active': true,
          })
          .select('id')
          .single();
      final id = row['id'];
      return id is int ? id : int.tryParse(id.toString());
    } catch (e) {
      return null;
    }
  }

  Future<void> updateImage(String image, int productId) async {
    try {
      await supabase.client
          .from('product')
          .update({'image': image})
          .eq('id', productId);
    } catch (e) {
      return;
    }
  }

  /// Редактирование объявления (все поля, включая URL картинки).
  Future<void> updateProductTable(
    int productId,
    int categoryId,
    String name,
    String image,
    String description,
    num price,
    int count,
  ) async {
    try {
      await supabase.client.from('product').update({
        'category_id': categoryId,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'count': count,
        'is_active': true,
      }).eq('id', productId);
    } catch (e) {
      return;
    }
  }
}
