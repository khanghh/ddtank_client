package store.newFusion{   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import store.newFusion.data.FusionNewDataAnalyzer;      public class FusionNewManager extends EventDispatcher   {            private static var _instance:FusionNewManager;                   public var isInContinuousFusion:Boolean;            private var _dataList:Object;            public function FusionNewManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : FusionNewManager { return null; }
            public function setup(analyzer:FusionNewDataAnalyzer) : void { }
            public function getDataListByType(type:int) : Array { return null; }
            public function get dataList() : Object { return null; }
   }}