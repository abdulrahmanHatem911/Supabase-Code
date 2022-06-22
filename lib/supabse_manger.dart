import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class SupabaseManger {
  static String supabaseUrl = 'YOUR URL';
  static String supabaseKey = 'YOUR KEY';
  final client = SupabaseClient(supabaseUrl, supabaseKey);
  addData(String supaName) {
    var respons = client.from('items').insert({"name": supaName}).execute();
    print(respons);
  }

  readData() async {
    var respons = await client
        .from('items')
        .select()
        .order('name', ascending: true)
        .execute();
    print(respons);
    var dataList = respons.data as List;
    return dataList;
  }

  updateData(int id, String supaName) {
    var respons =
        client.from('items').update({"name": supaName}).eq('id', id).execute();
    print(respons);
  }

  deleteData(int id) {
    var respons = client.from('items').delete().eq('id', id).execute();
    print(respons);
  }

  Future<void> signup(context, String email, String password) async {
    debugPrint("emial $email password $password");
    final result = await client.auth.signUp(email, password);
    if (result.data != null) {
      Navigator.pushReplacementNamed(context, '/login');
      showToastMessage(context, 'Succeeded');
    } else if (result.error!.message != null) {
      showToastMessage(context, 'Error');
    }
  }

  Future<void> signInUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    debugPrint("email: $email password: $password");
    final result = await client.auth.signIn(email: email, password: password);
    if (result.data != null) {
      Navigator.pushReplacementNamed(context, '/home');
      showToastMessage(context, 'Succeeded');
    } else if (result.error!.message != null) {
      showToastMessage(context, 'Error');
    }
  }

  Future<void> logout(BuildContext context) async {
    await client.auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void showToastMessage(BuildContext context, String showText) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(showText),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}
