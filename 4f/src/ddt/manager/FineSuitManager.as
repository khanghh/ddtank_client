package ddt.manager{   import ddt.data.analyze.FineSuitAnalyze;   import ddt.data.store.FineSuitVo;   import road7th.data.DictionaryData;      public class FineSuitManager   {            private static var _instance:FineSuitManager;                   private var _model:DictionaryData;            private var _materialIDList:Array;            private var _data:DictionaryData;            private var propertyList:Array;            private var nameList:Array;            public function FineSuitManager() { super(); }
            public static function get Instance() : FineSuitManager { return null; }
            public function setup(analyze:FineSuitAnalyze) : void { }
            public function getSuitVoByExp(exp:int) : FineSuitVo { return null; }
            public function getNextLevelSuiteVo(exp:int) : FineSuitVo { return null; }
            public function getNextSuitVoByExp(exp:int) : FineSuitVo { return null; }
            public function updateFineSuitProperty(exp:int, dic:DictionaryData) : void { }
            public function getFineSuitPropertyByExp(exp:int) : FineSuitVo { return null; }
            public function getTipsPropertyInfoList(type:int, level:String) : Array { return null; }
            public function getTipsPropertyInfoListToString(type:int, level:String) : String { return null; }
            public function get materialIDList() : Array { return null; }
            public function get tipsData() : DictionaryData { return null; }
            public function getSuitVoByLevel(value:int) : FineSuitVo { return null; }
   }}