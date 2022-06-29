import 'package:butunlemeodev/auth/auth_page.dart';
import 'package:butunlemeodev/sayfalar/anasayfa.dart';
import 'package:butunlemeodev/sayfalar/hesap.dart';
import 'package:butunlemeodev/sayfalar/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Main_Page extends StatelessWidget {

  const Main_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Anasayfa();
          }
          else{
            return AuthPage();
          }
        },
      ),
    );
  }
}
