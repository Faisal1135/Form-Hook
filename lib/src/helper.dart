import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HelperFunction {
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
    EdgeInsetsGeometry padding = const EdgeInsets.only(top: 20.0),
    List<String? Function(dynamic)>? validator,
  }) {
    InputDecoration decoration = InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(icon),
        hintText: hint,
        labelText: label,
        suffixIcon: suffix);

    return Container(
      padding: padding,
      child: FormBuilderTextField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        obscureText: obscure,
        decoration: decoration,
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
    return HelperFunction.textForm(name: name, label: name, context: context);
  }

  static Widget makeFields(
      {required List fields, required BuildContext context}) {
    return Column(children: [
      ...fields.map((e) {
        if (e.runtimeType == String) {
          return getFormFieldFromStr(name: e, context: context);
        }
        return e;
      }),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
