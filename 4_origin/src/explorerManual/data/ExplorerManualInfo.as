package explorerManual.data
{
   import explorerManual.ExplorerManualManager;
   import explorerManual.data.model.ManualItemInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class ExplorerManualInfo extends EventDispatcher
   {
      
      public static const P_manualLev:String = "manualLev";
      
      public static const P_debrisInfo:String = "debrisInfo";
      
      public static const P_activePageID:String = "activePageID";
      
      public static const P_progress:String = "progress";
      
      public static const P_manualPro:String = "manualPro";
      
      public static const P_refreshData:String = "manualrefresh";
       
      
      protected var _changedPropeties:Dictionary;
      
      protected var _changeCount:int = 0;
      
      private var _count:int = 0;
      
      private var _manualLev:int = -1;
      
      private var _progress:int;
      
      private var _maxProgress:int = 0;
      
      private var _proLevMaxProgress:int = 0;
      
      private var _curPro:ManualLevelProInfo;
      
      private var _nextPro:ManualLevelProInfo;
      
      private var _pageAllPro:PageItemAllProInfo;
      
      private var _activePageID:Array;
      
      private var _upgradeCondition:UpgradeConditonBase;
      
      private var _havePage:int;
      
      private var _conditionCount:int;
      
      private var _debrisInfo:ManualPageDebrisInfo;
      
      public function ExplorerManualInfo()
      {
         _changedPropeties = new Dictionary();
         super();
         _curPro = new ManualLevelProInfo();
         _nextPro = new ManualLevelProInfo();
         _debrisInfo = new ManualPageDebrisInfo();
      }
      
      public function get proLevMaxProgress() : int
      {
         return _proLevMaxProgress;
      }
      
      public function set proLevMaxProgress(param1:int) : void
      {
         _proLevMaxProgress = param1;
      }
      
      public function beginChanges() : void
      {
         _changeCount = Number(_changeCount) + 1;
      }
      
      public function commitChanges() : void
      {
         _changeCount = Number(_changeCount) - 1;
         invalidate();
      }
      
      protected function invalidate() : void
      {
         if(_changeCount <= 0)
         {
            _changeCount = 0;
            onProppertiesUpdate();
            _changedPropeties = new Dictionary(true);
         }
      }
      
      protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["manualLev"])
         {
            this.dispatchEvent(new Event("manualLevelChangle"));
         }
         if(_changedPropeties["debrisInfo"])
         {
            this.dispatchEvent(new Event("updatePageView"));
         }
         if(_changedPropeties["activePageID"])
         {
            this.dispatchEvent(new Event("pageActiveComplete"));
         }
         if(_changedPropeties["progress"])
         {
            this.dispatchEvent(new Event("manualProgressUpdate"));
         }
         if(_changedPropeties["manualPro"])
         {
            this.dispatchEvent(new Event("manualProUpdate"));
         }
         if(_changedPropeties["manualrefresh"])
         {
            this.dispatchEvent(new Event("manualModelUpdate"));
         }
      }
      
      protected function onPropertiesChanged(param1:String = null) : void
      {
         if(_changedPropeties == null)
         {
            return;
         }
         if(_changedPropeties[param1])
         {
            return;
         }
         if(param1 != null)
         {
            _changedPropeties[param1] = true;
         }
         invalidate();
      }
      
      public function get debrisInfo() : ManualPageDebrisInfo
      {
         return _debrisInfo;
      }
      
      public function set debrisInfo(param1:ManualPageDebrisInfo) : void
      {
         _debrisInfo = param1;
         onPropertiesChanged("debrisInfo");
      }
      
      public function get conditionCount() : int
      {
         return _conditionCount;
      }
      
      public function set conditionCount(param1:int) : void
      {
         _conditionCount = param1;
      }
      
      public function get havePage() : int
      {
         return _havePage;
      }
      
      public function set havePage(param1:int) : void
      {
         _havePage = param1;
      }
      
      public function get upgradeCondition() : UpgradeConditonBase
      {
         return _upgradeCondition;
      }
      
      public function set upgradeCondition(param1:UpgradeConditonBase) : void
      {
         _upgradeCondition = param1;
      }
      
      public function get maxProgress() : int
      {
         return _maxProgress;
      }
      
      public function set maxProgress(param1:int) : void
      {
         proLevMaxProgress = _maxProgress;
         _maxProgress = param1;
         if(proLevMaxProgress == 0)
         {
            proLevMaxProgress = _maxProgress;
         }
      }
      
      public function get activePageID() : Array
      {
         return _activePageID;
      }
      
      public function set activePageID(param1:Array) : void
      {
         _activePageID = param1;
         onPropertiesChanged("activePageID");
      }
      
      public function chapterProgress(param1:int) : String
      {
         var _loc5_:int = 0;
         var _loc3_:Array = ExplorerManualManager.instance.getAllPageByChapterID(param1);
         var _loc2_:int = _loc3_.length;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            if(checkPageActiveByPageID(_loc3_[_loc5_].ID))
            {
               _loc4_++;
            }
            _loc5_++;
         }
         return "<FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FF0000\' ><B>" + _loc4_ + "</B></FONT>" + "/" + _loc2_;
      }
      
      public function checkPageActiveByPageID(param1:int) : Boolean
      {
         return activePageID.indexOf(param1) != -1;
      }
      
      public function get pageAllPro() : PageItemAllProInfo
      {
         return _pageAllPro;
      }
      
      public function set pageAllPro(param1:PageItemAllProInfo) : void
      {
         _pageAllPro = param1;
      }
      
      public function get nextPro() : ManualLevelProInfo
      {
         return _nextPro;
      }
      
      public function set nextPro(param1:ManualLevelProInfo) : void
      {
         _nextPro = param1;
      }
      
      public function get curPro() : ManualLevelProInfo
      {
         return _curPro;
      }
      
      public function set curPro(param1:ManualLevelProInfo) : void
      {
         _curPro = param1;
      }
      
      public function get progress() : int
      {
         return _progress;
      }
      
      public function set progress(param1:int) : void
      {
         if(_progress == param1)
         {
            return;
         }
         _progress = param1;
         onPropertiesChanged("progress");
      }
      
      public function get manualLev() : int
      {
         return _manualLev;
      }
      
      public function set manualLev(param1:int) : void
      {
         if(_manualLev == param1)
         {
            return;
         }
         if(_manualLev != -1)
         {
            onPropertiesChanged("manualLev");
         }
         _manualLev = param1;
         updatePro();
      }
      
      private function updatePro() : void
      {
         var _loc1_:ManualItemInfo = ExplorerManualManager.instance.getAddProItemInfo(manualLev);
         _curPro.update(_loc1_);
         var _loc2_:ManualItemInfo = ExplorerManualManager.instance.getAddProItemInfo(manualLev + 1);
         if(_loc2_)
         {
            _nextPro.update(_loc2_);
         }
         else
         {
            _nextPro = null;
         }
         onPropertiesChanged("manualPro");
      }
      
      private function initInfo() : void
      {
         _pageAllPro = new PageItemAllProInfo();
         _upgradeCondition = new ManualUpgradeCondition();
         _activePageID = [];
      }
      
      public function clear() : void
      {
         initInfo();
      }
      
      public function refreshData() : void
      {
         onPropertiesChanged("manualrefresh");
      }
   }
}
