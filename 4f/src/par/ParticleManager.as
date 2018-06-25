package par{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.ModuleLoader;   import com.pickgliss.utils.ObjectUtils;   import flash.system.ApplicationDomain;   import flash.utils.describeType;   import par.emitters.Emitter;   import par.emitters.EmitterInfo;   import par.lifeeasing.AbstractLifeEasing;   import par.particals.ParticleInfo;   import road7th.math.ColorLine;   import road7th.math.XLine;      public class ParticleManager   {            public static var list:Array = [];            private static var _ready:Boolean;            public static const PARTICAL_XML_PATH:String = "partical.xml";            public static const SHAPE_PATH:String = "shape.swf";            public static const PARTICAL_LITE:String = "particallite.xml";            public static const SHAPE_LITE:String = "shapelite.swf";            static var Domain:ApplicationDomain;                   public function ParticleManager() { super(); }
            public static function get ready() : Boolean { return false; }
            public static function addEmitterInfo(info:EmitterInfo) : void { }
            public static function removeEmitterInfo(info:EmitterInfo) : void { }
            public static function creatEmitter(id:Number) : Emitter { return null; }
            public static function clear() : void { }
            private static function load(xml:XML) : void { }
            public static function initPartical(FLASHSITE:String, mode:String = null) : void { }
            private static function __onShapeLoadComplete(event:LoaderEvent) : void { }
            private static function __loadComplete(event:LoaderEvent) : void { }
            private static function save() : XML { return null; }
            private static function encodeXLine(name:String, value:XLine) : XML { return null; }
   }}