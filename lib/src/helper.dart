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
    dynamic initialValue,
    bool isRequired = true,
    TextInputType? inputType,
    dynamic Function(String?)? valueTransformer,
    FieldDecType fieldDecType = FieldDecType.Rectangle,
    InputDecoration? inputDecoration,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    String? Function(String?)? validator,
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
        valueTransformer: valueTransformer,
        initialValue: initialValue,
        obscureText: obscure,
        decoration: inputDecoration ?? decoration,
        validator: validator ??
            (val) {
              if (isRequired && (val == null || val.isEmpty)) {
                return "This field is required";
              }
              return null;
            },
        keyboardType: inputType ?? TextInputType.text,
      ),
    );
  }

  static Widget fhDropDown<T>({
    required String name,
    required String label,
    required BuildContext context,
    List<T>? valueandlabel,
    T? initialValue,
    List<T>? values,
    List<String>? labels,
    List<DropdownMenuItem<T>>? items,
    IconData? icon,
    Widget? suffix,
    void Function(T id)? onChange,
    bool isRequired = true,
    dynamic Function(T?)? valueTransformer,
    FieldDecType fieldDecType = FieldDecType.Rectangle,
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
    var drpitems = <DropdownMenuItem<T>>[];
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
          .map(
            (index) => DropdownMenuItem(
              value: values[index],
              child: Text('${labels[index]}'),
            ),
          )
          .toList();
    }

    return Container(
      padding: padding,
      child: FormBuilderDropdown<T>(
        initialValue: initialValue,
        items: items ?? drpitems,
        name: name,

        valueTransformer: valueTransformer,
        onChanged: (val) {
          if (val == null || onChange == null) return;
          onChange(val);
        },
        // onChanged: (dynamic val) {
        //   if (val == null || onChange == null) return;
        //   onChange(val.toString());
        // },
        decoration: inputDecoration ?? decoration,
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

enum FormHookValidator {
  Numeric,
  Email,
  Url,
}
