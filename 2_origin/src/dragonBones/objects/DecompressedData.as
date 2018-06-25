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
         var loader:TextureAtlasByteArrayLoader = new TextureAtlasByteArrayLoader();
         loader.contentLoaderInfo.addEventListener("complete",loaderCompleteHandler);
         loader.loadBytes(textureAtlasBytes);
      }
      
      private function loaderCompleteHandler(e:Event) : void
      {
         e.target.removeEventListener("complete",loaderCompleteHandler);
         var loader:Loader = e.target.loader;
         var content:Object = e.target.content;
         loader.unloadAndStop();
         if(content is Bitmap)
         {
            textureAtlas = (content as Bitmap).bitmapData;
         }
         else if(content is Sprite)
         {
            textureAtlas = (content as Sprite).getChildAt(0) as MovieClip;
         }
         else
         {
            textureAtlas = content;
         }
         this.dispatchEvent(new Event("complete"));
      }
   }
}
