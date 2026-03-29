import 'package:flutter/material.dart';

class TapPage extends StatefulWidget {
  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  double size = 150;
  Color color = Colors.blue;

  void randomize() {
    setState(() {
      size = size == 150 ? 220 : 150;
      color = color == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tap Interaction")),
      body: Center(
        child: GestureDetector(
          onTap: randomize,
          onDoubleTap: () => setState(() => color = Colors.green),
          onLongPress: () => setState(() => size = 250),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black26)],
            ),
          ),
        ),
      ),
    );
  }
}
