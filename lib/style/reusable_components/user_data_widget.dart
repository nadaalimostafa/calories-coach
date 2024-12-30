import 'package:flutter/material.dart';

class UserDataWidget extends StatefulWidget {
  final String dropdownValue;
  final List<String>items ;
  final void Function(String?)? onSelected;

  final String label;
  const UserDataWidget({
    required this.dropdownValue,
    required this.items,
    required this.label,
    required this.onSelected,
    });

  @override
  UserDataWidgetState createState() => UserDataWidgetState();
}

class UserDataWidgetState extends State<UserDataWidget> {
  late String dropdownValue;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownMenu(
          width: double.infinity,
        initialSelection: widget.dropdownValue,
        label: Text(widget.label),
        onSelected: (value){
          if(value != null){
            setState(() {
              dropdownValue = value;
            });
            if(widget.onSelected != null) {
              widget.onSelected!(value);
            }
          }
        },
        dropdownMenuEntries: widget.items.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
          );
        }).toList(),

      
        ),
    );
   

  }
}
