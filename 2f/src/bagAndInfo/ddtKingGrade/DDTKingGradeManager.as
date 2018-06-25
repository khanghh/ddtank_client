package bagAndInfo.ddtKingGrade{   import com.pickgliss.ui.ComponentFactory;   import ddt.CoreManager;   import ddt.loader.LoaderCreate;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.HelperUIModuleLoad;   import road7th.data.DictionaryData;      public class DDTKingGradeManager extends CoreManager   {            private static var _instance:DDTKingGradeManager;                   private var _data:DictionaryData;            public var isOpen:Boolean;            public function DDTKingGradeManager() { super(); }
            public static function get Instance() : DDTKingGradeManager { return null; }
            override protected function start() : void { }
            private function onComplete() : void { }
            public function analyzer(analyzer:DDTKingGradeAnalyzer) : void { }
            public function get data() : DictionaryData { return null; }
            public function getInfoByCost(value:int) : DDTKingGradeInfo { return null; }
   }}