package gameStarling.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameStarling.animations.DirectionMovingAnimation;
   import gameStarling.view.map.MapView3D;
   
   public class SpringArrowView3D extends Sprite
   {
       
      
      private var _rect:Shape;
      
      private var _arrow:Bitmap;
      
      private var _map:MapView3D;
      
      private var _direction:String;
      
      private var _anit:DirectionMovingAnimation;
      
      private var _hand:MovieClip;
      
      private var _allowDrag:Boolean;
      
      public function SpringArrowView3D(param1:String, param2:MapView3D = null){super();}
      
      public function set allowDrag(param1:Boolean) : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      private function __up(param1:MouseEvent) : void{}
      
      private function __down(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
