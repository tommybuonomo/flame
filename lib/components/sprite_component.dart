import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../sprite.dart';
import 'component.dart';
import 'position_component.dart';

/// A [PositionComponent] that renders a single [Sprite] at the designated
/// position, scaled to have the designated size and rotated to the specified
/// angle.
///
/// This a commonly used subclass of [Component].
class SpriteComponent extends PositionComponent {
  /// The [sprite] to be rendered by this component.
  Sprite sprite;

  /// Use this to override the colour used (to apply tint or opacity).
  ///
  /// If not provided the default is full white (no tint).
  Paint overridePaint;

  SpriteComponent();

  SpriteComponent.square(double size, String imagePath)
      : this.rectangle(size, size, imagePath);

  SpriteComponent.rectangle(double width, double height, String imagePath)
      : this.fromSprite(width, height, Sprite(imagePath));

  SpriteComponent.fromSprite(double width, double height, this.sprite) {
    this.width = width;
    this.height = height;
  }

  @mustCallSuper
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite.render(
      canvas,
      width: width,
      height: height,
      overridePaint: overridePaint,
    );
  }

  @override
  bool loaded() {
    return sprite?.loaded() == true && x != null && y != null;
  }
}
