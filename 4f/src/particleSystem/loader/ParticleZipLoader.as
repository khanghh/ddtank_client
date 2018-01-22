package particleSystem.loader
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import deng.fzip.FZipErrorEvent;
   import deng.fzip.FZipFile;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import particleSystem.ParticleManager;
   import particleSystem.events.ParticleEvent;
   
   public class ParticleZipLoader extends BaseLoader
   {
       
      
      public var ID:String;
      
      public function ParticleZipLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET"){super(null,null,null,null);}
      
      public function loadZip() : void{}
      
      private function __onLoadZipComplete(param1:LoaderEvent) : void{}
      
      private function zipLoad(param1:ByteArray, param2:String) : void{}
      
      private function __onZipParaComplete(param1:Event) : void{}
      
      private function getFileExtension(param1:String) : String{return null;}
      
      private function __onZipParaError(param1:FZipErrorEvent) : void{}
      
      private function __onLoadError(param1:LoaderEvent) : void{}
      
      private function __loadParticleImageComplete(param1:Event) : void{}
      
      private function __ioError(param1:IOErrorEvent) : void{}
   }
}
