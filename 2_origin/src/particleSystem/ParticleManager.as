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
      
      public function setup(param1:String) : void
      {
         _siteUrl = param1;
      }
      
      public function loadConfig(param1:EmitterInfoAnalyzer) : void
      {
         _emitters = param1.emitters;
      }
      
      public function get emitters() : Dictionary
      {
         return _emitters;
      }
      
      public function getParticle(param1:String) : PDParticleSystemWithID
      {
         return new PDParticleSystemWithID(param1,_particleXMLDic[param1],_particleTextureDic[param1]);
      }
      
      public function hasParticle(param1:String) : Boolean
      {
         if(_particleXMLDic[param1] && _particleTextureDic[param1])
         {
            return true;
         }
         return false;
      }
      
      public function createParticleLoader(param1:String) : ParticleZipLoader
      {
         var _loc2_:ParticleZipLoader = new ParticleZipLoader(LoaderManager.Instance.getNextLoaderID(),_siteUrl + "particales/Particle_" + param1 + ".png");
         _loc2_.ID = param1;
         return _loc2_;
      }
      
      public function requestEmitter(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Object = ParticleManager.Instance.emitters[param1];
         if(_loc4_)
         {
            _loc2_ = _loc4_ as EmitterInfo;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.particleIds.length)
            {
               _loc3_ = createParticleLoader(_loc2_.particleIds[_loc5_]);
               _loc3_.loadZip();
               _loc5_++;
            }
         }
         else
         {
            trace("[ParticleManager]粒子emitter数据不存在：" + param1);
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
