package par
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import flash.system.ApplicationDomain;
   import flash.utils.describeType;
   import par.emitters.Emitter;
   import par.emitters.EmitterInfo;
   import par.lifeeasing.AbstractLifeEasing;
   import par.particals.ParticleInfo;
   import road7th.math.ColorLine;
   import road7th.math.XLine;
   
   public class ParticleManager
   {
      
      public static var list:Array = [];
      
      private static var _ready:Boolean;
      
      public static const PARTICAL_XML_PATH:String = "partical.xml";
      
      public static const SHAPE_PATH:String = "shape.swf";
      
      public static const PARTICAL_LITE:String = "particallite.xml";
      
      public static const SHAPE_LITE:String = "shapelite.swf";
      
      static var Domain:ApplicationDomain;
       
      
      public function ParticleManager(){super();}
      
      public static function get ready() : Boolean{return false;}
      
      public static function addEmitterInfo(param1:EmitterInfo) : void{}
      
      public static function removeEmitterInfo(param1:EmitterInfo) : void{}
      
      public static function creatEmitter(param1:Number) : Emitter{return null;}
      
      public static function clear() : void{}
      
      private static function load(param1:XML) : void{}
      
      public static function initPartical(param1:String, param2:String = null) : void{}
      
      private static function __onShapeLoadComplete(param1:LoaderEvent) : void{}
      
      private static function __loadComplete(param1:LoaderEvent) : void{}
      
      private static function save() : XML{return null;}
      
      private static function encodeXLine(param1:String, param2:XLine) : XML{return null;}
   }
}
