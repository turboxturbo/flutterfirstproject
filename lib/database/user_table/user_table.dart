import 'package:supabase_flutter/supabase_flutter.dart';

class UserTable {
  final Supabase supabase = Supabase.instance;

  Future<void> addUserTable(
    String fullname,
    String email,
    String password,
    String avatar,
  ) async{
    try {
      await supabase.client.from('users').insert({
        'full_name': fullname,
        'email': email,
        'password': password,
        'avatar': avatar,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> updateImage(String url, String user_id) async{
    try{
      await supabase.client.from('users').update({'avatar' : url}).eq('id', user_id);
    }
    catch (ex){
      return;
    }
  }

  Future<void> updateName(String full_name, String user_id) async{
    try {
      await supabase.client.from('users').update({'full_name' : full_name}).eq('id', user_id);
    } catch (e) {
      return;
    }
  }
 }