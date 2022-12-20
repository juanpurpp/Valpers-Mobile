import 'package:flutter/material.dart';

bool _isChecked = false;
final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
List<int> _selectedValues = [];

class Sala extends StatefulWidget {
  const Sala({super.key});
  @override
  _SalaState createState() => _SalaState();
}

class _SalaState extends State<Sala> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Expanded(
              child: Center(
            child: Text('Sala'),
          )),
          Expanded(
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 55),
                children: List.generate(
                    10,
                    (index) => const TextField(
                        decoration: InputDecoration(
                            hintText: 'Username',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.redAccent),
                            ))))),
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: PopupMenuButton<int>(
                        onSelected: (int result) {
                          if (!_selectedValues.contains(result)) {
                            _selectedValues.add(result);
                          } else {
                            _selectedValues.remove(result);
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<int>>[
                          CheckedPopupMenuItem<int>(
                            checked: _selectedValues.contains(1),
                            value: 1,
                            child: const Text('1'),
                          ),
                          const PopupMenuDivider(),
                          CheckedPopupMenuItem<int>(
                            checked: _selectedValues.contains(2),
                            value: 2,
                            child: const Text('2'),
                          ),
                          // ...other items listed here
                        ],
                      ),
                    ),
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    )
                  ],
                ),
                const Text('Codigo: AAAA-44BD-2022'),
              ])),
          Container(
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/resultado');
                },
                child: const Text(
                  'Lanzar',
                  style: TextStyle(fontSize: 20.0),
                ),
              ))
        ],
      ),
    );
  }
}
