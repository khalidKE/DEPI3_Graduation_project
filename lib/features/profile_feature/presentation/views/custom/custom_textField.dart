import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({super.key,this.prefixIcon,
                        this.suffixIcon,
                        this.obscureText=false,
                        required this.controller, 
                        required this.hintText,
                        required this.labelText,
                        this.textCapitalization=TextCapitalization.none}
                        
                        );

  final  IconData ? prefixIcon;
  final  IconData ? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 42),
            child: TextField(
                    enabled: true,
                    textCapitalization: textCapitalization,
                    controller: controller ,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      prefixIcon: prefixIcon != null ? Icon(prefixIcon,color: Color(0XFF54408C),):null,
                      suffixIcon: suffixIcon != null ? Icon(suffixIcon,color: Color(0XFFB8B8B8),):null,
                      isDense: true,
                      counterText: "",
                      
                      labelStyle: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF121212)
                     
                      ),
                     
                      filled: true,
                      fillColor: Color(0XFFFAFAFA),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0XFFE8E8E8),
                          
                        ),borderRadius: BorderRadius.circular(8),
                        
                      ),
                      hintText: hintText
                    ),
                    
                  ),
    ) ;
  }
}