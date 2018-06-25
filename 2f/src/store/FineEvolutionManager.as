package store{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.loader.LoaderCreate;   import ddt.manager.GameInSocketOut;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperDataModuleLoad;   import ddt.utils.PositionUtils;   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;   import store.analyze.EvolutionDataAnalyzer;   import store.data.EvolutionData;      public class FineEvolutionManager extends EventDispatcher   {            private static var _instance:FineEvolutionManager;            protected static const All:String = "all";            protected static const FIRST_ONE:String = "one";            protected static const QUICK:String = "quick";            protected static const ALL_LOW:String = "all_Low";            protected static const ALL_REMAIN:String = "all_remain";                   private var _evolutionData:DictionaryData;            private var _needPlayMc:Boolean = false;            public var CallBack:Function;            private var _canClickBagList:Boolean = true;            private var _tagItem:InventoryItemInfo;            private var _tagTempleteItem:ItemTemplateInfo;            private var _quickEatInfo:InventoryItemInfo;            private var _state:String;            private var expData:Array;            private var _firstConfirm:Boolean = true;            private var _selectNumView:SelectNumBatchAlerFrame;            private var _singleNum:int;            private var _totalExp:int;            public function FineEvolutionManager() { super(); }
            public static function get Instance() : FineEvolutionManager { return null; }
            public function get needPlayMc() : Boolean { return false; }
            public function set needPlayMc(value:Boolean) : void { }
            public function EvolutionAnalyzer(data:EvolutionDataAnalyzer) : void { }
            public function get EvolutionDatas() : DictionaryData { return null; }
            public function EvolutionDataByLv(lv:int) : EvolutionData { return null; }
            public function GetNextEvolutionDataByEXP(exp:int) : EvolutionData { return null; }
            public function GetEvolutionDataByExp(exp:int) : EvolutionData { return null; }
            public function progress(info:InventoryItemInfo) : int { return 0; }
            public function LoadEvolutionData() : void { }
            public function get canClickBagList() : Boolean { return false; }
            public function set canClickBagList(value:Boolean) : void { }
            public function eatBeHaviour($info:InventoryItemInfo, $eatenInfo:InventoryItemInfo = null) : void { }
            private function showSelectAlert() : void { }
            private function responseSelectHandler(evt:FrameEvent) : void { }
            private function materialNumSelect(num:int) : void { }
            public function eat($state:String) : void { }
            private function responseEatHandler(evt:FrameEvent) : void { }
            private function getExperienceList(tagItem:InventoryItemInfo, type:String) : Array { return null; }
            private function checkLevel(value:InventoryItemInfo) : int { return 0; }
            private function sendEat() : void { }
   }}