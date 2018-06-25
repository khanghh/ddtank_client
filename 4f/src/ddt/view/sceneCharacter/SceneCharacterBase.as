package ddt.view.sceneCharacter{   import flash.display.Bitmap;   import flash.display.Sprite;      public class SceneCharacterBase extends Sprite   {                   private var _frameBitmap:Vector.<Bitmap>;            private var _sceneCharacterActionItem:SceneCharacterActionItem;            private var _frameIndex:int;            public function SceneCharacterBase(frameBitmap:Vector.<Bitmap>) { super(); }
            private function initialize() : void { }
            public function update() : void { }
            private function loadFrame(frameIndex:int) : void { }
            public function set sceneCharacterActionItem(value:SceneCharacterActionItem) : void { }
            public function get sceneCharacterActionItem() : SceneCharacterActionItem { return null; }
            public function dispose() : void { }
   }}