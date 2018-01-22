package gameStarling.objects
{
   import flash.geom.Rectangle;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   import starlingPhy.object.PhysicalObj3D;
   
   public class TombView3D extends PhysicalObj3D
   {
       
      
      private var _sp:Sprite;
      
      private var _asset:Image;
      
      public function TombView3D(){super(null,null,null,null);}
      
      override public function get layer() : int{return 0;}
      
      private function initView() : void{}
      
      override public function die() : void{}
      
      override public function stopMoving() : void{}
      
      override public function dispose() : void{}
   }
}
