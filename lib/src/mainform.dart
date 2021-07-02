import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_hook/src/helper.dart';

class MainFormView extends HookWidget {
  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();
  final List fields;
  final String btnTitle;
  final Map<String, dynamic> begainVal;
  final Function(Map<String, dynamic>) onSubmit;

  MainFormView(
      {required this.fields,
      this.btnTitle = "Submit",
      required this.onSubmit,
      this.begainVal = const <String, dynamic>{}});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbkey,
      initialValue: begainVal,
      child: Column(
        children: [
          FormHookUtil.makeFields(fields: fields, context: context),
          MaterialButton(
            color: Theme.of(context).accentColor,
            onPressed: () async {
              final fstate = _fbkey.currentState;
              if (fstate!.saveAndValidate()) {
                final frmValue = fstate.value;
                try {
                  await onSubmit(frmValue);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invalid Form Data'),
                  ),
                );
              }
            },
            child: Text(btnTitle),
          )
        ],
      ),
    );
  }
}
