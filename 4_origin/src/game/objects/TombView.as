package game.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import phy.object.PhysicalObj;
   
   public class TombView extends PhysicalObj
   {
       
      
      private var _sp:Sprite;
      
      private var _asset:Bitmap;
      
      public function TombView()
      {
         super(-1,1,5,50);
         _testRect = new Rectangle(-3,3,6,3);
         _canCollided = true;
         initView();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get layer() : int
      {
         return 4;
      }
      
      private function initView() : void
      {
         mouseEnabled = false;
         mouseChildren = false;
         _asset = ComponentFactory.Instance.creatBitmap("asset.game.tombAsset");
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
         _sp.rotation = calcObjectAngle();
      }
      
      override public function dispose() : void
      {
         if(_map)
         {
            _map.removePhysical(this);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _sp.removeChild(_asset);
         _asset.bitmapData.dispose();
         _asset = null;
         removeChild(_sp);
         _sp = null;
         _testRect = null;
         super.dispose();
      }
   }
}
