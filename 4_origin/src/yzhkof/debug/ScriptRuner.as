package yzhkof.debug
{
   import com.hurlant.eval.ByteLoader;
   import com.hurlant.eval.CompiledESC;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import yzhkof.loader.CompatibleURLLoader;
   import yzhkof.logicdata.ScriptRun;
   import yzhkof.util.WeakMap;
   
   public class ScriptRuner
   {
      
      private static var runer:CompiledESC;
      
      private static var weakTarget:WeakMap = new WeakMap();
      
      private static var xml:XML;
      
      private static var script_xml:XMLList;
      
      private static var import_text:String = "";
      
      private static const CONFIG_XML_URL:String = "xml/debugConfig.xml";
      
      public static var global:Object;
      
      private static var scripts:Object = new Object();
      
      private static var importCount:int = 0;
      
      private static const tailText:String = ";ScriptRuner.global = this";
       
      
      public function ScriptRuner()
      {
         super();
      }
      
      public static function init() : void
      {
         var loader:CompatibleURLLoader = null;
         if(!runer)
         {
            runer = new CompiledESC();
         }
         loader = new CompatibleURLLoader();
         loader.loadURL(CONFIG_XML_URL);
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            xml = XML(loader.data);
            analyseXml();
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
            trace("debug config fail! at \"" + CONFIG_XML_URL + "\"");
         });
      }
      
      private static function analyseXml() : void
      {
         var length:uint = 0;
         var i:int = 0;
         try
         {
            DebugSystem._mainContainer.visible = xml.@hide == "false"?true:false;
            length = xml.import_namespace.length();
            import_text = "";
            i = 0;
            while(i < length)
            {
               import_text = import_text + ("namespace xmlu" + i + " = \"" + xml.import_namespace[i] + "\"; use namespace xmlu" + i + ";\n");
               i++;
            }
            import_text = import_text + "namespace xmlud = \"yzhkof.debug\"; use namespace xmlud;\n";
            script_xml = xml.script;
            reFreshScript();
            return;
         }
         catch(e:Error)
         {
            trace("debug config analyseXml fail! at \"" + CONFIG_XML_URL + "\"");
            return;
         }
      }
      
      public static function run(param1:String) : void
      {
         var _loc2_:String = import_text;
         _loc2_ = _loc2_ + convertImport(param1);
         var _loc3_:ByteArray = runer.eval(_loc2_);
         ByteLoader.loadBytes(_loc3_);
      }
      
      public static function compile(param1:String) : ByteArray
      {
         var _loc2_:String = "";
         _loc2_ = _loc2_ + convertImport(param1);
         return runer.eval(_loc2_);
      }
      
      public static function set target(param1:Object) : void
      {
         weakTarget = new WeakMap();
         weakTarget.add(0,param1);
      }
      
      public static function get target() : Object
      {
         return weakTarget.getValue(0);
      }
      
      public static function getDefinitionByName(param1:String) : *
      {
         return getDefinitionByName(param1);
      }
      
      public static function trace(param1:Object) : void
      {
         debugObjectTrace(param1);
      }
      
      public static function runScript(param1:String) : ScriptRun
      {
         var logic:ScriptRun = null;
         var urlloader:URLLoader = null;
         var loader:Loader = null;
         var byte:ByteArray = null;
         var script:String = null;
         var url:String = param1;
         logic = new ScriptRun();
         urlloader = new URLLoader(new URLRequest(url));
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            logic.dispatchEvent(new Event(Event.COMPLETE));
         });
         logic.urlLoader = urlloader;
         logic.loader = loader;
         script = import_text;
         urlloader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            script = script + (urlloader.data as String);
            script = script + tailText;
            script = convertImport(script);
            byte = runer.eval(script);
            byte = ByteLoader.wrapInSWF([byte]);
            logic.script = script;
            logic.bytes = byte;
            loader.loadBytes(byte);
         });
         return logic;
      }
      
      public static function runScriptSynchronous(param1:String, param2:Array, param3:Boolean = false) : *
      {
         if(param3)
         {
            reFreshScript();
         }
         var _loc4_:Object = scripts[param1];
         if(!_loc4_)
         {
            throw new Error("脚本名字错误!");
         }
         return _loc4_.run.apply(null,param2);
      }
      
      public static function reFreshScript() : void
      {
         var _loc2_:XML = null;
         var _loc1_:uint = script_xml.length();
         for each(_loc2_ in script_xml)
         {
            loadScript(_loc2_,_loc2_.@name);
         }
      }
      
      public static function loadScript(param1:String, param2:String = null) : void
      {
         var urlloader:URLLoader = null;
         var loader:Loader = null;
         var byte:ByteArray = null;
         var script:String = null;
         var url:String = param1;
         var name:String = param2;
         urlloader = new URLLoader(new URLRequest(url));
         loader = new Loader();
         name = name || url;
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
         });
         script = import_text;
         urlloader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            script = script + (urlloader.data as String);
            script = script + (";ScriptRuner.addScript(this,\"" + name + "\");");
            script = convertImport(script);
            byte = runer.eval(script);
            byte = ByteLoader.wrapInSWF([byte]);
            loader.loadBytes(byte);
         });
      }
      
      public static function addScript(param1:Object, param2:String) : void
      {
         scripts[param2] = param1;
      }
      
      private static function convertImport(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc2_:RegExp = /import.*/g;
         var _loc3_:Array = param1.match(_loc2_);
         for each(_loc4_ in _loc3_)
         {
            param1 = param1.replace(_loc4_,getImport(getPackage(_loc4_)));
            importCount++;
         }
         return param1;
      }
      
      private static function getPackage(param1:String) : String
      {
         var _loc2_:RegExp = / .*\./;
         var _loc3_:String = param1.match(_loc2_)[0];
         return _loc3_.substring(1,_loc3_.length - 1);
      }
      
      private static function getImport(param1:String) : String
      {
         return "namespace importn" + importCount + " = \"" + param1 + "\"; use namespace importn" + importCount + ";\n";
      }
   }
}
