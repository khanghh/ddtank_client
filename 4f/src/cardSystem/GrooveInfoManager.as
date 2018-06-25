package cardSystem{   import cardSystem.data.CardGrooveInfo;   import ddt.data.analyze.CardGrooveEventAnalyzer;   import flash.utils.Dictionary;      public class GrooveInfoManager   {            private static var _instance:GrooveInfoManager;                   private var _grooveList:Dictionary;            public function GrooveInfoManager() { super(); }
            public static function get instance() : GrooveInfoManager { return null; }
            public function setup(analyzer:CardGrooveEventAnalyzer) : void { }
            public function getInfoByLevel(key:String, type:String) : CardGrooveInfo { return null; }
   }}