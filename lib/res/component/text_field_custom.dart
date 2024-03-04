import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';

// ignore: must_be_immutable
class TextFieldCustom extends StatelessWidget {
  TextEditingController? control;
  bool obsecure;
  String? hint;
  String? labeltext;
  IconData? preIcon;
  IconData? suficon;
  final sufFunction;
  final  validate;
  TextFieldCustom({super.key,this.control,this.hint,this.labeltext,required this.obsecure, required this.validate,this.preIcon,this.suficon,this.sufFunction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: control,
      validator: validate,
      textInputAction: TextInputAction.next,
      
      obscureText: obsecure,
          decoration: InputDecoration(
            prefixIcon: Icon(preIcon),
            prefixIconColor: AppColors.theme,
            suffixIcon: IconButton(icon:Icon(suficon),onPressed: sufFunction,),
            filled: true,
            fillColor: AppColors.white.withOpacity(1),
            hintText: hint,
            border: OutlineInputBorder(borderSide: BorderSide(width: 1),borderRadius: BorderRadius.circular(30)),
            label: Text('$labeltext'),
          ),
        );
  }
}