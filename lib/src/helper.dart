import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'constant.dart';

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
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    List<String? Function(dynamic)>? validator,
  }) {
    InputDecoration decoration = InputDecoration(
        hintText: hint ?? "Enter your $name".capitalizeFirstofEach,
        labelText: label.inCaps,
        suffixIcon: suffix);

    if (icon != null) {
      decoration = decoration.copyWith(
        icon: Icon(icon),
      );
    }

    if (fieldDecType == FieldDecType.Rectangle) {
      decoration = decoration.copyWith(border: OutlineInputBorder());
    }
    if (fieldDecType == FieldDecType.Rounded) {
      decoration = decoration.copyWith(
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

  static Widget fhDropDown({
    required String name,
    required String label,
    required BuildContext context,
    List? valueandlabel,
    List? values,
    List? labels,
    IconData? icon,
    Widget? suffix,
    bool isRequired = true,
    FieldDecType fieldDecType = FieldDecType.Normal,
    InputDecoration? inputDecoration,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    List<String? Function(dynamic)>? validator,
  }) {
    InputDecoration decoration =
        InputDecoration(labelText: label, suffixIcon: suffix);

    if (icon != null) {
      decoration = decoration.copyWith(
        icon: Icon(icon),
      );
    }
    if (fieldDecType == FieldDecType.Normal) {
      decoration = decoration.copyWith(border: InputBorder.none);
    }

    if (fieldDecType == FieldDecType.Rectangle) {
      decoration = decoration.copyWith(border: OutlineInputBorder());
    }
    if (fieldDecType == FieldDecType.Rounded) {
      decoration = decoration.copyWith(
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
    var drpitems = <DropdownMenuItem<dynamic>>[];
    if (valueandlabel != null) {
      drpitems = valueandlabel
          .map(
            (it) => DropdownMenuItem(
              value: it,
              child: Text('$it'),
            ),
          )
          .toSet()
          .toList();
    }

    if (values != null && labels != null) {
      drpitems = values
          .asMap()
          .keys
          .map((index) => DropdownMenuItem(
                value: values[index],
                child: Text('${labels[index]}'),
              ))
          .toList();
    }

    return Container(
      padding: padding,
      child: FormBuilderDropdown(
        items: drpitems,
        name: name,
        decoration: inputDecoration ?? decoration,
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(context),
          if (validator != null) ...validator
        ]),
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

  static getValidators(
      List<FormHookValidator> validator, BuildContext context) {
    final resvalid = [];
    validator.forEach((element) {
      if (element == FormHookValidator.Email) {
        resvalid.add(FormBuilderValidators.email(context));
      }
      if (element == FormHookValidator.Url) {
        resvalid.add(FormBuilderValidators.url(context));
      }
    });
  }
}

enum FieldDecType {
  Normal,
  Rectangle,
  Rounded,
}

enum FormHookValidator {
  Numeric,
  Email,
  Url,
}
