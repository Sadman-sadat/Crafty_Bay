import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.colors, required this.onChange});

  final List<Color> colors;
  final Function(Color) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.colors.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                selectedColor = index;
                widget.onChange(widget.colors[index]);
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: widget.colors[index],
                child: selectedColor == index ? const Icon(Icons.check_circle_outline, color: Colors.white,) : null,
              ),
            );
          }),
    );
  }
}
