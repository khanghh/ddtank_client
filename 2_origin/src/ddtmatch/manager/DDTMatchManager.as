package ddtmatch.manager
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.chat.ChatData;
   import ddtmatch.data.DDTMatchFightKingInfo;
   import ddtmatch.event.DDTMatchEvent;
   import ddtmatch.model.DDTMatchModel;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import lanternriddles.analyzer.LanternDataAnalyzer;
   import road7th.comm.PackageIn;
   
   public class DDTMatchManager extends CoreManager
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      private static var _instance:DDTMatchManager;
      
      public static var outsideRedPacket:Boolean = false;
       
      
      public var model:DDTMatchModel;
      
      public var currentViewType:int;
      
      public var expertIsBegin:Boolean;
      
      private var _questionInfo:Object;
      
      public var redPacketIsBegin:Boolean;
      
      public var matchIsBegin:Boolean;
      
      public var fightKingIsBegin:Boolean;
      
      private var itemInfoList:Array;
      
      public var list:Array;
      
      public function DDTMatchManager()
      {
         super();
      }
      
      public static function get instance() : DDTMatchManager
      {
         if(!_instance)
         {
            _instance = new DDTMatchManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         model = new DDTMatchModel();
         SocketManager.Instance.addEventListener("lanternRiddles_begin",__onExpertHandler);
         SocketManager.Instance.addEventListener("redpacket",__onRedpackettHandler);
         SocketManager.Instance.addEventListener("matchMessage",__onMatchMessageHandler);
         SocketManager.Instance.addEventListener("fightKing",__onfightKingHandler);
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["ddtmatch"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      public function questionInfo(param1:LanternDataAnalyzer) : void
      {
         _questionInfo = param1.ddtMatchData;
      }
      
      public function get info() : Object
      {
         return _questionInfo;
      }
      
      private function __onExpertHandler(param1:CrazyTankSocketEvent) : void
      {
         if(!ServerConfigManager.instance.getLightRiddleIsNew)
         {
            return;
         }
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 37)
         {
            case 0:
               expertIsBegin = _loc4_.readBoolean();
               if(expertIsBegin)
               {
                  DDTMatchManager.instance.showEnterIcon();
               }
               else if(!redPacketIsBegin && !matchIsBegin && !fightKingIsBegin)
               {
                  hideEnterIcon();
               }
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_question",_loc4_);
               break;
            case 2:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_answer",_loc4_);
               break;
            default:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_answer",_loc4_);
               break;
            case 4:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_skill",_loc4_);
               break;
            case 5:
               _loc3_ = new CrazyTankSocketEvent("lanternRiddles_rankinfo",_loc4_);
               break;
            case 6:
               onBeginTips(_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function __onRedpackettHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 1)
         {
            case 0:
               redPacketIsBegin = _loc5_.readBoolean();
               if(redPacketIsBegin)
               {
                  DDTMatchManager.instance.showEnterIcon();
               }
               else if(!expertIsBegin && !matchIsBegin && !fightKingIsBegin)
               {
                  hideEnterIcon();
               }
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("updataRedPacketList",_loc5_);
               break;
            case 2:
               break;
            case 3:
               _loc3_ = new CrazyTankSocketEvent("redpacketRecord",_loc5_);
               break;
            case 4:
               _loc4_ = _loc5_.readBoolean();
               if(!_loc4_)
               {
                  SocketManager.Instance.out.getRedPacketInfo();
               }
               break;
            default:
               _loc4_ = _loc5_.readBoolean();
               if(!_loc4_)
               {
                  SocketManager.Instance.out.getRedPacketInfo();
               }
               break;
            case 6:
               model.myRedPacketCount = _loc5_.readInt();
               model.myRedPacketMoney = _loc5_.readInt();
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function __onMatchMessageHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 1)
         {
            case 0:
               matchIsBegin = _loc5_.readBoolean();
               if(matchIsBegin)
               {
                  DDTMatchManager.instance.showEnterIcon();
               }
               else if(!expertIsBegin && !redPacketIsBegin && !fightKingIsBegin)
               {
                  hideEnterIcon();
               }
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("matchInfo",_loc5_);
               break;
            case 2:
               _loc4_ = _loc5_.readBoolean();
               if(_loc4_)
               {
                  SocketManager.Instance.out.getBuyinfo();
                  break;
               }
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      private function __onfightKingHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:CrazyTankSocketEvent = null;
         switch(int(_loc2_) - 1)
         {
            case 0:
               fightKingIsBegin = _loc4_.readBoolean();
               if(fightKingIsBegin)
               {
                  DDTMatchManager.instance.showEnterIcon();
               }
               else if(!expertIsBegin && !redPacketIsBegin && !matchIsBegin)
               {
                  hideEnterIcon();
               }
               break;
            case 1:
               _loc3_ = new CrazyTankSocketEvent("fightKing",_loc4_);
         }
         if(_loc3_)
         {
            dispatchEvent(_loc3_);
         }
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         itemInfoList = param1;
         list = [];
         _loc5_ = 0;
         while(_loc5_ < itemInfoList.length)
         {
            _loc4_ = itemInfoList[_loc5_];
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < list.length)
            {
               if(list[_loc3_].split(":")[0] == _loc4_.Quality.toString())
               {
                  _loc2_ = true;
                  list[_loc3_] = list[_loc3_] + "|" + _loc4_.TemplateID.toString() + "," + _loc4_.Count.toString();
                  break;
               }
               _loc3_++;
            }
            if(!_loc2_)
            {
               list.push(_loc4_.Quality.toString() + ":" + _loc4_.TemplateID.toString() + "," + _loc4_.Count.toString());
            }
            _loc5_++;
         }
      }
      
      private function onBeginTips(param1:PackageIn) : void
      {
         var _loc3_:int = param1.readInt();
         if(StateManager.currentStateType != "fighting")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.beginTipsText",_loc3_));
         }
         var _loc2_:ChatData = new ChatData();
         _loc2_.channel = 14;
         _loc2_.msg = LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.beginTipsText",_loc3_);
         ChatManager.Instance.chat(_loc2_);
      }
      
      public function showEnterIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 15)
         {
            HallIconManager.instance.updateSwitchHandler("ddtMatch",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("ddtMatch",true,15);
         }
      }
      
      public function hideEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("ddtMatch",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("ddtMatch",false);
         dispatchEvent(new DDTMatchEvent("checkViewClose"));
      }
   }
}
