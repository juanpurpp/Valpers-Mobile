import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () async {
            var values = await showDialogGroupedCheckbox(
                context: context,
                cancelDialogText: "cancelar",
                isMultiSelection: true,
                itemsTitle: List.generate(15, (index) => "$index"),
                submitDialogText: "seleccionar",
                dialogTitle: Text("Mapas"),
                values: List.generate(15, (index) => index));
            if (values != null) {
              print(values);
            }
          },
          child: Text("Mapas"),
        ),
      ],
    );
  }
}
