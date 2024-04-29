import 'package:client/widgets/app_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Viewer3dScreen extends StatefulWidget {
  const Viewer3dScreen({super.key, required this.modelUrl});

  final String modelUrl;

  @override
  State<Viewer3dScreen> createState() => _Viewer3dScreenState();
}

class _Viewer3dScreenState extends State<Viewer3dScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.getCommonAppBar('Вид 3D', context),
      body: const Center(
        child: ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: 'assets/models/Pizza.glb',
          alt: 'A 3D model of an astronaut',
          ar: true,
          arModes: ['scene-viewer', 'webxr', 'quick-look'],
          autoRotate: true,
          disableZoom: true,
        ),
      ),
    );
  }
}
