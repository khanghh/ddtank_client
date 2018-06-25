package yzhkof.debug{   import com.hurlant.eval.ByteLoader;   import com.hurlant.eval.CompiledESC;   import flash.display.Loader;   import flash.events.Event;   import flash.events.IOErrorEvent;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.utils.ByteArray;   import yzhkof.loader.CompatibleURLLoader;   import yzhkof.logicdata.ScriptRun;   import yzhkof.util.WeakMap;      public class ScriptRuner   {            private static var runer:CompiledESC;            private static var weakTarget:WeakMap = new WeakMap();            private static var xml:XML;            private static var script_xml:XMLList;            private static var import_text:String = "";            private static const CONFIG_XML_URL:String = "xml/debugConfig.xml";            public static var global:Object;            private static var scripts:Object = new Object();            private static var importCount:int = 0;            private static const tailText:String = ";ScriptRuner.global = this";                   public function ScriptRuner() { super(); }
            public static function init() : void { }
            private static function analyseXml() : void { }
            public static function run(script:String) : void { }
            public static function compile(script:String) : ByteArray { return null; }
            public static function set target(value:Object) : void { }
            public static function get target() : Object { return null; }
            public static function getDefinitionByName(value:String) : * { return null; }
            public static function trace(obj:Object) : void { }
            public static function runScript(url:String) : ScriptRun { return null; }
            public static function runScriptSynchronous(name:String, param:Array, refresh:Boolean = false) : * { return null; }
            public static function reFreshScript() : void { }
            public static function loadScript(url:String, name:String = null) : void { }
            public static function addScript(script_point:Object, name:String) : void { }
            private static function convertImport(str:String) : String { return null; }
            private static function getPackage(str:String) : String { return null; }
            private static function getImport(str:String) : String { return null; }
   }}