package road7th.utils
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class BitmapReader extends EventDispatcher
   {
       
      
      private var loader:Loader;
      
      public var bitmap:Bitmap;
      
      public function BitmapReader()
      {
         super();
      }
      
      public function readByteArray(ba:ByteArray) : void
      {
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener("complete",dataComplete);
         loader.loadBytes(ba);
      }
      
      public function dataComplete(e:Event) : void
      {
         bitmap = e.target.content;
         dispatchEvent(new Event("complete"));
      }
   }
}
