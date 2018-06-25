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
      
      public function ParticleZipLoader(id:int, url:String, args:URLVariables = null, requestMethod:String = "GET")
      {
         super(id,url,args,requestMethod);
      }
      
      public function loadZip() : void
      {
         if(ParticleManager.Instance.hasParticle(ID))
         {
            dispatchEvent(new ParticleEvent("particle_loaded",ID));
         }
         else
         {
            this.addEventListener("complete",__onLoadZipComplete);
            this.addEventListener("loadError",__onLoadError);
            LoadResourceManager.Instance.startLoad(this,false,false);
         }
      }
      
      private function __onLoadZipComplete(evt:LoaderEvent) : void
      {
         var zipLoader:ParticleZipLoader = evt.loader as ParticleZipLoader;
         zipLoader.removeEventListener("complete",__onLoadZipComplete);
         zipLoader.removeEventListener("loadError",__onLoadError);
         var temp:ByteArray = zipLoader.content;
         zipLoad(temp,zipLoader.ID);
      }
      
      private function zipLoad(content:ByteArray, id:String) : void
      {
         var zip:ParticleFZip = new ParticleFZip();
         zip.ID = id;
         zip.addEventListener("complete",__onZipParaComplete);
         zip.addEventListener("parseError",__onZipParaError);
         zip.loadBytes(content);
      }
      
      private function __onZipParaComplete(event:Event) : void
      {
         var i:int = 0;
         var file:* = null;
         var temp:* = null;
         var extension:* = null;
         var xml:* = null;
         var loader:* = null;
         var zip:ParticleFZip = event.currentTarget as ParticleFZip;
         zip.removeEventListener("complete",__onZipParaComplete);
         zip.removeEventListener("parseError",__onZipParaError);
         var count:int = zip.getFileCount();
         for(i = 0; i < count; )
         {
            file = zip.getFileAt(i);
            temp = file.content;
            temp.position = 0;
            extension = getFileExtension(file.filename);
            if(extension == "pex")
            {
               xml = XML(temp.readUTFBytes(temp.bytesAvailable));
               ParticleManager.Instance.particleXMLDic[zip.ID] = xml;
            }
            else if(extension == "png")
            {
               loader = new TextureLoader(zip.ID);
               loader.contentLoaderInfo.addEventListener("complete",__loadParticleImageComplete);
               loader.contentLoaderInfo.addEventListener("ioError",__ioError);
               loader.loadBytes(temp);
            }
            i++;
         }
      }
      
      private function getFileExtension(fileName:String) : String
      {
         return fileName.substr(fileName.lastIndexOf(".") + 1);
      }
      
      private function __onZipParaError(evt:FZipErrorEvent) : void
      {
      }
      
      private function __onLoadError(event:LoaderEvent) : void
      {
      }
      
      private function __loadParticleImageComplete(evt:Event) : void
      {
         var loader:TextureLoader = evt.target.loader as TextureLoader;
         loader.removeEventListener("complete",__loadParticleImageComplete);
         loader.removeEventListener("ioError",__ioError);
         ParticleManager.Instance.particleTextureDic[loader.ID] = (loader.content as Bitmap).bitmapData;
         if(ParticleManager.Instance.particleXMLDic[loader.ID])
         {
            dispatchEvent(new ParticleEvent("particle_loaded",loader.ID));
         }
      }
      
      private function __ioError(evt:IOErrorEvent) : void
      {
      }
   }
}
