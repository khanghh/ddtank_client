package totem.view{   import com.greensock.TweenLite;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;      public class TotemLeftWindowTotemCell extends Sprite implements Disposeable   {                   public var level:int;            public var index:int;            public var isCurCanClick:Boolean;            public var isHasLighted:Boolean;            private var _halo:MovieClip;            private var _bgIconSprite:Sprite;            private var _ligthCross:MovieClip;            public function TotemLeftWindowTotemCell(bg:Bitmap, icon:Bitmap) { super(); }
            public function showLigthCross() : void { }
            public function hideLigthCross() : void { }
            public function get bgIconWidth() : Number { return 0; }
            public function setBgIconSpriteFilter(filter:Array) : void { }
            public function dimOutHalo() : void { }
            private function dimOutHaloCompleteHandler() : void { }
            public function brightenHalo() : void { }
            private function brightenHaloCompleteHandler() : void { }
            public function dispose() : void { }
   }}