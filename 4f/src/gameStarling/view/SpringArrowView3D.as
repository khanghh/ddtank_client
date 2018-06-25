package gameStarling.view{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.MouseEvent;   import gameStarling.animations.DirectionMovingAnimation;   import gameStarling.view.map.MapView3D;      public class SpringArrowView3D extends Sprite   {                   private var _rect:Shape;            private var _arrow:Bitmap;            private var _map:MapView3D;            private var _direction:String;            private var _anit:DirectionMovingAnimation;            private var _hand:MovieClip;            private var _allowDrag:Boolean;            public function SpringArrowView3D(direction:String, map:MapView3D = null) { super(); }
            public function set allowDrag(value:Boolean) : void { }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __over(event:MouseEvent) : void { }
            private function __out(event:MouseEvent) : void { }
            private function __up(event:MouseEvent) : void { }
            private function __down(event:MouseEvent) : void { }
            public function dispose() : void { }
   }}