package hallIcon.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class HallIconBox extends Sprite implements Disposeable   {                   private var _iconSprite:Sprite;            private var _iconSpriteBg:ScaleBitmapImage;            public function HallIconBox() { super(); }
            override public function addChild(child:DisplayObject) : DisplayObject { return null; }
            override public function getChildIndex(child:DisplayObject) : int { return 0; }
            override public function removeChildAt(index:int) : DisplayObject { return null; }
            override public function set x(value:Number) : void { }
            override public function set y(value:Number) : void { }
            override public function get numChildren() : int { return 0; }
            private function updateBg() : void { }
            public function removeChildrens() : void { }
            public function dispose() : void { }
   }}