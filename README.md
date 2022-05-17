# form_hook

form hook can render fields and of form very simple manner even with just a string of filed name .you can fine tune other parameter to meet your need .


## Example

``` dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Hook Test'),
      ),
      body: MainFormView(
          fields: [
            "name",
            "email",
            SizedBox(
              height: 20,
            ),
            FormHookUtil.textForm(
                fieldDecType: FieldDecType.Rounded,
                isRequired: false,
                name: "phone",
                label: "Phone",
                context: context),
            FormHookUtil.fhDropDown(
                fieldDecType: FieldDecType.Rectangle,
                name: "gender",
                label: "Gender",
                context: context,
                valueandlabel: ["male", "female"])
          ],
          onSubmit: (fsdata) {
            print(fsdata);
          }),
    );
  }
```

* default string makes your field required and give you the data with map with same key that you provided.
* with fieldDecType property you can modify decoration .if it failed to meet you need you can provide inputdecoration of your need.



Thank You

**Faisal Kabir Galib**
