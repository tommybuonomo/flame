import 'package:flame/sprite_animation.dart';
import 'package:flame/components/sprite_animation_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/vector2.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Vector2 size = await Flame.util.initialDimensions();
  final game = MyGame(size);
  runApp(game.widget);
}

class MyGame extends BaseGame {
  final animation = SpriteAnimation.sequenced(
    'chopper.png',
    4,
    textureWidth: 48,
    textureHeight: 48,
    stepTime: 0.15,
  );

  SpriteAnimationComponent buildAnimation() {
    final ac = SpriteAnimationComponent(100, 100, animation);
    ac.x = size.x / 2 - ac.width / 2;
    return ac;
  }

  MyGame(Vector2 screenSize) {
    size = screenSize;

    final regular = buildAnimation();
    regular.y = 100;
    add(regular);

    final flipX = buildAnimation();
    flipX.y = 300;
    flipX.renderFlipX = true;
    add(flipX);

    final flipY = buildAnimation();
    flipY.y = 500;
    flipY.renderFlipY = true;
    add(flipY);
  }
}
