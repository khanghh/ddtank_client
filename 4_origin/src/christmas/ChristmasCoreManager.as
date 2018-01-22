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
      
      public function ChristmasCoreManager(param1:PrivateClass)
      {
         _appearPos = [];
         super();
      }
      
      public static function get instance() : ChristmasCoreManager
      {
         if(ChristmasCoreManager._instance == null)
         {
            ChristmasCoreManager._instance = new ChristmasCoreManager(new PrivateClass());
         }
         return ChristmasCoreManager._instance;
      }
      
      public function setup() : void
      {
         _model = new ChristmasModel();
         _self = new SelfInfo();
         SocketManager.Instance.addEventListener("christmas_system",pkgHandler);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new ChrismasEvent("xmas_click_christmas_icon"));
      }
      
      private function showChristmas() : void
      {
         dispatchEvent(new ChrismasEvent("xmas_show",_pkg));
         _pkg = null;
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1.cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 16)
         {
            case 0:
               openOrclose(_loc4_);
               break;
            case 1:
               _pkg = _loc4_;
               this.showChristmas();
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("addplayer_room",_loc4_);
               break;
            case 3:
               _loc3_ = new CrazyTankSocketEvent("christmas_exit",_loc4_);
               break;
            case 4:
               _loc3_ = new CrazyTankSocketEvent("player_statue",_loc4_);
               break;
            case 5:
               _loc3_ = new CrazyTankSocketEvent("christmas_move",_loc4_);
               break;
            case 6:
               _loc3_ = new CrazyTankSocketEvent("christmas_monster",_loc4_);
               break;
            default:
               _loc3_ = new CrazyTankSocketEvent("christmas_monster",_loc4_);
               break;
            case 8:
               makingSnowmanEnter(_loc4_);
               break;
            case 9:
               snowIsUpdata(_loc4_);
               break;
            case 10:
               _loc3_ = new CrazyTankSocketEvent("christmas_packs",_loc4_);
               break;
            case 11:
               _loc3_ = new CrazyTankSocketEvent("getpackstoplayer",_loc4_);
               break;
            case 12:
               _loc3_ = new CrazyTankSocketEvent("christmas_room_speak",_loc4_);
               break;
            default:
               _loc3_ = new CrazyTankSocketEvent("christmas_room_speak",_loc4_);
               break;
            case 14:
               _loc3_ = new CrazyTankSocketEvent("update_times_room",_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      public function setupFightEvent() : void
      {
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
      }
      
      private function __gameStart(param1:CrazyTankSocketEvent) : void
      {
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         dispatchEvent(new ChrismasEvent("xmas_game_start"));
      }
      
      private function buyPlayingSnowmanVolumes(param1:Boolean) : void
      {
         SocketManager.Instance.out.sendBuyPlayingSnowmanVolumes(param1);
      }
      
      public function playingSnowmanEnter() : void
      {
         dispatchEvent(new ChrismasEvent("xmas_playing_snowman"));
      }
      
      public function reConnect() : void
      {
         dispatchEvent(new ChrismasEvent("xmas_reconnect"));
      }
      
      public function reConnectChristmasFunc() : void
      {
         dispatchEvent(new ChrismasEvent("xmas_reconnect_christmas"));
      }
      
      private function reConnectLoadUiComplete() : void
      {
         loadUiModuleComplete = true;
         SocketManager.Instance.out.enterChristmasRoomIsTrue();
      }
      
      private function snowIsUpdata(param1:PackageIn) : void
      {
         var _loc2_:ChristmasSystemItemsInfo = new ChristmasSystemItemsInfo();
         _loc2_.isUp = param1.readBoolean();
         _model.count = param1.readInt();
         _model.exp = param1.readInt();
         _loc2_.num = param1.readInt();
         _loc2_.snowNum = param1.readInt();
         dispatchEvent(new ChrismasEvent("xmas_snow_is_update",_loc2_));
      }
      
      private function makingSnowmanEnter(param1:PackageIn) : void
      {
         _model.count = param1.readInt();
         _model.exp = param1.readInt();
         _model.totalExp = 10;
         _model.awardState = param1.readInt();
         _model.packsNumber = param1.readInt();
         dispatchEvent(new ChrismasEvent("xmas_snowman_enter"));
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _model.isOpen = param1.readBoolean();
         if(_model.isOpen)
         {
            _model.beginTime = param1.readDate();
            _model.endTime = param1.readDate();
            _model.packsLen = param1.readInt();
            _model.snowPackNum = [];
            _loc2_ = new Vector.<ChristmasSystemItemsInfo>();
            _loc4_ = 0;
            while(_loc4_ < _model.packsLen)
            {
               _loc3_ = new ChristmasSystemItemsInfo();
               _loc3_.TemplateID = param1.readInt();
               _loc2_.push(_loc3_);
               _model.snowPackNum[_loc4_] = param1.readInt();
               _loc4_++;
            }
            _model.lastPacks = param1.readInt();
            _model.money = param1.readInt();
            _model.myGiftData = _loc2_;
         }
         if(_model.isOpen)
         {
            showEnterIcon();
         }
         else
         {
            hideEnterIcon();
            if(StateManager.currentStateType == "christmas" || StateManager.currentStateType == "christmasroom")
            {
               StateManager.setState("main");
            }
         }
      }
      
      public function getBagSnowPacksCount() : int
      {
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         var _loc1_:BagInfo = _loc3_.getBag(1);
         var _loc2_:int = _loc1_.getItemCountByTemplateId(201144);
         return _loc2_;
      }
      
      public function showEnterIcon() : void
      {
         _isShowIcon = true;
         HallIconManager.instance.updateSwitchHandler("christmas",true);
         _christmasInfo = new ChristmasSystemItemsInfo();
         _christmasInfo.myPlayerVO = new PlayerVO();
      }
      
      public function get christmasInfo() : ChristmasSystemItemsInfo
      {
         return _christmasInfo;
      }
      
      public function getCount() : int
      {
         var _loc3_:SelfInfo = PlayerManager.Instance.Self;
         var _loc1_:BagInfo = _loc3_.getBag(1);
         var _loc2_:int = _loc1_.getItemCountByTemplateId(201144);
         return _loc2_;
      }
      
      public function checkMoney(param1:int) : Boolean
      {
         _money = param1;
         if(PlayerManager.Instance.Self.Money < param1)
         {
            LeavePageManager.showFillFrame();
            return true;
         }
         return false;
      }
      
      public function hideEnterIcon() : void
      {
         _isShowIcon = false;
         disposeEnterIcon();
      }
      
      public function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("christmas",true);
         dispatchEvent(new ChrismasEvent("xmas_dispose_enter_icon"));
      }
      
      public function returnComponentBnt(param1:BaseButton, param2:String) : Component
      {
         var _loc3_:Component = new Component();
         _loc3_.tipData = param2;
         _loc3_.tipDirctions = "0,1,2";
         _loc3_.tipStyle = "ddt.view.tips.OneLineTip";
         _loc3_.tipGapH = 20;
         _loc3_.width = param1.width;
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         param1.x = 0;
         param1.y = 0;
         _loc3_.addChild(param1);
         return _loc3_;
      }
      
      public function exitGame() : void
      {
         GameInSocketOut.sendGamePlayerExit();
      }
      
      public function CanGetGift(param1:int) : Boolean
      {
         return (ChristmasCoreManager.instance.model.awardState >> param1 & 1) == 0;
      }
      
      public function get model() : ChristmasModel
      {
         return this._model;
      }
      
      public function get mapPath() : String
      {
         return _mapPath;
      }
      
      public function set mapPath(param1:String) : void
      {
         _mapPath = param1;
      }
      
      public function get canMakeSnowMen() : Boolean
      {
         return _canMakeSnowMen;
      }
      
      public function set canMakeSnowMen(param1:Boolean) : void
      {
         _canMakeSnowMen = param1;
      }
      
      public function get christmasIcon() : MovieClip
      {
         return _christmasIcon;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
