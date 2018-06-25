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
      
      private function pkgHandler(e:CatchInsectEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e.cmd;
         var event:CatchInsectEvent = null;
         switch(int(cmd) - 128)
         {
            case 0:
               openOrclose(pkg);
               break;
            case 1:
               event = new CatchInsectEvent("addplayer_room",pkg);
               break;
            case 2:
               event = new CatchInsectEvent("removePlayer",pkg);
               break;
            case 3:
               event = new CatchInsectEvent("player_statue",pkg);
               break;
            case 4:
               event = new CatchInsectEvent("areaSelfInfo",pkg);
               break;
            case 5:
               event = new CatchInsectEvent("addMonster",pkg);
               break;
            case 6:
               event = new CatchInsectEvent("cakeStatus",pkg);
               break;
            case 7:
               updateScore(pkg);
               break;
            case 8:
               event = new CatchInsectEvent("updateLocalRank",pkg);
               break;
            case 9:
               event = new CatchInsectEvent("updateAreaRank",pkg);
               break;
            case 10:
               event = new CatchInsectEvent("localSelfInfo",pkg);
               break;
            case 11:
               event = new CatchInsectEvent("fightMonster",pkg);
               break;
            default:
               event = new CatchInsectEvent("fightMonster",pkg);
               break;
            case 13:
               event = new CatchInsectEvent("move",pkg);
               break;
            default:
               event = new CatchInsectEvent("move",pkg);
               break;
            case 15:
               enterScene(pkg);
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      private function updateScore(pkg:PackageIn) : void
      {
         model.score = pkg.readInt();
         model.avaibleScore = pkg.readInt();
         model.prizeStatus = pkg.readInt();
         dispatchEvent(new Event("updateInfo"));
      }
      
      private function enterScene(pkg:PackageIn) : void
      {
         _model.isEnter = pkg.readBoolean();
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
      
      public function solveMonsterPath(pPath:String) : String
      {
         return getCatchInsectResource() + "/monsters/" + pPath + ".swf";
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
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _model.isOpen = pkg.readBoolean();
         showEnterIcon(_model.isOpen);
      }
      
      protected function __timerHandler(event:Event) : void
      {
         var residue:int = 0;
         var onTime:int = 0;
         var endTime:int = model.endTime.getTime() / 1000;
         var now:Date = TimeManager.Instance.Now();
         var nowTimeSec:int = now.getTime() / 1000;
         var diff:int = endTime - nowTimeSec;
         if(diff > 0)
         {
            residue = diff % 3600;
            if(residue < 5)
            {
               onTime = diff / 3600;
               if(onTime <= 48 && onTime > 0 && !_hasPrompted.hasKey(onTime))
               {
                  ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("catchInsect.willEnd.promptTxt",onTime));
                  _hasPrompted.add(onTime,1);
               }
            }
         }
      }
      
      public function showEnterIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("catchinsect",flag);
         if(flag)
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
