package particleSystem
{
   import com.pickgliss.loader.LoaderManager;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import particleSystem.loader.ParticleZipLoader;
   
   public class ParticleManager extends EventDispatcher
   {
      
      private static var _instance:ParticleManager;
       
      
      private var _particleXMLDic:Dictionary;
      
      private var _particleTextureDic:Dictionary;
      
      private var _emitters:Dictionary;
      
      private var _siteUrl:String = "";
      
      public function ParticleManager()
      {
         super();
         _particleXMLDic = new Dictionary();
         _particleTextureDic = new Dictionary();
      }
      
      public static function get Instance() : ParticleManager
      {
         if(_instance == null)
         {
            _instance = new ParticleManager();
         }
         return _instance;
      }
      
      public function setup(flashSiteUrl:String) : void
      {
         _siteUrl = flashSiteUrl;
      }
      
      public function loadConfig(emitterInfoAnalyzer:EmitterInfoAnalyzer) : void
      {
         _emitters = emitterInfoAnalyzer.emitters;
      }
      
      public function get emitters() : Dictionary
      {
         return _emitters;
      }
      
      public function getParticle(id:String) : PDParticleSystemWithID
      {
         return new PDParticleSystemWithID(id,_particleXMLDic[id],_particleTextureDic[id]);
      }
      
      public function hasParticle(id:String) : Boolean
      {
         if(_particleXMLDic[id] && _particleTextureDic[id])
         {
            return true;
         }
         return false;
      }
      
      public function createParticleLoader(id:String) : ParticleZipLoader
      {
         var zipLoader:ParticleZipLoader = new ParticleZipLoader(LoaderManager.Instance.getNextLoaderID(),_siteUrl + "particales/Particle_" + id + ".png");
         zipLoader.ID = id;
         return zipLoader;
      }
      
      public function requestEmitter(id:int) : void
      {
         var emitterInfo:* = null;
         var i:int = 0;
         var zipLoader:* = null;
         var emitter:Object = ParticleManager.Instance.emitters[id];
         if(emitter)
         {
            emitterInfo = emitter as EmitterInfo;
            for(i = 0; i < emitterInfo.particleIds.length; )
            {
               zipLoader = createParticleLoader(emitterInfo.particleIds[i]);
               zipLoader.loadZip();
               i++;
            }
         }
         else
         {
            trace("[ParticleManager]粒子emitter数据不存在：" + id);
         }
      }
      
      public function get particleTextureDic() : Dictionary
      {
         return _particleTextureDic;
      }
      
      public function get particleXMLDic() : Dictionary
      {
         return _particleXMLDic;
      }
   }
}
