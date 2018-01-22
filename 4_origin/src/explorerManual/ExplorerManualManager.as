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
      
      public function ExplorerManualManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      public function startUpgrade(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         SocketManager.Instance.out.sendManualUpgrade(param1,param2,param3);
      }
      
      public function requestManualPageData(param1:int) : void
      {
         SocketManager.Instance.out.requestManualPageData(param1);
      }
      
      public function sendManualPageActive(param1:int, param2:int) : void
      {
         SocketManager.Instance.out.sendManualPageActive(param1,param2);
      }
      
      public function getManualProInfoByLev(param1:int) : ManualItemInfo
      {
         var _loc2_:* = null;
         if(_manualItemData && _manualItemData.hasKey(param1))
         {
            _loc2_ = _manualItemData[param1] as ManualItemInfo;
            return _loc2_;
         }
         return null;
      }
      
      public function getAddProItemInfo(param1:int) : ManualItemInfo
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:ManualItemInfo = new ManualItemInfo();
         var _loc2_:Array = _manualItemData.list;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_];
            if(_loc4_.Level <= param1)
            {
               if(_loc4_.Level == param1)
               {
                  _loc3_.Name = _loc4_.Name;
                  _loc3_.Level = _loc4_.Level;
               }
               _loc3_.Boost = _loc3_.Boost + _loc4_.Boost;
               _loc3_.MagicAttack = _loc3_.MagicAttack + _loc4_.MagicAttack;
               _loc3_.MagicResistance = _loc3_.MagicResistance + _loc4_.MagicResistance;
            }
            _loc5_++;
         }
         if(_loc3_.Level == 0)
         {
            return null;
         }
         return _loc3_;
      }
      
      public function getupgradeConditionByLev(param1:int) : Array
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(_manualUpgradeData)
         {
            _loc2_ = [];
            _loc3_ = 0;
            while(_loc3_ < _manualUpgradeData.length)
            {
               if(_manualUpgradeData[_loc3_].ManualLevel == param1)
               {
                  _loc2_.push(_manualUpgradeData[_loc3_]);
               }
               _loc3_++;
            }
            return _loc2_;
         }
         return null;
      }
      
      public function getChapterInfoByChapterID(param1:int) : ManualChapterInfo
      {
         var _loc2_:* = null;
         if(_chapterData)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _chapterData;
            for each(var _loc3_ in _chapterData)
            {
               if(_loc3_.ID == param1)
               {
                  _loc2_ = _loc3_;
                  break;
               }
            }
         }
         return _loc2_;
      }
      
      public function isHaveNewDebrisForPage(param1:int) : Boolean
      {
         var _loc2_:Array = SharedManager.Instance.manualNewPages;
         return _loc2_.indexOf(param1) != -1;
      }
      
      public function removeNewDebrisForPages(param1:int) : void
      {
         var _loc2_:Array = SharedManager.Instance.manualNewPages;
         if(_loc2_.indexOf(param1) != -1)
         {
            _loc2_.splice(_loc2_.indexOf(param1),1);
            SharedManager.Instance.manualNewPages = _loc2_;
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
      
      public function getAllPageByChapterID(param1:int) : Array
      {
         var _loc2_:* = null;
         if(_PageItemData)
         {
            _loc2_ = [];
            var _loc5_:int = 0;
            var _loc4_:* = _PageItemData;
            for each(var _loc3_ in _PageItemData)
            {
               if(_loc3_.ChapterID == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
            return _loc2_;
         }
         return null;
      }
      
      public function getDebrisByPageID(param1:int) : Array
      {
         var _loc2_:* = null;
         if(_debrisData)
         {
            _loc2_ = [];
            var _loc5_:int = 0;
            var _loc4_:* = _debrisData;
            for each(var _loc3_ in _debrisData)
            {
               if(_loc3_.PageID == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
            return _loc2_;
         }
         return null;
      }
      
      public function getDeBrisByDeBrisID(param1:int) : ManualDebrisInfo
      {
         if(_debrisData && _debrisData.hasKey(param1))
         {
            return _debrisData[param1];
         }
         return null;
      }
      
      public function getChapterByPageID(param1:int) : ManualPageItemInfo
      {
         if(_PageItemData && _PageItemData.hasKey(param1))
         {
            return _PageItemData[param1] as ManualPageItemInfo;
         }
         return null;
      }
      
      public function getManualInfoByManualLev(param1:int) : ManualItemInfo
      {
         if(_manualItemData && _manualItemData.hasKey(param1))
         {
            return _manualItemData[param1];
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
      
      public function isHaveNewDebris(param1:int) : Boolean
      {
         var _loc2_:Array = SharedManager.Instance.manualNewChapters;
         return _loc2_.indexOf(param1) != -1;
      }
      
      public function removeNewDebris(param1:int) : void
      {
         var _loc2_:Array = SharedManager.Instance.manualNewChapters;
         if(_loc2_.indexOf(param1) != -1)
         {
            _loc2_.splice(_loc2_.indexOf(param1),1);
            SharedManager.Instance.manualNewChapters = _loc2_;
            SharedManager.Instance.save();
         }
      }
      
      public function initDebrisData(param1:ManualDebrisAnalyzer) : void
      {
         _debrisData = param1.data;
      }
      
      public function initChapterData(param1:ChapterItemAnalyzer) : void
      {
         _chapterData = param1.data;
      }
      
      public function initManualItemData(param1:ManualItemAnalyzer) : void
      {
         _manualItemData = param1.data;
      }
      
      public function initManualUpgradeData(param1:ManualUpgradeAnalyzer) : void
      {
         _manualUpgradeData = param1.data;
      }
      
      public function initPageItemData(param1:ManualPageItemAnalyzer) : void
      {
         _PageItemData = param1.data;
      }
      
      public function get isInitData() : Boolean
      {
         return _isInitData;
      }
      
      public function set isInitData(param1:Boolean) : void
      {
         _isInitData = param1;
      }
      
      public function set cachNewChapter(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:Array = SharedManager.Instance.manualNewChapters;
         var _loc2_:Array = SharedManager.Instance.manualNewPages;
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = getChapterByPageID(param1[_loc5_]);
            if(_loc3_ != null)
            {
               if(_loc4_.indexOf(_loc3_.ChapterID) == -1)
               {
                  _loc4_.push(_loc3_.ChapterID);
               }
               if(_loc2_.indexOf(_loc3_.ID) == -1)
               {
                  _loc2_.push(_loc3_.ID);
               }
            }
            _loc5_++;
         }
         SharedManager.Instance.manualNewChapters = _loc4_;
         SharedManager.Instance.manualNewPages = _loc2_;
         SharedManager.Instance.save();
      }
   }
}
