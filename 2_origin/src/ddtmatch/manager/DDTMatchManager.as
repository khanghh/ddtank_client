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
      
      public function questionInfo(analyer:LanternDataAnalyzer) : void
      {
         _questionInfo = analyer.ddtMatchData;
      }
      
      public function get info() : Object
      {
         return _questionInfo;
      }
      
      private function __onExpertHandler(e:CrazyTankSocketEvent) : void
      {
         if(!ServerConfigManager.instance.getLightRiddleIsNew)
         {
            return;
         }
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 37)
         {
            case 0:
               expertIsBegin = pkg.readBoolean();
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
               event = new CrazyTankSocketEvent("lanternRiddles_question",pkg);
               break;
            case 2:
               event = new CrazyTankSocketEvent("lanternRiddles_answer",pkg);
               break;
            default:
               event = new CrazyTankSocketEvent("lanternRiddles_answer",pkg);
               break;
            case 4:
               event = new CrazyTankSocketEvent("lanternRiddles_skill",pkg);
               break;
            case 5:
               event = new CrazyTankSocketEvent("lanternRiddles_rankinfo",pkg);
               break;
            case 6:
               onBeginTips(pkg);
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      private function __onRedpackettHandler(e:CrazyTankSocketEvent) : void
      {
         var bol:Boolean = false;
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 1)
         {
            case 0:
               redPacketIsBegin = pkg.readBoolean();
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
               event = new CrazyTankSocketEvent("updataRedPacketList",pkg);
               break;
            case 2:
               break;
            case 3:
               event = new CrazyTankSocketEvent("redpacketRecord",pkg);
               break;
            case 4:
               bol = pkg.readBoolean();
               if(!bol)
               {
                  SocketManager.Instance.out.getRedPacketInfo();
               }
               break;
            default:
               bol = pkg.readBoolean();
               if(!bol)
               {
                  SocketManager.Instance.out.getRedPacketInfo();
               }
               break;
            case 6:
               model.myRedPacketCount = pkg.readInt();
               model.myRedPacketMoney = pkg.readInt();
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      private function __onMatchMessageHandler(e:CrazyTankSocketEvent) : void
      {
         var bol:Boolean = false;
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 1)
         {
            case 0:
               matchIsBegin = pkg.readBoolean();
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
               event = new CrazyTankSocketEvent("matchInfo",pkg);
               break;
            case 2:
               bol = pkg.readBoolean();
               if(bol)
               {
                  SocketManager.Instance.out.getBuyinfo();
                  break;
               }
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      private function __onfightKingHandler(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         var event:CrazyTankSocketEvent = null;
         switch(int(cmd) - 1)
         {
            case 0:
               fightKingIsBegin = pkg.readBoolean();
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
               event = new CrazyTankSocketEvent("fightKing",pkg);
         }
         if(event)
         {
            dispatchEvent(event);
         }
      }
      
      public function templateDataSetup(dataList:Array) : void
      {
         var i:int = 0;
         var info:* = null;
         var bol:Boolean = false;
         var j:int = 0;
         itemInfoList = dataList;
         list = [];
         for(i = 0; i < itemInfoList.length; )
         {
            info = itemInfoList[i];
            bol = false;
            for(j = 0; j < list.length; )
            {
               if(list[j].split(":")[0] == info.Quality.toString())
               {
                  bol = true;
                  list[j] = list[j] + "|" + info.TemplateID.toString() + "," + info.Count.toString();
                  break;
               }
               j++;
            }
            if(!bol)
            {
               list.push(info.Quality.toString() + ":" + info.TemplateID.toString() + "," + info.Count.toString());
            }
            i++;
         }
      }
      
      private function onBeginTips(pkg:PackageIn) : void
      {
         var minite:int = pkg.readInt();
         if(StateManager.currentStateType != "fighting")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.beginTipsText",minite));
         }
         var data:ChatData = new ChatData();
         data.channel = 14;
         data.msg = LanguageMgr.GetTranslation("ddt.DDTMatch.expertView.beginTipsText",minite);
         ChatManager.Instance.chat(data);
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
