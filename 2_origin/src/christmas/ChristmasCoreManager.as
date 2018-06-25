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
      
      public function ChristmasCoreManager(pct:PrivateClass)
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
      
      private function pkgHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e.cmd;
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 16)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               _pkg = pkg;
               this.showChristmas();
               break;
            case 2:
               event = new CrazyTankSocketEvent("addplayer_room",pkg);
               break;
            case 3:
               event = new CrazyTankSocketEvent("christmas_exit",pkg);
               break;
            case 4:
               event = new CrazyTankSocketEvent("player_statue",pkg);
               break;
            case 5:
               event = new CrazyTankSocketEvent("christmas_move",pkg);
               break;
            case 6:
               event = new CrazyTankSocketEvent("christmas_monster",pkg);
               break;
            default:
               event = new CrazyTankSocketEvent("christmas_monster",pkg);
               break;
            case 8:
               makingSnowmanEnter(pkg);
               break;
            case 9:
               snowIsUpdata(pkg);
               break;
            case 10:
               event = new CrazyTankSocketEvent("christmas_packs",pkg);
               break;
            case 11:
               event = new CrazyTankSocketEvent("getpackstoplayer",pkg);
               break;
            case 12:
               event = new CrazyTankSocketEvent("christmas_room_speak",pkg);
               break;
            default:
               event = new CrazyTankSocketEvent("christmas_room_speak",pkg);
               break;
            case 14:
               event = new CrazyTankSocketEvent("update_times_room",pkg);
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      public function setupFightEvent() : void
      {
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         RoomManager.Instance.addEventListener("gameRoomCreate",__gameStart);
      }
      
      private function __gameStart(pEvent:CrazyTankSocketEvent) : void
      {
         RoomManager.Instance.removeEventListener("gameRoomCreate",__gameStart);
         dispatchEvent(new ChrismasEvent("xmas_game_start"));
      }
      
      private function buyPlayingSnowmanVolumes(isBand:Boolean) : void
      {
         SocketManager.Instance.out.sendBuyPlayingSnowmanVolumes(isBand);
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
      
      private function snowIsUpdata(pkg:PackageIn) : void
      {
         var curSnowmenUpInfo:ChristmasSystemItemsInfo = new ChristmasSystemItemsInfo();
         curSnowmenUpInfo.isUp = pkg.readBoolean();
         _model.count = pkg.readInt();
         _model.exp = pkg.readInt();
         curSnowmenUpInfo.num = pkg.readInt();
         curSnowmenUpInfo.snowNum = pkg.readInt();
         dispatchEvent(new ChrismasEvent("xmas_snow_is_update",curSnowmenUpInfo));
      }
      
      private function makingSnowmanEnter(pkg:PackageIn) : void
      {
         _model.count = pkg.readInt();
         _model.exp = pkg.readInt();
         _model.totalExp = 10;
         _model.awardState = pkg.readInt();
         _model.packsNumber = pkg.readInt();
         dispatchEvent(new ChrismasEvent("xmas_snowman_enter"));
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         var list:* = undefined;
         var i:int = 0;
         var cellInfo:* = null;
         _model.isOpen = pkg.readBoolean();
         if(_model.isOpen)
         {
            _model.beginTime = pkg.readDate();
            _model.endTime = pkg.readDate();
            _model.packsLen = pkg.readInt();
            _model.snowPackNum = [];
            list = new Vector.<ChristmasSystemItemsInfo>();
            for(i = 0; i < _model.packsLen; )
            {
               cellInfo = new ChristmasSystemItemsInfo();
               cellInfo.TemplateID = pkg.readInt();
               list.push(cellInfo);
               _model.snowPackNum[i] = pkg.readInt();
               i++;
            }
            _model.lastPacks = pkg.readInt();
            _model.money = pkg.readInt();
            _model.myGiftData = list;
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
         var _selfInfo:SelfInfo = PlayerManager.Instance.Self;
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(201144);
         return conut;
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
         var _selfInfo:SelfInfo = PlayerManager.Instance.Self;
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(201144);
         return conut;
      }
      
      public function checkMoney(money:int) : Boolean
      {
         _money = money;
         if(PlayerManager.Instance.Self.Money < money)
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
      
      public function returnComponentBnt(bnt:BaseButton, tipName:String) : Component
      {
         var compoent:Component = new Component();
         compoent.tipData = tipName;
         compoent.tipDirctions = "0,1,2";
         compoent.tipStyle = "ddt.view.tips.OneLineTip";
         compoent.tipGapH = 20;
         compoent.width = bnt.width;
         compoent.x = bnt.x;
         compoent.y = bnt.y;
         bnt.x = 0;
         bnt.y = 0;
         compoent.addChild(bnt);
         return compoent;
      }
      
      public function exitGame() : void
      {
         GameInSocketOut.sendGamePlayerExit();
      }
      
      public function CanGetGift(step:int) : Boolean
      {
         return (ChristmasCoreManager.instance.model.awardState >> step & 1) == 0;
      }
      
      public function get model() : ChristmasModel
      {
         return this._model;
      }
      
      public function get mapPath() : String
      {
         return _mapPath;
      }
      
      public function set mapPath(value:String) : void
      {
         _mapPath = value;
      }
      
      public function get canMakeSnowMen() : Boolean
      {
         return _canMakeSnowMen;
      }
      
      public function set canMakeSnowMen(value:Boolean) : void
      {
         _canMakeSnowMen = value;
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
