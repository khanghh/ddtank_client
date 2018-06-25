package petIsland
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import petIsland.event.PetIslandEvent;
   import petIsland.model.PetIslandModel;
   import road7th.comm.PackageIn;
   
   public class PetIslandManager extends CoreManager
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      private static var _instance:PetIslandManager;
       
      
      public var model:PetIslandModel;
      
      private var type:int;
      
      public function PetIslandManager()
      {
         super();
      }
      
      public static function get instance() : PetIslandManager
      {
         if(!_instance)
         {
            _instance = new PetIslandManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         model = new PetIslandModel();
         SocketManager.Instance.addEventListener("petIslandInit",initHandler);
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["petIsland"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      private function initHandler(e:CrazyTankSocketEvent) : void
      {
         var type:int = 0;
         var buyType:int = 0;
         var flag:Boolean = false;
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         switch(int(cmd) - 186)
         {
            case 0:
               model.isOpen = e.pkg.readBoolean();
               if(model.isOpen)
               {
                  showEnterIcon();
               }
               else
               {
                  hideEnterIcon();
                  if(StateManager.currentStateType == "petIsland")
                  {
                     StateManager.setState("main");
                  }
               }
               break;
            case 1:
               type = e.pkg.readInt();
               model.openType = e.pkg.readInt();
               model.playerBlood = e.pkg.readInt();
               model.currentLevel = e.pkg.readInt();
               model.round = e.pkg.readInt();
               model.step = e.pkg.readInt();
               model.playerScore = e.pkg.readInt();
               model.npcBlood = e.pkg.readInt();
               model.npcScore = e.pkg.readInt();
               model.rewardRecord = e.pkg.readUTF();
               model.saveLifeCount = e.pkg.readInt();
               model.saveLife2Count = e.pkg.readInt();
               if(type == 1)
               {
                  show();
               }
               else if(type == 2)
               {
                  dispatchEvent(new PetIslandEvent("refresh"));
               }
               break;
            case 2:
               buyType = e.pkg.readInt();
               if(buyType == 1)
               {
                  model.saveLifeCount = e.pkg.readInt();
               }
               else if(buyType == 2)
               {
                  model.saveLife2Count = e.pkg.readInt();
               }
               dispatchEvent(new PetIslandEvent("saveLifeCount",buyType));
               break;
            default:
               buyType = e.pkg.readInt();
               if(buyType == 1)
               {
                  model.saveLifeCount = e.pkg.readInt();
               }
               else if(buyType == 2)
               {
                  model.saveLife2Count = e.pkg.readInt();
               }
               dispatchEvent(new PetIslandEvent("saveLifeCount",buyType));
               break;
            case 4:
               model.rewardRecord = e.pkg.readUTF();
               break;
            case 5:
               flag = e.pkg.readBoolean();
               dispatchEvent(new PetIslandEvent("stepChange",flag));
         }
      }
      
      public function showEnterIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= ServerConfigManager.instance.petDisappearMinLevel)
         {
            HallIconManager.instance.updateSwitchHandler("petIsland",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("petIsland",true,25);
         }
      }
      
      public function hideEnterIcon() : void
      {
         PetIslandManager.instance.model.infoStr = "";
         HallIconManager.instance.updateSwitchHandler("petIsland",false);
         HallIconManager.instance.executeCacheRightIconLevelLimit("petIsland",false);
      }
   }
}
