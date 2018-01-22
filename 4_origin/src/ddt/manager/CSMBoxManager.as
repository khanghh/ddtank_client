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
      
      public function CSMBoxManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtawardsystem")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtawardsystem")
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
      
      private function _getGSMTimeBox(param1:CrazyTankSocketEvent) : void
      {
         isShowBox = true;
         _currentLevel = param1.pkg.readInt();
         _currentNum = param1.pkg.readInt();
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
      
      private function __onBoxLoaderComplete(param1:LoaderEvent) : void
      {
         BaseLoader(param1.currentTarget).removeEventListener("complete",__onBoxLoaderComplete);
         if(CSMBoxList)
         {
            createBoxAndTimer();
         }
      }
      
      private function createBoxAndTimer() : void
      {
         var _loc1_:TimeBoxInfo = TimeBoxInfo(CSMBoxList[_currentLevel].info);
         _remainTime = _loc1_.Condition * 60 - _currentNum;
         _startTime = getTimer();
         showBox();
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__updateBoxTime);
            _timer.start();
         }
      }
      
      public function showBox(param1:HallStateView = null) : void
      {
         if(param1)
         {
            _hall = param1;
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
      
      public function showAwards(param1:int = 0) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(CSMBoxList)
         {
            _awards = ComponentFactory.Instance.creat("bossbox.AwardsViewAsset");
            _awards.addEventListener("_haveBtnClick",__sendGetAwards);
            _awards.addEventListener("response",__awardsFrameEventHandler);
            _awards.boxType = 0;
            _loc3_ = CSMBoxList[_currentLevel].goodListIds;
            _loc2_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc4_ = _loc3_[_loc6_];
               _loc5_ = BossBoxManager.instance.inventoryItemList[_loc4_];
               _loc2_ = _loc2_.concat(_loc5_);
               _loc6_++;
            }
            _awards.goodsList = _loc2_;
            if(param1 == 0)
            {
               _awards.setCheck();
            }
            LayerManager.Instance.addToLayer(_awards,3,true,1);
         }
      }
      
      private function __awardsFrameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            default:
         }
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      private function __sendGetAwards(param1:Event) : void
      {
         SocketManager.Instance.out.sendGetCSMTimeBox();
         removeAwards();
         removeBox();
         removeTimer();
      }
      
      private function __updateBoxTime(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_GSMBox)
         {
            _loc3_ = (getTimer() - _startTime) / 1000;
            if(_loc3_ < _remainTime)
            {
               _loc2_ = _remainTime - _loc3_;
               _GSMBox.showBox(0);
               _GSMBox.updateTime(_loc2_);
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
