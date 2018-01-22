package starling.scene.demonChiYou
{
   import road7th.DDTAssetManager;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class BgLayer extends Sprite
   {
       
      
      public function BgLayer()
      {
         super();
         showCells();
      }
      
      private function showCells() : void
      {
         var _loc3_:Vector.<Texture> = DDTAssetManager.instance.starlingAsset.getTextures("demon_chi_you_scene_bg_");
         var _loc1_:Image = new Image(_loc3_[0]);
         addChild(_loc1_);
         var _loc2_:Image = new Image(_loc3_[1]);
         _loc2_.rotation = 3.14159265358979 / 2;
         _loc2_.x = _loc1_.width + _loc2_.width;
         addChild(_loc2_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
