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
 }