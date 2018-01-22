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
       
      
      public function ParticleManager()
      {
         super();
      }
      
      public static function get ready() : Boolean
      {
         return _ready;
      }
      
      public static function addEmitterInfo(param1:EmitterInfo) : void
      {
         list.push(param1);
      }
      
      public static function removeEmitterInfo(param1:EmitterInfo) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            if(list[_loc2_] == param1)
            {
               list.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public static function creatEmitter(param1:Number) : Emitter
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var _loc3_ in list)
         {
            if(_loc3_.id == param1)
            {
               _loc2_ = new Emitter();
               _loc2_.info = _loc3_;
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function clear() : void
      {
         list = [];
         _ready = false;
      }
      
      private static function load(param1:XML) : void
      {
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc8_:XMLList = param1..emitter;
         var _loc2_:XML = describeType(new ParticleInfo());
         var _loc11_:XML = describeType(new EmitterInfo());
         var _loc18_:int = 0;
         var _loc17_:* = _loc8_;
         for each(var _loc12_ in _loc8_)
         {
            _loc7_ = new EmitterInfo();
            ObjectUtils.copyPorpertiesByXML(_loc7_,_loc12_);
            _loc9_ = _loc12_.particle;
            var _loc16_:int = 0;
            var _loc15_:* = _loc9_;
            for each(var _loc6_ in _loc9_)
            {
               _loc10_ = new ParticleInfo();
               ObjectUtils.copyPorpertiesByXML(_loc10_,_loc6_);
               _loc4_ = _loc6_.easing;
               _loc5_ = new AbstractLifeEasing();
               var _loc14_:int = 0;
               var _loc13_:* = _loc4_;
               for each(var _loc3_ in _loc4_)
               {
                  if(_loc3_.@name != "colorLine")
                  {
                     _loc5_[_loc3_.@name].line = XLine.parse(_loc3_.@value);
                  }
                  else
                  {
                     _loc5_.colorLine = new ColorLine();
                     _loc5_.colorLine.line = XLine.parse(_loc3_.@value);
                  }
               }
               _loc10_.lifeEasing = _loc5_;
               _loc7_.particales.push(_loc10_);
            }
            list.push(_loc7_);
         }
         _ready = true;
      }
      
      public static function initPartical(param1:String, param2:String = null) : void
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(!_ready && param1 != null)
         {
            Domain = new ApplicationDomain();
            _loc6_ = param1 + (param2 == "lite"?"particallite.xml":"partical.xml");
            _loc3_ = param1 + (param2 == "lite"?"shapelite.swf":"shape.swf");
            _loc5_ = LoadResourceManager.Instance.createLoader(_loc6_,2);
            _loc5_.addEventListener("complete",__loadComplete);
            LoadResourceManager.Instance.startLoad(_loc5_);
            _loc4_ = LoadResourceManager.Instance.createLoader(_loc3_,4,null,"GET",Domain);
            _loc4_.addEventListener("complete",__onShapeLoadComplete);
            LoadResourceManager.Instance.startLoad(_loc4_);
         }
      }
      
      private static function __onShapeLoadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__onShapeLoadComplete);
         ShapeManager.setup();
      }
      
      private static function __loadComplete(param1:LoaderEvent) : void
      {
         param1.loader.removeEventListener("complete",__loadComplete);
         try
         {
            load(new XML(param1.loader.content));
            return;
         }
         catch(err:Error)
         {
            return;
         }
      }
      
      private static function save() : XML
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:XML = <list></list>;
         var _loc9_:int = 0;
         var _loc8_:* = list;
         for each(var _loc1_ in list)
         {
            _loc4_ = ObjectUtils.encode("emitter",_loc1_);
            var _loc7_:int = 0;
            var _loc6_:* = _loc1_.particales;
            for each(var _loc5_ in _loc1_.particales)
            {
               _loc3_ = ObjectUtils.encode("particle",_loc5_);
               _loc3_.appendChild(encodeXLine("vLine",_loc5_.lifeEasing.vLine));
               _loc3_.appendChild(encodeXLine("rvLine",_loc5_.lifeEasing.rvLine));
               _loc3_.appendChild(encodeXLine("spLine",_loc5_.lifeEasing.spLine));
               _loc3_.appendChild(encodeXLine("sizeLine",_loc5_.lifeEasing.sizeLine));
               _loc3_.appendChild(encodeXLine("weightLine",_loc5_.lifeEasing.weightLine));
               _loc3_.appendChild(encodeXLine("alphaLine",_loc5_.lifeEasing.alphaLine));
               if(_loc5_.lifeEasing.colorLine)
               {
                  _loc3_.appendChild(encodeXLine("colorLine",_loc5_.lifeEasing.colorLine));
               }
               _loc4_.appendChild(_loc3_);
            }
            _loc2_.appendChild(_loc4_);
         }
         return _loc2_;
      }
      
      private static function encodeXLine(param1:String, param2:XLine) : XML
      {
         return new XML("<easing name=\"" + param1 + "\" value=\"" + XLine.ToString(param2.line) + "\" />");
      }
   }
}
