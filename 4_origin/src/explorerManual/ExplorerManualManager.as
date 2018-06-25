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
      
      public function ExplorerManualManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ExplorerManualManager
      {
         if(_instance == null)
         {
            _instance = new ExplorerManualManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _isInitData = false;
      }
      
      override protected function start() : void
      {
         this.dispatchEvent(new Event("openView"));
      }
      
      public function requestInitData() : void
      {
         SocketManager.Instance.out.requestManualInitData();
      }
      
      public function startUpgrade(autoBuy:Boolean, bindMoney:Boolean, autoUpgrade:Boolean) : void
      {
         SocketManager.Instance.out.sendManualUpgrade(autoBuy,bindMoney,autoUpgrade);
      }
      
      public function requestManualPageData(chapterID:int) : void
      {
         SocketManager.Instance.out.requestManualPageData(chapterID);
      }
      
      public function sendManualPageActive(activeType:int, pageID:int) : void
      {
         SocketManager.Instance.out.sendManualPageActive(activeType,pageID);
      }
      
      public function getManualProInfoByLev(lev:int) : ManualItemInfo
      {
         var infos:* = null;
         if(_manualItemData && _manualItemData.hasKey(lev))
         {
            infos = _manualItemData[lev] as ManualItemInfo;
            return infos;
         }
         return null;
      }
      
      public function getAddProItemInfo(lev:int) : ManualItemInfo
      {
         var i:int = 0;
         var item:* = null;
         var temInfo:ManualItemInfo = new ManualItemInfo();
         var arr:Array = _manualItemData.list;
         for(i = 0; i < arr.length; )
         {
            item = arr[i];
            if(item.Level <= lev)
            {
               if(item.Level == lev)
               {
                  temInfo.Name = item.Name;
                  temInfo.Level = item.Level;
               }
               temInfo.Boost = temInfo.Boost + item.Boost;
               temInfo.MagicAttack = temInfo.MagicAttack + item.MagicAttack;
               temInfo.MagicResistance = temInfo.MagicResistance + item.MagicResistance;
            }
            i++;
         }
         if(temInfo.Level == 0)
         {
            return null;
         }
         return temInfo;
      }
      
      public function getupgradeConditionByLev(lev:int) : Array
      {
         var temArr:* = null;
         var i:int = 0;
         if(_manualUpgradeData)
         {
            temArr = [];
            for(i = 0; i < _manualUpgradeData.length; )
            {
               if(_manualUpgradeData[i].ManualLevel == lev)
               {
                  temArr.push(_manualUpgradeData[i]);
               }
               i++;
            }
            return temArr;
         }
         return null;
      }
      
      public function getChapterInfoByChapterID(chapterID:int) : ManualChapterInfo
      {
         var temInfo:* = null;
         if(_chapterData)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _chapterData;
            for each(var info in _chapterData)
            {
               if(info.ID == chapterID)
               {
                  temInfo = info;
                  break;
               }
            }
         }
         return temInfo;
      }
      
      public function isHaveNewDebrisForPage(pageID:int) : Boolean
      {
         var temPageID:Array = SharedManager.Instance.manualNewPages;
         return temPageID.indexOf(pageID) != -1;
      }
      
      public function removeNewDebrisForPages(pageID:int) : void
      {
         var temPagesID:Array = SharedManager.Instance.manualNewPages;
         if(temPagesID.indexOf(pageID) != -1)
         {
            temPagesID.splice(temPagesID.indexOf(pageID),1);
            SharedManager.Instance.manualNewPages = temPagesID;
            SharedManager.Instance.save();
         }
      }
      
      public function getChaptersInfo() : Array
      {
         if(_chapterData)
         {
            return _chapterData.list;
         }
         return null;
      }
      
      public function getAllPageByChapterID(chapterID:int) : Array
      {
         var temArr:* = null;
         if(_PageItemData)
         {
            temArr = [];
            var _loc5_:int = 0;
            var _loc4_:* = _PageItemData;
            for each(var info in _PageItemData)
            {
               if(info.ChapterID == chapterID)
               {
                  temArr.push(info);
               }
            }
            return temArr;
         }
         return null;
      }
      
      public function getDebrisByPageID(pageID:int) : Array
      {
         var temArr:* = null;
         if(_debrisData)
         {
            temArr = [];
            var _loc5_:int = 0;
            var _loc4_:* = _debrisData;
            for each(var info in _debrisData)
            {
               if(info.PageID == pageID)
               {
                  temArr.push(info);
               }
            }
            return temArr;
         }
         return null;
      }
      
      public function getDeBrisByDeBrisID(debrisID:int) : ManualDebrisInfo
      {
         if(_debrisData && _debrisData.hasKey(debrisID))
         {
            return _debrisData[debrisID];
         }
         return null;
      }
      
      public function getChapterByPageID(pageID:int) : ManualPageItemInfo
      {
         if(_PageItemData && _PageItemData.hasKey(pageID))
         {
            return _PageItemData[pageID] as ManualPageItemInfo;
         }
         return null;
      }
      
      public function getManualInfoByManualLev(lev:int) : ManualItemInfo
      {
         if(_manualItemData && _manualItemData.hasKey(lev))
         {
            return _manualItemData[lev];
         }
         return null;
      }
      
      public function getAllPageItemCount() : int
      {
         if(_PageItemData)
         {
            return _PageItemData.length;
         }
         return 0;
      }
      
      public function isHaveNewDebris(chapterID:int) : Boolean
      {
         var temChapterID:Array = SharedManager.Instance.manualNewChapters;
         return temChapterID.indexOf(chapterID) != -1;
      }
      
      public function removeNewDebris(chapterID:int) : void
      {
         var temChapterID:Array = SharedManager.Instance.manualNewChapters;
         if(temChapterID.indexOf(chapterID) != -1)
         {
            temChapterID.splice(temChapterID.indexOf(chapterID),1);
            SharedManager.Instance.manualNewChapters = temChapterID;
            SharedManager.Instance.save();
         }
      }
      
      public function initDebrisData(analyzer:ManualDebrisAnalyzer) : void
      {
         _debrisData = analyzer.data;
      }
      
      public function initChapterData(analyzer:ChapterItemAnalyzer) : void
      {
         _chapterData = analyzer.data;
      }
      
      public function initManualItemData(analyzer:ManualItemAnalyzer) : void
      {
         _manualItemData = analyzer.data;
      }
      
      public function initManualUpgradeData(analyzer:ManualUpgradeAnalyzer) : void
      {
         _manualUpgradeData = analyzer.data;
      }
      
      public function initPageItemData(analyzer:ManualPageItemAnalyzer) : void
      {
         _PageItemData = analyzer.data;
      }
      
      public function get isInitData() : Boolean
      {
         return _isInitData;
      }
      
      public function set isInitData(value:Boolean) : void
      {
         _isInitData = value;
      }
      
      public function set cachNewChapter(chapters:Array) : void
      {
         var pageInfo:* = null;
         var i:int = 0;
         var oldChapters:Array = SharedManager.Instance.manualNewChapters;
         var oldPages:Array = SharedManager.Instance.manualNewPages;
         for(i = 0; i < chapters.length; )
         {
            pageInfo = getChapterByPageID(chapters[i]);
            if(pageInfo != null)
            {
               if(oldChapters.indexOf(pageInfo.ChapterID) == -1)
               {
                  oldChapters.push(pageInfo.ChapterID);
               }
               if(oldPages.indexOf(pageInfo.ID) == -1)
               {
                  oldPages.push(pageInfo.ID);
               }
            }
            i++;
         }
         SharedManager.Instance.manualNewChapters = oldChapters;
         SharedManager.Instance.manualNewPages = oldPages;
         SharedManager.Instance.save();
      }
   }
}
