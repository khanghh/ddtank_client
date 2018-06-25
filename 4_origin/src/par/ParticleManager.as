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
      
      public static function addEmitterInfo(info:EmitterInfo) : void
      {
         list.push(info);
      }
      
      public static function removeEmitterInfo(info:EmitterInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < list.length; )
         {
            if(list[i] == info)
            {
               list.splice(i,1);
               return;
            }
            i++;
         }
      }
      
      public static function creatEmitter(id:Number) : Emitter
      {
         var emitter:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var info in list)
         {
            if(info.id == id)
            {
               emitter = new Emitter();
               emitter.info = info;
               return emitter;
            }
         }
         return null;
      }
      
      public static function clear() : void
      {
         list = [];
         _ready = false;
      }
      
      private static function load(xml:XML) : void
      {
         var ei:* = null;
         var xml_pars:* = null;
         var po:* = null;
         var easing:* = null;
         var lifeEasing:* = null;
         var xml_emitter:XMLList = xml..emitter;
         var pcInfo:XML = describeType(new ParticleInfo());
         var ecInfo:XML = describeType(new EmitterInfo());
         var _loc18_:int = 0;
         var _loc17_:* = xml_emitter;
         for each(var x in xml_emitter)
         {
            ei = new EmitterInfo();
            ObjectUtils.copyPorpertiesByXML(ei,x);
            xml_pars = x.particle;
            var _loc16_:int = 0;
            var _loc15_:* = xml_pars;
            for each(var p in xml_pars)
            {
               po = new ParticleInfo();
               ObjectUtils.copyPorpertiesByXML(po,p);
               easing = p.easing;
               lifeEasing = new AbstractLifeEasing();
               var _loc14_:int = 0;
               var _loc13_:* = easing;
               for each(var e in easing)
               {
                  if(e.@name != "colorLine")
                  {
                     lifeEasing[e.@name].line = XLine.parse(e.@value);
                  }
                  else
                  {
                     lifeEasing.colorLine = new ColorLine();
                     lifeEasing.colorLine.line = XLine.parse(e.@value);
                  }
               }
               po.lifeEasing = lifeEasing;
               ei.particales.push(po);
            }
            list.push(ei);
         }
         _ready = true;
      }
      
      public static function initPartical(FLASHSITE:String, mode:String = null) : void
      {
         var particalPath:* = null;
         var shapePath:* = null;
         var particalXMLLoader:* = null;
         var shapeLoader:* = null;
         if(!_ready && FLASHSITE != null)
         {
            Domain = new ApplicationDomain();
            particalPath = FLASHSITE + (mode == "lite"?"particallite.xml":"partical.xml");
            shapePath = FLASHSITE + (mode == "lite"?"shapelite.swf":"shape.swf");
            particalXMLLoader = LoadResourceManager.Instance.createLoader(particalPath,2);
            particalXMLLoader.addEventListener("complete",__loadComplete);
            LoadResourceManager.Instance.startLoad(particalXMLLoader);
            shapeLoader = LoadResourceManager.Instance.createLoader(shapePath,4,null,"GET",Domain);
            shapeLoader.addEventListener("complete",__onShapeLoadComplete);
            LoadResourceManager.Instance.startLoad(shapeLoader);
         }
      }
      
      private static function __onShapeLoadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__onShapeLoadComplete);
         ShapeManager.setup();
      }
      
      private static function __loadComplete(event:LoaderEvent) : void
      {
         event.loader.removeEventListener("complete",__loadComplete);
         try
         {
            load(new XML(event.loader.content));
            return;
         }
         catch(err:Error)
         {
            return;
         }
      }
      
      private static function save() : XML
      {
         var exml:* = null;
         var xpi:* = null;
         var doc:XML = <list></list>;
         var _loc9_:int = 0;
         var _loc8_:* = list;
         for each(var ei in list)
         {
            exml = ObjectUtils.encode("emitter",ei);
            var _loc7_:int = 0;
            var _loc6_:* = ei.particales;
            for each(var pi in ei.particales)
            {
               xpi = ObjectUtils.encode("particle",pi);
               xpi.appendChild(encodeXLine("vLine",pi.lifeEasing.vLine));
               xpi.appendChild(encodeXLine("rvLine",pi.lifeEasing.rvLine));
               xpi.appendChild(encodeXLine("spLine",pi.lifeEasing.spLine));
               xpi.appendChild(encodeXLine("sizeLine",pi.lifeEasing.sizeLine));
               xpi.appendChild(encodeXLine("weightLine",pi.lifeEasing.weightLine));
               xpi.appendChild(encodeXLine("alphaLine",pi.lifeEasing.alphaLine));
               if(pi.lifeEasing.colorLine)
               {
                  xpi.appendChild(encodeXLine("colorLine",pi.lifeEasing.colorLine));
               }
               exml.appendChild(xpi);
            }
            doc.appendChild(exml);
         }
         return doc;
      }
      
      private static function encodeXLine(name:String, value:XLine) : XML
      {
         return new XML("<easing name=\"" + name + "\" value=\"" + XLine.ToString(value.line) + "\" />");
      }
   }
}
