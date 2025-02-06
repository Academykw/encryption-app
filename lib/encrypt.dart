
import 'package:flutter/material.dart';

import 'package:encrypt/encrypt.dart' as encrypt;  // Import the encrypt package

class Encrypt extends StatefulWidget {
  const Encrypt({super.key});

  @override
  State<Encrypt> createState() => _EncryptState();
}

class _EncryptState extends State<Encrypt> {
  // settings input controller
  TextEditingController inputController = TextEditingController();
  String _clearText = '';
  // settings input controller
  TextEditingController outputController = TextEditingController();


  // Encryption key and iv setup
 final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);   // 128 bit IV

  void encryptText() {
    final plainText = inputController.text;

    if(plainText.isNotEmpty){
      final encrypter = encrypt.Encrypter(encrypt.AES(key));  // Use AES encryption
      final encrypted = encrypter.encrypt(inputController.text, iv: iv);
      setState(() {
        inputController.text = "";
        outputController.text = encrypted.base64;  // Display the encrypted text in base64 format
      });

    }else{

      setState(() {
        inputController.text = "PLEASE ENTER A TEXT";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('encryption and decryption',
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic
        ),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
         children: [

           TextField(
             controller: inputController,
             decoration: InputDecoration(
               labelText:'enter encrypt text',
               border: OutlineInputBorder(),
             ),
           ),

           SizedBox(height: 15,),

            ElevatedButton(
                onPressed: encryptText,
                child: Text('ENCRYPT')),

           SizedBox(height: 15,),

           TextField(
             controller: outputController,
             readOnly: true,
             decoration: InputDecoration(
               labelText:'encrypted text',
               border: OutlineInputBorder(),
             ),
           ),

           SizedBox(height: 15,),

           ElevatedButton(
               onPressed: encryptText,
               child: Text('DENCRYPT')),


         ],
        ),
      ),
    );
  }
}
