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
      
      public function TombView3D()
      {
         super(-1,1,5,50);
         _testRect = new Rectangle(-3,3,6,3);
         touchable = false;
         _canCollided = true;
         initView();
      }
      
      override public function get layer() : int
      {
         return 4;
      }
      
      private function initView() : void
      {
         _asset = StarlingMain.instance.createImage("game_tombAsset");
         _asset.x = -20;
         _asset.y = -50;
         _sp = new Sprite();
         _sp.addChild(_asset);
         _sp.y = 3;
         addChild(_sp);
      }
      
      override public function die() : void
      {
         super.die();
         _map.removePhysical(this);
      }
      
      override public function stopMoving() : void
      {
         super.stopMoving();
         _sp.angle = calcObjectAngle();
      }
      
      override public function dispose() : void
      {
         _sp.removeChild(_asset);
         _asset = null;
         removeChild(_sp);
         _sp = null;
         _testRect = null;
         super.dispose();
      }
   }
}
