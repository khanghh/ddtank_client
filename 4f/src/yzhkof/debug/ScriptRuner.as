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
       
      
      public function ScriptRuner(){super();}
      
      public static function init() : void{}
      
      private static function analyseXml() : void{}
      
      public static function run(param1:String) : void{}
      
      public static function compile(param1:String) : ByteArray{return null;}
      
      public static function set target(param1:Object) : void{}
      
      public static function get target() : Object{return null;}
      
      public static function getDefinitionByName(param1:String) : *{return null;}
      
      public static function trace(param1:Object) : void{}
      
      public static function runScript(param1:String) : ScriptRun{return null;}
      
      public static function runScriptSynchronous(param1:String, param2:Array, param3:Boolean = false) : *{return null;}
      
      public static function reFreshScript() : void{}
      
      public static function loadScript(param1:String, param2:String = null) : void{}
      
      public static function addScript(param1:Object, param2:String) : void{}
      
      private static function convertImport(param1:String) : String{return null;}
      
      private static function getPackage(param1:String) : String{return null;}
      
      private static function getImport(param1:String) : String{return null;}
   }
}
