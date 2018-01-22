package dragonBones.objects
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   [Event(name="complete",type="flash.events.Event")]
   public class DecompressedData extends EventDispatcher
   {
       
      
      public var name:String;
      
      public var textureBytesDataType:String;
      
      public var dragonBonesData:Object;
      
      public var textureAtlasData:Object;
      
      public var textureAtlasBytes:ByteArray;
      
      public var textureAtlas:Object;
      
      public function DecompressedData()
      {
         super();
      }
      
      public function dispose() : void
      {
         dragonBonesData = null;
         textureAtlasData = null;
         textureAtlas = null;
         textureAtlasBytes = null;
      }
      
      public function parseTextureAtlasBytes() : void
      {
         var _loc1_:TextureAtlasByteArrayLoader = new TextureAtlasByteArrayLoader();
         _loc1_.contentLoaderInfo.addEventListener("complete",loaderCompleteHandler);
         _loc1_.loadBytes(textureAtlasBytes);
      }
      
      private function loaderCompleteHandler(param1:Event) : void
      {
         param1.target.removeEventListener("complete",loaderCompleteHandler);
         var _loc3_:Loader = param1.target.loader;
         var _loc2_:Object = param1.target.content;
         _loc3_.unloadAndStop();
         if(_loc2_ is Bitmap)
         {
            textureAtlas = (_loc2_ as Bitmap).bitmapData;
         }
         else if(_loc2_ is Sprite)
         {
            textureAtlas = (_loc2_ as Sprite).getChildAt(0) as MovieClip;
         }
         else
         {
            textureAtlas = _loc2_;
         }
         this.dispatchEvent(new Event("complete"));
      }
   }
}
