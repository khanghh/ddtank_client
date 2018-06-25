package ddt.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.TimeBoxInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.loader.LoaderCreate;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.bossbox.AwardsView;
   import ddt.view.bossbox.CSMBoxView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import hall.HallStateView;
   import road7th.data.DictionaryData;
   
   public class CSMBoxManager extends EventDispatcher
   {
      
      private static var _instance:CSMBoxManager;
       
      
      public var CSMBoxList:DictionaryData;
      
      public var isShowBox:Boolean;
      
      private var _GSMBox:CSMBoxView;
      
      private var _awards:AwardsView;
      
      private var _timer:Timer;
      
      private var _currentLevel:int = 1;
      
      private var _currentNum:int;
      
      private var _remainTime:Number;
      
      private var _startTime:Number;
      
      private var _hall:HallStateView;
      
      private var _boxLoader:BaseLoader;
      
      public function CSMBoxManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : CSMBoxManager
      {
         if(_instance == null)
         {
            _instance = new CSMBoxManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("getCSMTimeBox",_getGSMTimeBox);
      }
      
      private function showFrame() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("ddtawardsystem");
      }
      
      private function onUimoduleLoadProgress(event:UIModuleEvent) : void
      {
         if(event.module == "ddtawardsystem")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "ddtawardsystem")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            removeBox();
            if(!_GSMBox)
            {
               _GSMBox = new CSMBoxView();
               PositionUtils.setPos(_GSMBox,"CSMBoxViewPos");
            }
            LayerManager.Instance.addToLayer(_GSMBox,3);
         }
      }
      
      private function _getGSMTimeBox(evt:CrazyTankSocketEvent) : void
      {
         isShowBox = true;
         _currentLevel = evt.pkg.readInt();
         _currentNum = evt.pkg.readInt();
         if(_currentLevel < 9)
         {
            if(CSMBoxList)
            {
               createBoxAndTimer();
            }
            else if(_boxLoader == null)
            {
               _boxLoader = LoaderCreate.Instance.creatUserBoxInfoLoader();
               _boxLoader.addEventListener("complete",__onBoxLoaderComplete);
               LoaderManager.Instance.startLoad(_boxLoader);
            }
         }
      }
      
      private function __onBoxLoaderComplete(evt:LoaderEvent) : void
      {
         BaseLoader(evt.currentTarget).removeEventListener("complete",__onBoxLoaderComplete);
         if(CSMBoxList)
         {
            createBoxAndTimer();
         }
      }
      
      private function createBoxAndTimer() : void
      {
         var tempInfo:TimeBoxInfo = TimeBoxInfo(CSMBoxList[_currentLevel].info);
         _remainTime = tempInfo.Condition * 60 - _currentNum;
         _startTime = getTimer();
         showBox();
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__updateBoxTime);
            _timer.start();
         }
      }
      
      public function showBox($hall:HallStateView = null) : void
      {
         if($hall)
         {
            _hall = $hall;
         }
         if(_hall && isShowBox)
         {
            showFrame();
         }
      }
      
      public function removeBox() : void
      {
         if(_GSMBox)
         {
            ObjectUtils.disposeObject(_GSMBox);
            _GSMBox = null;
         }
      }
      
      public function showAwards(type:int = 0) : void
      {
         var goodListIds:* = null;
         var goodList:* = null;
         var i:int = 0;
         var tempId:int = 0;
         var tempItemList:* = null;
         if(CSMBoxList)
         {
            _awards = ComponentFactory.Instance.creat("bossbox.AwardsViewAsset");
            _awards.addEventListener("_haveBtnClick",__sendGetAwards);
            _awards.addEventListener("response",__awardsFrameEventHandler);
            _awards.boxType = 0;
            goodListIds = CSMBoxList[_currentLevel].goodListIds;
            goodList = [];
            for(i = 0; i < goodListIds.length; )
            {
               tempId = goodListIds[i];
               tempItemList = BossBoxManager.instance.inventoryItemList[tempId];
               goodList = goodList.concat(tempItemList);
               i++;
            }
            _awards.goodsList = goodList;
            if(type == 0)
            {
               _awards.setCheck();
            }
            LayerManager.Instance.addToLayer(_awards,3,true,1);
         }
      }
      
      private function __awardsFrameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            default:
         }
      }
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
      }
      
      private function __sendGetAwards(evt:Event) : void
      {
         SocketManager.Instance.out.sendGetCSMTimeBox();
         removeAwards();
         removeBox();
         removeTimer();
      }
      
      private function __updateBoxTime(evt:TimerEvent) : void
      {
         var tempNum:int = 0;
         var second:int = 0;
         if(_GSMBox)
         {
            tempNum = (getTimer() - _startTime) / 1000;
            if(tempNum < _remainTime)
            {
               second = _remainTime - tempNum;
               _GSMBox.showBox(0);
               _GSMBox.updateTime(second);
            }
            else
            {
               _GSMBox.showBox(1);
            }
         }
      }
      
      private function removeTimer() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__updateBoxTime);
            _timer.stop();
            _timer = null;
         }
      }
      
      private function removeAwards() : void
      {
         if(_awards)
         {
            _awards.removeEventListener("_haveBtnClick",__sendGetAwards);
            _awards.removeEventListener("response",__awardsFrameEventHandler);
            ObjectUtils.disposeObject(_awards);
            _awards = null;
         }
      }
   }
}
