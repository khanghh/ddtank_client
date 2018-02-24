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
      
      public function CSMBoxManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : CSMBoxManager{return null;}
      
      public function setup() : void{}
      
      private function showFrame() : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function _getGSMTimeBox(param1:CrazyTankSocketEvent) : void{}
      
      private function __onBoxLoaderComplete(param1:LoaderEvent) : void{}
      
      private function createBoxAndTimer() : void{}
      
      public function showBox(param1:HallStateView = null) : void{}
      
      public function removeBox() : void{}
      
      public function showAwards(param1:int = 0) : void{}
      
      private function __awardsFrameEventHandler(param1:FrameEvent) : void{}
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo{return null;}
      
      private function __sendGetAwards(param1:Event) : void{}
      
      private function __updateBoxTime(param1:TimerEvent) : void{}
      
      private function removeTimer() : void{}
      
      private function removeAwards() : void{}
   }
}
