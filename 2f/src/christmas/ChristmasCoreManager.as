package christmas
{
   import christmas.event.ChrismasEvent;
   import christmas.info.ChristmasSystemItemsInfo;
   import christmas.model.ChristmasModel;
   import christmas.player.PlayerVO;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import ddt.CoreManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import flash.display.MovieClip;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class ChristmasCoreManager extends CoreManager
   {
      
      public static var isTimeOver:Boolean;
      
      private static var _instance:ChristmasCoreManager;
      
      public static var isFrameChristmas:Boolean;
      
      public static var isToRoom:Boolean;
      
      public static var isComeRoom:Boolean;
       
      
      private var _self:SelfInfo;
      
      private var _model:ChristmasModel;
      
      public var _isShowIcon:Boolean = false;
      
      private var _hallStateView:HallStateView;
      
      private var _christmasIcon:MovieClip;
      
      private var _christmasResourceId:String;
      
      private var _currentPVE_ID:int;
      
      private var _mapPath:String;
      
      private var _appearPos:Array;
      
      private var _christmasInfo:ChristmasSystemItemsInfo;
      
      private var _outFun:Function;
      
      private var _money:int;
      
      public var _goods:ShopItemInfo;
      
      private var _canMakeSnowMen:Boolean = true;
      
      public var isReConnect:Boolean = false;
      
      public var loadUiModuleComplete:Boolean = false;
      
      private var _pkg:PackageIn;
      
      public function ChristmasCoreManager(param1:PrivateClass){super();}
      
      public static function get instance() : ChristmasCoreManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      private function showChristmas() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function setupFightEvent() : void{}
      
      private function __gameStart(param1:CrazyTankSocketEvent) : void{}
      
      private function buyPlayingSnowmanVolumes(param1:Boolean) : void{}
      
      public function playingSnowmanEnter() : void{}
      
      public function reConnect() : void{}
      
      public function reConnectChristmasFunc() : void{}
      
      private function reConnectLoadUiComplete() : void{}
      
      private function snowIsUpdata(param1:PackageIn) : void{}
      
      private function makingSnowmanEnter(param1:PackageIn) : void{}
      
      private function openOrclose(param1:PackageIn) : void{}
      
      public function getBagSnowPacksCount() : int{return 0;}
      
      public function showEnterIcon() : void{}
      
      public function get christmasInfo() : ChristmasSystemItemsInfo{return null;}
      
      public function getCount() : int{return 0;}
      
      public function checkMoney(param1:int) : Boolean{return false;}
      
      public function hideEnterIcon() : void{}
      
      public function disposeEnterIcon() : void{}
      
      public function returnComponentBnt(param1:BaseButton, param2:String) : Component{return null;}
      
      public function exitGame() : void{}
      
      public function CanGetGift(param1:int) : Boolean{return false;}
      
      public function get model() : ChristmasModel{return null;}
      
      public function get mapPath() : String{return null;}
      
      public function set mapPath(param1:String) : void{}
      
      public function get canMakeSnowMen() : Boolean{return false;}
      
      public function set canMakeSnowMen(param1:Boolean) : void{}
      
      public function get christmasIcon() : MovieClip{return null;}
   }
}

class PrivateClass
{
    
   
   function PrivateClass(){super();}
}
