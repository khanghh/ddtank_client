package explorerManual
{
   import ddt.CoreManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import explorerManual.analyzer.ChapterItemAnalyzer;
   import explorerManual.analyzer.ManualDebrisAnalyzer;
   import explorerManual.analyzer.ManualItemAnalyzer;
   import explorerManual.analyzer.ManualPageItemAnalyzer;
   import explorerManual.analyzer.ManualUpgradeAnalyzer;
   import explorerManual.data.model.ManualChapterInfo;
   import explorerManual.data.model.ManualDebrisInfo;
   import explorerManual.data.model.ManualItemInfo;
   import explorerManual.data.model.ManualPageItemInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   
   public class ExplorerManualManager extends CoreManager
   {
      
      private static var _instance:ExplorerManualManager;
       
      
      private var _isInitData:Boolean = false;
      
      private var _debrisData:DictionaryData = null;
      
      private var _chapterData:DictionaryData = null;
      
      private var _manualItemData:DictionaryData = null;
      
      private var _manualUpgradeData:Array;
      
      private var _PageItemData:DictionaryData = null;
      
      public function ExplorerManualManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ExplorerManualManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      public function requestInitData() : void{}
      
      public function startUpgrade(param1:Boolean, param2:Boolean, param3:Boolean) : void{}
      
      public function requestManualPageData(param1:int) : void{}
      
      public function sendManualPageActive(param1:int, param2:int) : void{}
      
      public function getManualProInfoByLev(param1:int) : ManualItemInfo{return null;}
      
      public function getAddProItemInfo(param1:int) : ManualItemInfo{return null;}
      
      public function getupgradeConditionByLev(param1:int) : Array{return null;}
      
      public function getChapterInfoByChapterID(param1:int) : ManualChapterInfo{return null;}
      
      public function isHaveNewDebrisForPage(param1:int) : Boolean{return false;}
      
      public function removeNewDebrisForPages(param1:int) : void{}
      
      public function getChaptersInfo() : Array{return null;}
      
      public function getAllPageByChapterID(param1:int) : Array{return null;}
      
      public function getDebrisByPageID(param1:int) : Array{return null;}
      
      public function getDeBrisByDeBrisID(param1:int) : ManualDebrisInfo{return null;}
      
      public function getChapterByPageID(param1:int) : ManualPageItemInfo{return null;}
      
      public function getManualInfoByManualLev(param1:int) : ManualItemInfo{return null;}
      
      public function getAllPageItemCount() : int{return 0;}
      
      public function isHaveNewDebris(param1:int) : Boolean{return false;}
      
      public function removeNewDebris(param1:int) : void{}
      
      public function initDebrisData(param1:ManualDebrisAnalyzer) : void{}
      
      public function initChapterData(param1:ChapterItemAnalyzer) : void{}
      
      public function initManualItemData(param1:ManualItemAnalyzer) : void{}
      
      public function initManualUpgradeData(param1:ManualUpgradeAnalyzer) : void{}
      
      public function initPageItemData(param1:ManualPageItemAnalyzer) : void{}
      
      public function get isInitData() : Boolean{return false;}
      
      public function set isInitData(param1:Boolean) : void{}
      
      public function set cachNewChapter(param1:Array) : void{}
   }
}
