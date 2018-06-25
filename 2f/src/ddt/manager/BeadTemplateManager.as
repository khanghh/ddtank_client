package ddt.manager{   import beadSystem.model.BeadInfo;   import ddt.data.analyze.AdvanceBeadAnalyzer;   import ddt.data.analyze.BeadAnalyzer;   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;      public class BeadTemplateManager extends EventDispatcher   {            private static var _instance:BeadTemplateManager;                   public var _beadList:DictionaryData;            public var _advanceBeadList:DictionaryData;            public function BeadTemplateManager() { super(); }
            public static function get Instance() : BeadTemplateManager { return null; }
            public function setup(pAnalyzer:BeadAnalyzer) : void { }
            public function setupAdvanceBead(analyzer:AdvanceBeadAnalyzer) : void { }
            public function getBeadAdvanceData(type:int) : DictionaryData { return null; }
            public function GetBeadInfobyID(pBeadTemplateID:int) : BeadInfo { return null; }
            public function GetBeadTemplateIDByLv(pLv:int, pIDbefore:int) : int { return 0; }
   }}