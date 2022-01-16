import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'particle_presets.dart';
import 'particle_world.dart';
import 'colorsequence_designer.dart';

typedef void PropertyDoubleCallback(double value);
typedef void PropertyIntCallback(int value);
typedef void PropertyBoolCallback(bool value);
typedef void PropertyBlendModeCallback(BlendMode value);
typedef void PropertyColorCallback(Color value);
typedef void PropertyColorSequenceCallback(ColorSequence value);

class ParticleDesigner extends StatefulWidget {
  final ImageMap images;

  ParticleDesigner({this.images});

  ParticleDesignerState createState() => new ParticleDesignerState();
}

class ParticleDesignerState extends State<ParticleDesigner> with SingleTickerProviderStateMixin {
  ParticleWorld _particleWorld;
  //TabController _tabController;
  Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    _particleWorld = new ParticleWorld(images: widget.images);
    _backgroundColor = Colors.blueGrey[700];
  }

  Widget build(BuildContext context) {
    List<Widget> presets = <Widget>[];
    for (ParticlePresetType type in ParticlePresetType.values) {
      FloatingActionButton tile = new FloatingActionButton(
        child:  Icon(Icons.add_outlined,color: Colors.indigo,),
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            ParticlePreset.updateParticles(
              _particleWorld,
              type,
              (Color bg) {
                _backgroundColor = bg;
              },
            );
          });
        },
      );
      presets.add(tile);
    }


    return Scaffold(
      floatingActionButton: presets[2],
      backgroundColor: Colors.blueGrey[700],
      body: AspectRatio(
        aspectRatio: 0.5,
        child: SpriteWidget(_particleWorld),
      ),
       // Container(height: 200,child: SpriteWidget(_particleWorld)),
    );
  }
}




