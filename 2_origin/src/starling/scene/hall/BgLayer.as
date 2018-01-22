package starling.scene.hall
{
   import road7th.DDTAssetManager;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   
   public class BgLayer extends Sprite
   {
       
      
      private var _imageArr:Array;
      
      public function BgLayer()
      {
         super();
         showCells();
      }
      
      private function showCells() : void
      {
         var _loc4_:* = null;
         var _loc3_:Vector.<Texture> = DDTAssetManager.instance.starlingAsset.getTextures("hall_scene_bg_");
         _imageArr = [];
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc1_ in _loc3_)
         {
            _loc4_ = new Image(_loc1_);
            _loc4_.x = _loc2_;
            addChild(_loc4_);
            _imageArr.push(_loc4_);
            _loc2_ = _loc2_ + SubTexture(_loc1_).region.width;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _imageArr = null;
      }
   }
}
