import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ScalePage extends StatefulWidget {
  const ScalePage({super.key});

  @override
  State<ScalePage> createState() => _ScalePageState();
}

class _ScalePageState extends State<ScalePage> {
  double scale = 1.0;
  double previousScale = 1.0;

  Offset position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scale & Zoom (PRO)")),
      body: Center(
        child: Listener(
          onPointerSignal: (pointerSignal) {
            // ✅ Zoom pakai scroll (laptop / mouse)
            if (pointerSignal is PointerScrollEvent) {
              setState(() {
                scale += pointerSignal.scrollDelta.dy * -0.001;
                scale = scale.clamp(0.5, 3.0);
              });
            }
          },
          child: GestureDetector(
            // ✅ Start pinch
            onScaleStart: (details) {
              previousScale = scale;
            },

            // ✅ Update pinch + drag
            onScaleUpdate: (details) {
              setState(() {
                // Zoom
                scale = (previousScale * details.scale).clamp(0.5, 3.0);

                // Drag (geser posisi)
                position += details.focalPointDelta;
              });
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Transform.translate(
                offset: position,
                child: Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.pink],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Zoom Me",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // Tombol reset
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            scale = 1.0;
            previousScale = 1.0;
            position = Offset.zero;
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
