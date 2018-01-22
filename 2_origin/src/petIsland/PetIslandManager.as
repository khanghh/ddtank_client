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
      
      private function initHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = param1._cmd;
         switch(int(_loc3_) - 186)
         {
            case 0:
               model.isOpen = param1.pkg.readBoolean();
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
               _loc6_ = param1.pkg.readInt();
               model.openType = param1.pkg.readInt();
               model.playerBlood = param1.pkg.readInt();
               model.currentLevel = param1.pkg.readInt();
               model.round = param1.pkg.readInt();
               model.step = param1.pkg.readInt();
               model.playerScore = param1.pkg.readInt();
               model.npcBlood = param1.pkg.readInt();
               model.npcScore = param1.pkg.readInt();
               model.rewardRecord = param1.pkg.readUTF();
               model.saveLifeCount = param1.pkg.readInt();
               model.saveLife2Count = param1.pkg.readInt();
               if(_loc6_ == 1)
               {
                  show();
               }
               else if(_loc6_ == 2)
               {
                  dispatchEvent(new PetIslandEvent("refresh"));
               }
               break;
            case 2:
               _loc2_ = param1.pkg.readInt();
               if(_loc2_ == 1)
               {
                  model.saveLifeCount = param1.pkg.readInt();
               }
               else if(_loc2_ == 2)
               {
                  model.saveLife2Count = param1.pkg.readInt();
               }
               dispatchEvent(new PetIslandEvent("saveLifeCount",_loc2_));
               break;
            default:
               _loc2_ = param1.pkg.readInt();
               if(_loc2_ == 1)
               {
                  model.saveLifeCount = param1.pkg.readInt();
               }
               else if(_loc2_ == 2)
               {
                  model.saveLife2Count = param1.pkg.readInt();
               }
               dispatchEvent(new PetIslandEvent("saveLifeCount",_loc2_));
               break;
            case 4:
               model.rewardRecord = param1.pkg.readUTF();
               break;
            case 5:
               _loc4_ = param1.pkg.readBoolean();
               dispatchEvent(new PetIslandEvent("stepChange",_loc4_));
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
