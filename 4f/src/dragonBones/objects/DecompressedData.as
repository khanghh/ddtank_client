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
      
      public function DecompressedData(){super();}
      
      public function dispose() : void{}
      
      public function parseTextureAtlasBytes() : void{}
      
      private function loaderCompleteHandler(param1:Event) : void{}
   }
}
