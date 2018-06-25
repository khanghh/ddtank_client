package particleSystem.loader{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import deng.fzip.FZipErrorEvent;   import deng.fzip.FZipFile;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.IOErrorEvent;   import flash.net.URLVariables;   import flash.utils.ByteArray;   import particleSystem.ParticleManager;   import particleSystem.events.ParticleEvent;      public class ParticleZipLoader extends BaseLoader   {                   public var ID:String;            public function ParticleZipLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET") { super(null,null,null,null); }
            public function loadZip() : void { }
            private function __onLoadZipComplete(evt:LoaderEvent) : void { }
            private function zipLoad(content:ByteArray, id:String) : void { }
            private function __onZipParaComplete(event:Event) : void { }
            private function getFileExtension(fileName:String) : String { return null; }
            private function __onZipParaError(evt:FZipErrorEvent) : void { }
            private function __onLoadError(event:LoaderEvent) : void { }
            private function __loadParticleImageComplete(evt:Event) : void { }
            private function __ioError(evt:IOErrorEvent) : void { }
   }}