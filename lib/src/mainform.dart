import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_hook/src/helper.dart';

class MainFormView extends StatelessWidget {
  final List fields;
  final String btnTitle;
  final Map<String, dynamic> begainVal;
  final Widget? child;
  final Function(Map<String, dynamic>) onSubmit;

  final defaultChild = Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
    margin: const EdgeInsets.all(10),
    alignment: Alignment.center,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade300, Colors.purple.shade400],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Text(
      "Submit",
      style: TextStyle(color: Colors.white),
    ),
  );

  MainFormView(
      {required this.fields,
      this.btnTitle = "Submit",
      required this.onSubmit,
      this.child,
      this.begainVal = const <String, dynamic>{}});

  final GlobalKey<FormBuilderState> _fbkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final onPrs = () async {
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
    };

    return FormBuilder(
      key: _fbkey,
      initialValue: begainVal,
      child: Column(
        children: [
          FormHookUtil.makeFields(fields: fields, context: context),
          GestureDetector(
            // make button full width

            onTap: onPrs,
            child: child ?? defaultChild,
          )
        ],
      ),
    );
  }
}
