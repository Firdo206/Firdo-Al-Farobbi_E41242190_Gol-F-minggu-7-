import 'package:flutter/material.dart';

class PlaygroundPage extends StatefulWidget {
  @override
  _PlaygroundPageState createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  double x = 100, y = 100;

  double scale = 1.0;
  double previousScale = 1.0;

  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gesture Playground")),
      body: Stack(
        children: [
          Positioned(
            left: x,
            top: y,
            child: GestureDetector(
              // TAP
              onTap: () => setState(() => color = Colors.green),

              // DOUBLE TAP
              onDoubleTap: () => setState(() => color = Colors.red),

              // LONG PRESS
              onLongPress: () => setState(() => scale = 2.0),

              // SCALE START (penting!)
              onScaleStart: (details) {
                previousScale = scale;
              },

              // SCALE + DRAG (gabungan)
              onScaleUpdate: (details) {
                setState(() {
                  // Zoom
                  scale = (previousScale * details.scale).clamp(0.5, 3.0);

                  // Drag
                  x += details.focalPointDelta.dx;
                  y += details.focalPointDelta.dy;
                });
              },

              child: Transform.scale(
                scale: scale,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // RESET BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            x = 100;
            y = 100;
            scale = 1.0;
            previousScale = 1.0;
            color = Colors.blue;
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
