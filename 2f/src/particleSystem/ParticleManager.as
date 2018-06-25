package particleSystem{   import com.pickgliss.loader.LoaderManager;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import particleSystem.loader.ParticleZipLoader;      public class ParticleManager extends EventDispatcher   {            private static var _instance:ParticleManager;                   private var _particleXMLDic:Dictionary;            private var _particleTextureDic:Dictionary;            private var _emitters:Dictionary;            private var _siteUrl:String = "";            public function ParticleManager() { super(); }
            public static function get Instance() : ParticleManager { return null; }
            public function setup(flashSiteUrl:String) : void { }
            public function loadConfig(emitterInfoAnalyzer:EmitterInfoAnalyzer) : void { }
            public function get emitters() : Dictionary { return null; }
            public function getParticle(id:String) : PDParticleSystemWithID { return null; }
            public function hasParticle(id:String) : Boolean { return false; }
            public function createParticleLoader(id:String) : ParticleZipLoader { return null; }
            public function requestEmitter(id:int) : void { }
            public function get particleTextureDic() : Dictionary { return null; }
            public function get particleXMLDic() : Dictionary { return null; }
   }}