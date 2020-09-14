import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math_64.dart';

/// This represents a Component for your game.
///
/// Components can be bullets flying on the screen, a spaceship or your player's fighter.
/// Anything that either renders or updates can be added to the list on [BaseGame]. It will deal with calling those methods for you.
/// Components also have other methods that can help you out if you want to overwrite them.
abstract class Component {
  /// This method is called periodically by the game engine to request that your component updates itself.
  ///
  /// The time [t] in seconds (with microseconds precision provided by Flutter) since the last update cycle.
  /// This time can vary according to hardware capacity, so make sure to update your state considering this.
  /// All components on [BaseGame] are always updated by the same amount. The time each one takes to update adds up to the next update cycle.
  void update(double t);

  /// Renders this component on the provided Canvas [c].
  void render(Canvas c);

  /// This is a hook called by [BaseGame] to let this component know that the screen (or flame draw area) has been update.
  ///
  /// It receives the new size.
  /// You can use the [Resizable] mixin if you want an implementation of this hook that keeps track of the current size.
  void resize(Vector2 size) {}

  /// Whether this component has been loaded yet. If not loaded, [BaseGame] will not try to render it.
  ///
  /// Sprite based components can use this to let [BaseGame] know not to try to render when the [Sprite] has not been loaded yet.
  /// Note that for a more consistent experience, you can pre-load all your assets beforehand with Flame.images.loadAll.
  bool loaded() => true;

  /// Whether this should be destroyed or not.
  ///
  /// It will be called once per component per loop, and if it returns true, [BaseGame] will mark your component for deletion and remove it before the next loop.
  bool destroy() => false;

  /// Whether this component is HUD object or not.
  ///
  /// HUD objects ignore the [BaseGame.camera] when rendered (so their position coordinates are considered relative to the device screen).
  bool isHud() => false;

  /// Render priority of this component. This allows you to control the order in which your components are rendered.
  ///
  /// Components are always updated and rendered in the order defined by this number.
  /// The smaller the priority, the sooner your component will be updated/rendered.
  /// It can be any integer (negative, zero, or positive).
  /// If two components share the same priority, they will probably be drawn in the order they were added.
  int priority() => 0;

  /// Called when the component has been added and preperad by the game instance.
  ///
  /// This can be used to make initializations on your component as, when this method is called,
  /// things like resize (and other mixins) are already set and usable.
  void onMount() {}

  /// Called right before the component is destroyed and removed from the game
  void onDestroy() {}
}
