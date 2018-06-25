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
         var image:* = null;
         var textures:Vector.<Texture> = DDTAssetManager.instance.starlingAsset.getTextures("hall_scene_bg_");
         _imageArr = [];
         var offsetX:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = textures;
         for each(var texture in textures)
         {
            image = new Image(texture);
            image.x = offsetX;
            addChild(image);
            _imageArr.push(image);
            offsetX = offsetX + SubTexture(texture).region.width;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _imageArr = null;
      }
   }
}
