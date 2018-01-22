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
      
      public function ParticleZipLoader(param1:int, param2:String, param3:URLVariables = null, param4:String = "GET")
      {
         super(param1,param2,param3,param4);
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
      
      private function __onLoadZipComplete(param1:LoaderEvent) : void
      {
         var _loc2_:ParticleZipLoader = param1.loader as ParticleZipLoader;
         _loc2_.removeEventListener("complete",__onLoadZipComplete);
         _loc2_.removeEventListener("loadError",__onLoadError);
         var _loc3_:ByteArray = _loc2_.content;
         zipLoad(_loc3_,_loc2_.ID);
      }
      
      private function zipLoad(param1:ByteArray, param2:String) : void
      {
         var _loc3_:ParticleFZip = new ParticleFZip();
         _loc3_.ID = param2;
         _loc3_.addEventListener("complete",__onZipParaComplete);
         _loc3_.addEventListener("parseError",__onZipParaError);
         _loc3_.loadBytes(param1);
      }
      
      private function __onZipParaComplete(param1:Event) : void
      {
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc3_:ParticleFZip = param1.currentTarget as ParticleFZip;
         _loc3_.removeEventListener("complete",__onZipParaComplete);
         _loc3_.removeEventListener("parseError",__onZipParaError);
         var _loc4_:int = _loc3_.getFileCount();
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc6_ = _loc3_.getFileAt(_loc9_);
            _loc7_ = _loc6_.content;
            _loc7_.position = 0;
            _loc2_ = getFileExtension(_loc6_.filename);
            if(_loc2_ == "pex")
            {
               _loc8_ = XML(_loc7_.readUTFBytes(_loc7_.bytesAvailable));
               ParticleManager.Instance.particleXMLDic[_loc3_.ID] = _loc8_;
            }
            else if(_loc2_ == "png")
            {
               _loc5_ = new TextureLoader(_loc3_.ID);
               _loc5_.contentLoaderInfo.addEventListener("complete",__loadParticleImageComplete);
               _loc5_.contentLoaderInfo.addEventListener("ioError",__ioError);
               _loc5_.loadBytes(_loc7_);
            }
            _loc9_++;
         }
      }
      
      private function getFileExtension(param1:String) : String
      {
         return param1.substr(param1.lastIndexOf(".") + 1);
      }
      
      private function __onZipParaError(param1:FZipErrorEvent) : void
      {
      }
      
      private function __onLoadError(param1:LoaderEvent) : void
      {
      }
      
      private function __loadParticleImageComplete(param1:Event) : void
      {
         var _loc2_:TextureLoader = param1.target.loader as TextureLoader;
         _loc2_.removeEventListener("complete",__loadParticleImageComplete);
         _loc2_.removeEventListener("ioError",__ioError);
         ParticleManager.Instance.particleTextureDic[_loc2_.ID] = (_loc2_.content as Bitmap).bitmapData;
         if(ParticleManager.Instance.particleXMLDic[_loc2_.ID])
         {
            dispatchEvent(new ParticleEvent("particle_loaded",_loc2_.ID));
         }
      }
      
      private function __ioError(param1:IOErrorEvent) : void
      {
      }
   }
}
