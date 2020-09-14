import 'dart:ui';

import 'package:flame/components/position_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/vector2.dart';
import 'package:flutter/gestures.dart';
import 'package:test/test.dart';

class MyGame extends BaseGame with HasTapableComponents {}

class MyTap extends PositionComponent with Tapable, Resizable {
  bool tapped = false;

  @override
  void onTapDown(TapDownDetails details) {
    tapped = true;
  }

  @override
  bool checkTapOverlap(Rect c, Offset o) => true;
}

class MyComposed extends PositionComponent with HasGameRef, Tapable {
  @override
  Rect toRect() => Rect.zero;
}

class PositionComponentNoNeedForRect extends PositionComponent with Tapable {}

Vector2 size = Vector2(1.0, 1.0);

void main() {
  group('composable component test', () {
    test('taps and resizes children', () {
      final MyGame game = MyGame();
      final MyTap child = MyTap();
      final MyComposed wrapper = MyComposed()..addChild(game, child);

      game.size = size;
      game.add(wrapper);
      game.onTapDown(1, TapDownDetails(globalPosition: const Offset(0.0, 0.0)));

      expect(child.size, size);
      expect(child.tapped, true);
    });
  });
}
