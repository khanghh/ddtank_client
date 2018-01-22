package christmas
{
   import baglocked.BaglockedManager;
   import christmas.controller.ChristmasRoomController;
   import christmas.event.ChrismasEvent;
   import christmas.event.ChristmasRoomEvent;
   import christmas.info.ChristmasSystemItemsInfo;
   import christmas.items.ExpBar;
   import christmas.loader.LoaderChristmasUIModule;
   import christmas.manager.ChristmasMonsterManager;
   import christmas.model.ChristmasModel;
   import christmas.view.ChristmasChooseRoomFrame;
   import christmas.view.makingSnowmenView.ChristmasMakingSnowmenFrame;
   import christmas.view.makingSnowmenView.SnowPackDoubleFrame;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import hall.HallStateView;
   import road7th.comm.PackageIn;
   
   public class ChristmasCoreController extends EventDispatcher
   {
      
      private static var _instance:ChristmasCoreController;
      
      public static var isToRoom:Boolean;
      
      public static var isFrameChristmas:Boolean;
       
      
      private var _model:ChristmasModel;
      
      private var _hallStateView:HallStateView;
      
      private var _makingSnoFrame:ChristmasMakingSnowmenFrame;
      
      private var _appearPos:Array;
      
      private var _snowPackDoubleFrame:SnowPackDoubleFrame;
      
      private var _outFun:Function;
      
      public var isReConnect:Boolean = false;
      
      public var loadUiModuleComplete:Boolean = false;
      
      private var _manager:ChristmasCoreManager;
      
      private var _chooseRoomFrame:ChristmasChooseRoomFrame;
      
      public function ChristmasCoreController(param1:PrivateClass){super();}
      
      public static function get instance() : ChristmasCoreController{return null;}
      
      public function setup() : void{}
      
      private function addEvents() : void{}
      
      private function onEvent(param1:ChrismasEvent) : void{}
      
      private function enterChristmasGame(param1:PackageIn) : void{}
      
      protected function __alertBuyTime(param1:FrameEvent) : void{}
      
      private function _response(param1:FrameEvent) : void{}
      
      private function onResponseHander(param1:FrameEvent) : void{}
      
      private function buyPlayingSnowmanVolumes(param1:Boolean) : void{}
      
      public function playingSnowmanEnter() : void{}
      
      public function reConnectChristmasFunc() : void{}
      
      public function reConnect() : void{}
      
      private function reConnectLoadUiComplete() : void{}
      
      private function snowIsUpdata(param1:ChristmasSystemItemsInfo) : void{}
      
      private function makingSnowmanEnter() : void{}
      
      public function getBagSnowPacksCount() : int{return 0;}
      
      public function _onClickChristmasIcon() : void{}
      
      private function doOpenChristmasFrame() : void{}
      
      public function get makingSnowmenFrame() : ChristmasMakingSnowmenFrame{return null;}
      
      public function get expBar() : ExpBar{return null;}
      
      public function get christmasInfo() : ChristmasSystemItemsInfo{return null;}
      
      public function getCount() : int{return 0;}
      
      public function showTransactionFrame(param1:String, param2:Function = null, param3:Function = null, param4:Sprite = null, param5:Boolean = true, param6:Boolean = false, param7:int = 0) : void{}
      
      public function checkMoney(param1:Boolean) : Boolean{return false;}
      
      public function disposeEnterIcon() : void{}
      
      public function returnComponentBnt(param1:BaseButton, param2:String) : Component{return null;}
      
      public function exitGame() : void{}
      
      public function CanGetGift(param1:int) : Boolean{return false;}
      
      public function get model() : ChristmasModel{return null;}
      
      public function get mapPath() : String{return null;}
      
      public function get canMakeSnowMen() : Boolean{return false;}
      
      public function set canMakeSnowMen(param1:Boolean) : void{}
      
      public function get christmasIcon() : MovieClip{return null;}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
