package com.pickgliss.utils{   import bones.display.BoneMovieFastStarling;   import bones.display.IBoneMovie;   import com.pickgliss.ui.core.Disposeable;   import starling.display.DisplayObject;   import starling.display.DisplayObjectContainer;   import starling.display.Image;   import starling.textures.Texture;      public class StarlingObjectUtils   {                   public function StarlingObjectUtils() { super(); }
            public static function disposeObject(target:Object, disposeTexture:Boolean = false) : void { }
            public static function disposeAllChildren(container:DisplayObjectContainer, disposeTexture:Boolean = false) : void { }
            public static function removeObject(target:DisplayObject) : void { }
            public static function removeChildAllChildren(container:DisplayObjectContainer, isDispose:Boolean = true) : void { }
   }}