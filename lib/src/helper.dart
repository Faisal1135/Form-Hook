import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormHookUtil {
  static Widget textForm({
    required String name,
    required String label,
    String? hint,
    required BuildContext context,
    TextEditingController? controller,
    bool obscure = false,
    IconData? icon,
    Widget? suffix,
    bool isRequired = true,
    TextInputType? inputType,
    FieldDecType fieldDecType = FieldDecType.Normal,
    InputDecoration? inputDecoration,
    EdgeInsetsGeometry padding = const EdgeInsets.only(top: 20.0),
    List<String? Function(dynamic)>? validator,
  }) {
    InputDecoration decoration = InputDecoration(
        icon: Icon(icon),
        hintText: hint ?? "Enter your $name",
        labelText: label,
        suffixIcon: suffix);

    if (fieldDecType == FieldDecType.Rectangle) {
      decoration.copyWith(border: OutlineInputBorder());
    }
    if (fieldDecType == FieldDecType.Rounded) {
      decoration.copyWith(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      );
    }

    return Container(
      padding: padding,
      child: FormBuilderTextField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        obscureText: obscure,
        decoration: inputDecoration ?? decoration,
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(context),
          if (validator != null) ...validator
        ]),
        keyboardType: inputType ?? TextInputType.text,
      ),
    );
  }

  static Widget getFormFieldFromStr({
    required String name,
    required BuildContext context,
  }) {
    return FormHookUtil.textForm(name: name, label: name, context: context);
  }

  static Widget makeFields(
      {required List fields, required BuildContext context}) {
    return Column(children: [
      ...fields.map(
        (e) {
          if (e.runtimeType == String) {
            return getFormFieldFromStr(name: e, context: context);
          }
          return e;
        },
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}

enum FieldDecType {
  Normal,
  Rectangle,
  Rounded,
}
