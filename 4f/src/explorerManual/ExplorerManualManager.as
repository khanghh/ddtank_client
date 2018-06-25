package explorerManual{   import ddt.CoreManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import explorerManual.analyzer.ChapterItemAnalyzer;   import explorerManual.analyzer.ManualDebrisAnalyzer;   import explorerManual.analyzer.ManualItemAnalyzer;   import explorerManual.analyzer.ManualPageItemAnalyzer;   import explorerManual.analyzer.ManualUpgradeAnalyzer;   import explorerManual.data.model.ManualChapterInfo;   import explorerManual.data.model.ManualDebrisInfo;   import explorerManual.data.model.ManualItemInfo;   import explorerManual.data.model.ManualPageItemInfo;   import flash.events.Event;   import flash.events.IEventDispatcher;   import road7th.data.DictionaryData;      public class ExplorerManualManager extends CoreManager   {            private static var _instance:ExplorerManualManager;                   private var _isInitData:Boolean = false;            private var _debrisData:DictionaryData = null;            private var _chapterData:DictionaryData = null;            private var _manualItemData:DictionaryData = null;            private var _manualUpgradeData:Array;            private var _PageItemData:DictionaryData = null;            public function ExplorerManualManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : ExplorerManualManager { return null; }
            public function setup() : void { }
            override protected function start() : void { }
            public function requestInitData() : void { }
            public function startUpgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean) : void { }
            public function requestManualPageData(chapterID:int) : void { }
            public function sendManualPageActive(activeType:int, pageID:int) : void { }
            public function getManualProInfoByLev(lev:int) : ManualItemInfo { return null; }
            public function getAddProItemInfo(lev:int) : ManualItemInfo { return null; }
            public function getupgradeConditionByLev(lev:int) : Array { return null; }
            public function getChapterInfoByChapterID(chapterID:int) : ManualChapterInfo { return null; }
            public function isHaveNewDebrisForPage(pageID:int) : Boolean { return false; }
            public function removeNewDebrisForPages(pageID:int) : void { }
            public function getChaptersInfo() : Array { return null; }
            public function getAllPageByChapterID(chapterID:int) : Array { return null; }
            public function getDebrisByPageID(pageID:int) : Array { return null; }
            public function getDeBrisByDeBrisID(debrisID:int) : ManualDebrisInfo { return null; }
            public function getChapterByPageID(pageID:int) : ManualPageItemInfo { return null; }
            public function getManualInfoByManualLev(lev:int) : ManualItemInfo { return null; }
            public function getAllPageItemCount() : int { return 0; }
            public function isHaveNewDebris(chapterID:int) : Boolean { return false; }
            public function removeNewDebris(chapterID:int) : void { }
            public function initDebrisData(analyzer:ManualDebrisAnalyzer) : void { }
            public function initChapterData(analyzer:ChapterItemAnalyzer) : void { }
            public function initManualItemData(analyzer:ManualItemAnalyzer) : void { }
            public function initManualUpgradeData(analyzer:ManualUpgradeAnalyzer) : void { }
            public function initPageItemData(analyzer:ManualPageItemAnalyzer) : void { }
            public function get isInitData() : Boolean { return false; }
            public function set isInitData(value:Boolean) : void { }
            public function set cachNewChapter(chapters:Array) : void { }
   }}