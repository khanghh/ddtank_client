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
      
      public function set proLevMaxProgress(value:int) : void
      {
         _proLevMaxProgress = value;
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
      
      protected function onPropertiesChanged(propName:String = null) : void
      {
         if(_changedPropeties == null)
         {
            return;
         }
         if(_changedPropeties[propName])
         {
            return;
         }
         if(propName != null)
         {
            _changedPropeties[propName] = true;
         }
         invalidate();
      }
      
      public function get debrisInfo() : ManualPageDebrisInfo
      {
         return _debrisInfo;
      }
      
      public function set debrisInfo(value:ManualPageDebrisInfo) : void
      {
         _debrisInfo = value;
         onPropertiesChanged("debrisInfo");
      }
      
      public function get conditionCount() : int
      {
         return _conditionCount;
      }
      
      public function set conditionCount(value:int) : void
      {
         _conditionCount = value;
      }
      
      public function get havePage() : int
      {
         return _havePage;
      }
      
      public function set havePage(value:int) : void
      {
         _havePage = value;
      }
      
      public function get upgradeCondition() : UpgradeConditonBase
      {
         return _upgradeCondition;
      }
      
      public function set upgradeCondition(value:UpgradeConditonBase) : void
      {
         _upgradeCondition = value;
      }
      
      public function get maxProgress() : int
      {
         return _maxProgress;
      }
      
      public function set maxProgress(value:int) : void
      {
         proLevMaxProgress = _maxProgress;
         _maxProgress = value;
         if(proLevMaxProgress == 0)
         {
            proLevMaxProgress = _maxProgress;
         }
      }
      
      public function get activePageID() : Array
      {
         return _activePageID;
      }
      
      public function set activePageID(value:Array) : void
      {
         _activePageID = value;
         onPropertiesChanged("activePageID");
      }
      
      public function chapterProgress(chapterID:int) : String
      {
         var i:int = 0;
         var pageInfo:Array = ExplorerManualManager.instance.getAllPageByChapterID(chapterID);
         var total:int = pageInfo.length;
         var active:int = 0;
         for(i = 0; i < total; )
         {
            if(checkPageActiveByPageID(pageInfo[i].ID))
            {
               active++;
            }
            i++;
         }
         return "<FONT FACE=\'Arial\' SIZE=\'14\' COLOR=\'#FF0000\' ><B>" + active + "</B></FONT>" + "/" + total;
      }
      
      public function checkPageActiveByPageID(pageID:int) : Boolean
      {
         return activePageID.indexOf(pageID) != -1;
      }
      
      public function get pageAllPro() : PageItemAllProInfo
      {
         return _pageAllPro;
      }
      
      public function set pageAllPro(value:PageItemAllProInfo) : void
      {
         _pageAllPro = value;
      }
      
      public function get nextPro() : ManualLevelProInfo
      {
         return _nextPro;
      }
      
      public function set nextPro(value:ManualLevelProInfo) : void
      {
         _nextPro = value;
      }
      
      public function get curPro() : ManualLevelProInfo
      {
         return _curPro;
      }
      
      public function set curPro(value:ManualLevelProInfo) : void
      {
         _curPro = value;
      }
      
      public function get progress() : int
      {
         return _progress;
      }
      
      public function set progress(value:int) : void
      {
         if(_progress == value)
         {
            return;
         }
         _progress = value;
         onPropertiesChanged("progress");
      }
      
      public function get manualLev() : int
      {
         return _manualLev;
      }
      
      public function set manualLev(value:int) : void
      {
         if(_manualLev == value)
         {
            return;
         }
         if(_manualLev != -1)
         {
            onPropertiesChanged("manualLev");
         }
         _manualLev = value;
         updatePro();
      }
      
      private function updatePro() : void
      {
         var curProInfo:ManualItemInfo = ExplorerManualManager.instance.getAddProItemInfo(manualLev);
         _curPro.update(curProInfo);
         var NextProInfo:ManualItemInfo = ExplorerManualManager.instance.getAddProItemInfo(manualLev + 1);
         if(NextProInfo)
         {
            _nextPro.update(NextProInfo);
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
