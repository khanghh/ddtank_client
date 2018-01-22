package catchInsect
{
   import catchInsect.event.CatchInsectEvent;
   import catchInsect.event.InsectEvent;
   import ddt.CoreManager;
   import ddt.data.player.SelfInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class CatchInsectManager extends CoreManager
   {
      
      public static const UPDATE_INFO:String = "updateInfo";
      
      public static var isToRoom:Boolean;
      
      private static var _instance:CatchInsectManager;
       
      
      private var _self:SelfInfo;
      
      private var _model:CatchInsectModel;
      
      private var _hallStateView:HallStateView;
      
      private var _catchInsectIcon:MovieClip;
      
      private var _mapPath:String;
      
      private var _appearPos:Array;
      
      private var _catchInsectInfo:CatchInsectItemInfo;
      
      public var isReConnect:Boolean = false;
      
      public var loadUiModuleComplete:Boolean = false;
      
      private var _timer:TimerJuggler;
      
      private var _hasPrompted:DictionaryData;
      
      public var useCakeFlag:Boolean;
      
      private var _funcId:int = 0;
      
      public function CatchInsectManager()
      {
         _appearPos = [];
         super();
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
      }
      
      public static function get instance() : CatchInsectManager
      {
         if(!_instance)
         {
            _instance = new CatchInsectManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new CatchInsectModel();
         _self = new SelfInfo();
         SocketManager.Instance.addEventListener("catchInsect",pkgHandler);
      }
      
      private function pkgHandler(param1:CatchInsectEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1.cmd;
         var _loc3_:CatchInsectEvent = null;
         switch(int(_loc2_) - 128)
         {
            case 0:
               openOrclose(_loc4_);
               break;
            case 1:
               _loc3_ = new CatchInsectEvent("addplayer_room",_loc4_);
               break;
            case 2:
               _loc3_ = new CatchInsectEvent("removePlayer",_loc4_);
               break;
            case 3:
               _loc3_ = new CatchInsectEvent("player_statue",_loc4_);
               break;
            case 4:
               _loc3_ = new CatchInsectEvent("areaSelfInfo",_loc4_);
               break;
            case 5:
               _loc3_ = new CatchInsectEvent("addMonster",_loc4_);
               break;
            case 6:
               _loc3_ = new CatchInsectEvent("cakeStatus",_loc4_);
               break;
            case 7:
               updateScore(_loc4_);
               break;
            case 8:
               _loc3_ = new CatchInsectEvent("updateLocalRank",_loc4_);
               break;
            case 9:
               _loc3_ = new CatchInsectEvent("updateAreaRank",_loc4_);
               break;
            case 10:
               _loc3_ = new CatchInsectEvent("localSelfInfo",_loc4_);
               break;
            case 11:
               _loc3_ = new CatchInsectEvent("fightMonster",_loc4_);
               break;
            default:
               _loc3_ = new CatchInsectEvent("fightMonster",_loc4_);
               break;
            case 13:
               _loc3_ = new CatchInsectEvent("move",_loc4_);
               break;
            default:
               _loc3_ = new CatchInsectEvent("move",_loc4_);
               break;
            case 15:
               enterScene(_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function updateScore(param1:PackageIn) : void
      {
         model.score = param1.readInt();
         model.avaibleScore = param1.readInt();
         model.prizeStatus = param1.readInt();
         dispatchEvent(new Event("updateInfo"));
      }
      
      private function enterScene(param1:PackageIn) : void
      {
         _model.isEnter = param1.readBoolean();
         if(_model.isEnter)
         {
            initSceneData();
         }
         else
         {
            StateManager.setState("main");
         }
      }
      
      public function initSceneData() : void
      {
         _mapPath = getCatchInsectResource() + "/map/CatchInsectMap.swf";
         _catchInsectInfo.playerDefaultPos = new Point(500,500);
         _catchInsectInfo.myPlayerVO.playerPos = _catchInsectInfo.playerDefaultPos;
         _catchInsectInfo.myPlayerVO.playerStauts = 0;
         dispatchEvent(new InsectEvent("catchInsectLoadMap"));
      }
      
      public function getCatchInsectResource() : String
      {
         return PathManager.SITE_MAIN + "image/scene/catchInsect";
      }
      
      public function solveMonsterPath(param1:String) : String
      {
         return getCatchInsectResource() + "/monsters/" + param1 + ".swf";
      }
      
      public function reConnectCatchInectFunc() : void
      {
         isToRoom = true;
         SocketManager.Instance.out.requestCakeStatus();
         if(!loadUiModuleComplete)
         {
            reConnect();
         }
         else
         {
            isReConnect = false;
            StateManager.setState("catchInsect");
         }
      }
      
      public function reConnect() : void
      {
         isReConnect = true;
         _funcId = 2;
         show();
      }
      
      public function reConnectLoadUiComplete() : void
      {
         loadUiModuleComplete = true;
         SocketManager.Instance.out.enterOrLeaveInsectScene(0);
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _model.isOpen = param1.readBoolean();
         showEnterIcon(_model.isOpen);
      }
      
      protected function __timerHandler(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = model.endTime.getTime() / 1000;
         var _loc5_:Date = TimeManager.Instance.Now();
         var _loc4_:int = _loc5_.getTime() / 1000;
         var _loc3_:int = _loc7_ - _loc4_;
         if(_loc3_ > 0)
         {
            _loc6_ = _loc3_ % 3600;
            if(_loc6_ < 5)
            {
               _loc2_ = _loc3_ / 3600;
               if(_loc2_ <= 48 && _loc2_ > 0 && !_hasPrompted.hasKey(_loc2_))
               {
                  ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("catchInsect.willEnd.promptTxt",_loc2_));
                  _hasPrompted.add(_loc2_,1);
               }
            }
         }
      }
      
      public function showEnterIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("catchinsect",param1);
         if(param1)
         {
            _catchInsectInfo = new CatchInsectItemInfo();
            _catchInsectInfo.myPlayerVO = new PlayerVO();
         }
         else if(StateManager.currentStateType == "catchInsect")
         {
            StateManager.setState("main");
         }
      }
      
      public function onClickCatchInsectIcon() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 20)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("catchInsect.Icon.NoEnter",20));
            return;
         }
         _funcId = 1;
         show();
      }
      
      override protected function start() : void
      {
         dispatchEvent(new InsectEvent("catchInsectOpenView",_funcId));
      }
      
      public function get catchInsectInfo() : CatchInsectItemInfo
      {
         return _catchInsectInfo;
      }
      
      public function exitGame() : void
      {
         GameInSocketOut.sendGamePlayerExit();
      }
      
      public function get model() : CatchInsectModel
      {
         return _model;
      }
      
      public function get mapPath() : String
      {
         return _mapPath;
      }
      
      public function get isShowIcon() : Boolean
      {
         return _model.isOpen;
      }
   }
}
