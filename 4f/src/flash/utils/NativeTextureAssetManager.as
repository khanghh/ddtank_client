package flash.utils
{
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class NativeTextureAssetManager
   {
       
      
      private var _btmds:Dictionary;
      
      private var _btmdAtlas:Dictionary;
      
      public function NativeTextureAssetManager(){super();}
      
      public function addBitmapData(param1:String, param2:BitmapData) : void{}
      
      public function addBitmapDataAtlas(param1:String, param2:NativeTextureAtlas) : void{}
      
      public function removeBitmapData(param1:String, param2:Boolean = true) : void{}
      
      public function removeBitmapDataAtlas(param1:String, param2:Boolean = true) : void{}
      
      public function getBitmapData(param1:String) : BitmapData{return null;}
      
      private function parseNativeTexture(param1:String, param2:NativeTextureAtlas) : BitmapData{return null;}
      
      public function getBitmap(param1:String) : Bitmap{return null;}
      
      public function getBitmapDataAtlas(param1:String) : NativeTextureAtlas{return null;}
      
      public function purge() : void{}
      
      public function dispose() : void{}
      
      public function get btmdAtlas() : Dictionary{return null;}
   }
}
