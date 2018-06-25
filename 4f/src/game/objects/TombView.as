package game.objects{   import com.pickgliss.ui.ComponentFactory;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.geom.Rectangle;   import phy.object.PhysicalObj;      public class TombView extends PhysicalObj   {                   private var _sp:Sprite;            private var _asset:Bitmap;            public function TombView() { super(null,null,null,null); }
            override public function get layer() : int { return 0; }
            private function initView() : void { }
            override public function die() : void { }
            override public function stopMoving() : void { }
            override public function dispose() : void { }
   }}