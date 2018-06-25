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
         var textures:Vector.<Texture> = DDTAssetManager.instance.starlingAsset.getTextures("demon_chi_you_scene_bg_");
         var image0:Image = new Image(textures[0]);
         addChild(image0);
         var image1:Image = new Image(textures[1]);
         image1.rotation = 3.14159265358979 / 2;
         image1.x = image0.width + image1.width;
         addChild(image1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
