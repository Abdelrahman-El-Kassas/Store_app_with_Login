import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 const CustomTextField({
  //شيل const
    super.key,
    required this.controller,
    required this.thing,
    required this.validator,
    this.ispassword = false,
  });

  final TextEditingController controller;
  final String thing;
  final String? Function(String?)? validator;
  final bool ispassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: ispassword,
        controller: controller,
        validator: validator,
decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 19,
            horizontal: 15,
          ),
          
          // 1. الإطار في الحالة العادية (قبل ما اليوزر يدوس عليه)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              width: 2, // كبرنا السمك هنا
              color: Colors.grey, // ممكن تغير لونه
            ),
          ),
          
          // 2. الإطار لما اليوزر يدوس عليه عشان يكتب
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              width: 3, // سمك أكبر شوية عشان يلفت الانتباه
              color: Colors.deepPurpleAccent, // لون الزرار بتاعك
            ),
          ),
          
          // 3. error when user type thing wrong will be red
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(width: 2, color: Colors.red),
          ),
          

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(width: 3, color: Colors.red),
          ),

          hintText: thing,
        ),
      ),
    );
  }
}
