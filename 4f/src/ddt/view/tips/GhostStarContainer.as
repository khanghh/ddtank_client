package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;      public class GhostStarContainer extends Sprite implements Disposeable   {                   private var _maxLv:Number = 10;            private var _mask:Sprite;            private var _content:Sprite;            private var _bg:Sprite;            public function GhostStarContainer() { super(); }
            private function initContainer() : void { }
            public function set maxLv(value:uint) : void { }
            public function set level(value:uint) : void { }
            public function dispose() : void { }
   }}