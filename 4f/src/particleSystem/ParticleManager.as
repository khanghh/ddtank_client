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
      
      public function ParticleManager(){super();}
      
      public static function get Instance() : ParticleManager{return null;}
      
      public function setup(param1:String) : void{}
      
      public function loadConfig(param1:EmitterInfoAnalyzer) : void{}
      
      public function get emitters() : Dictionary{return null;}
      
      public function getParticle(param1:String) : PDParticleSystemWithID{return null;}
      
      public function hasParticle(param1:String) : Boolean{return false;}
      
      public function createParticleLoader(param1:String) : ParticleZipLoader{return null;}
      
      public function requestEmitter(param1:int) : void{}
      
      public function get particleTextureDic() : Dictionary{return null;}
      
      public function get particleXMLDic() : Dictionary{return null;}
   }
}
