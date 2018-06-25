package anotherDimension.controller
{
   import anotherDimension.model.AnotherDimensionInfo;
   import anotherDimension.model.AnotherDimensionMsgInfo;
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import ddt.CoreManager;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class AnotherDimensionManager extends CoreManager
   {
      
      private static var _instance:AnotherDimensionManager;
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const UPDATEVIEW:String = "updateView";
      
      public static const UPDATE_RESOURCEDATA:String = "updateResourceData";
      
      public static const ADDMSG:String = "addMsg";
       
      
      public var resourceList:Array;
      
      public var haveResourceList:Array;
      
      public var gameOver:Boolean;
      
      public var isOpen:Boolean;
      
      public var anotherDimensionInfo:AnotherDimensionInfo;
      
      public var msgArr:Array;
      
      public var showBuyCountFram:Boolean = true;
      
      private var refreshOnly:int;
      
      public function AnotherDimensionManager()
      {
         super();
      }
      
      public static function get Instance() : AnotherDimensionManager
      {
         if(_instance == null)
         {
            _instance = new AnotherDimensionManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("anotherDimension",pkgHandler);
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["anotherDimension"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
               openOrClose(pkg);
               break;
            case 1:
               updateInfo(pkg);
               break;
            case 2:
               openMainView(pkg);
               break;
            case 3:
               updateResource(pkg);
               break;
            default:
               updateResource(pkg);
               break;
            default:
               updateResource(pkg);
               break;
            case 6:
               receiveMsg(pkg);
         }
      }
      
      private function receiveMsg(pkg:PackageIn) : void
      {
         var count:int = 0;
         var i:int = 0;
         var info:* = null;
         var count1:int = 0;
         var j:int = 0;
         var info1:* = null;
         if(msgArr == null)
         {
            msgArr = [];
         }
         var isLogn:Boolean = pkg.readBoolean();
         if(isLogn)
         {
            count = pkg.readInt();
            for(i = 0; i < count; )
            {
               info = new AnotherDimensionMsgInfo();
               info.userID = pkg.readInt();
               info.ownUserID = pkg.readInt();
               info.ownName = pkg.readUTF();
               info.resPos = pkg.readInt();
               info.restatus = pkg.readInt();
               if(msgArr.length < 30)
               {
                  msgArr.push(info);
               }
               i++;
            }
         }
         else
         {
            count1 = pkg.readInt();
            for(j = 0; j < count1; )
            {
               info1 = new AnotherDimensionMsgInfo();
               info1.userID = pkg.readInt();
               info1.ownUserID = pkg.readInt();
               info1.ownName = pkg.readUTF();
               info1.resPos = pkg.readInt();
               info1.restatus = pkg.readInt();
               if(msgArr.length < 30)
               {
                  msgArr.unshift(info1);
               }
               else
               {
                  msgArr.unshift(info1);
                  msgArr.pop();
               }
               j++;
            }
         }
         dispatchEvent(new Event("addMsg"));
      }
      
      private function openMainView(pkg:PackageIn) : void
      {
         var i:int = 0;
         var resourceInfo:* = null;
         var info:* = null;
         var sex:int = 0;
         var j:int = 0;
         var haveResourceInfo:* = null;
         resourceList = [];
         haveResourceList = [];
         gameOver = false;
         var resourceCount:int = pkg.readInt();
         for(i = 0; i < resourceCount; )
         {
            resourceInfo = new AnotherDimensionResourceInfo();
            resourceInfo.isHave = false;
            resourceInfo.resourcePos = pkg.readInt();
            resourceInfo.monsterId = pkg.readInt();
            if(resourceInfo.monsterId == 0)
            {
               info = new PlayerInfo();
               info.ID = pkg.readInt();
               info.NickName = pkg.readUTF();
               sex = pkg.readInt();
               info.Sex = sex == 0?false:true;
               info.Hide = pkg.readInt();
               info.Style = pkg.readUTF();
               info.Colors = pkg.readUTF();
               info.Skin = pkg.readUTF();
               info.Grade = pkg.readInt();
               resourceInfo.resourcePlayerInfo = info;
            }
            else
            {
               pkg.readInt();
               pkg.readUTF();
               pkg.readInt();
               pkg.readInt();
               pkg.readUTF();
               pkg.readUTF();
               pkg.readUTF();
               pkg.readInt();
            }
            pkg.readInt();
            resourceInfo.resourceLevel = pkg.readInt();
            resourceInfo.resourceState = pkg.readInt();
            resourceInfo.haveResourceTime = pkg.readDate();
            resourceInfo.lastMaxMunites = pkg.readInt();
            resourceInfo.itemId = pkg.readInt();
            resourceInfo.itemCountPerHour = pkg.readInt();
            resourceList.push(resourceInfo);
            i++;
         }
         var haveResourceCount:int = pkg.readInt();
         var resourcePosId:int = 3;
         for(j = 0; j < haveResourceCount; )
         {
            haveResourceInfo = new AnotherDimensionResourceInfo();
            resourcePosId++;
            haveResourceInfo.isHave = true;
            haveResourceInfo.resourcePos = resourcePosId;
            haveResourceInfo.resourcePlayerInfo = PlayerManager.Instance.Self;
            haveResourceInfo.resourceLevel = pkg.readInt();
            haveResourceInfo.haveResourceTime = pkg.readDate();
            haveResourceInfo.haveResourceLast = pkg.readInt();
            haveResourceInfo.lastMaxMunites = haveResourceInfo.haveResourceLast;
            haveResourceInfo.itemId = pkg.readInt();
            haveResourceInfo.itemCountPerHour = pkg.readInt();
            haveResourceList.push(haveResourceInfo);
            j++;
         }
         show();
      }
      
      private function updateInfo(pkg:PackageIn) : void
      {
         var flag:Boolean = false;
         anotherDimensionInfo = new AnotherDimensionInfo();
         anotherDimensionInfo.occupyCount = pkg.readInt();
         anotherDimensionInfo.totalOccupyCount = pkg.readInt();
         anotherDimensionInfo.lootCount = pkg.readInt();
         anotherDimensionInfo.totalLootCount = pkg.readInt();
         anotherDimensionInfo.refreshCount = pkg.readInt();
         if(anotherDimensionInfo.refreshCount != refreshOnly)
         {
            flag = true;
         }
         anotherDimensionInfo.timeControlLv = pkg.readInt();
         anotherDimensionInfo.timeControlExp = pkg.readInt();
         anotherDimensionInfo.spaceControlLv = pkg.readInt();
         anotherDimensionInfo.spaceControlExp = pkg.readInt();
         anotherDimensionInfo.looterControlLv = pkg.readInt();
         anotherDimensionInfo.looterControlExp = pkg.readInt();
         refreshOnly = anotherDimensionInfo.refreshCount;
         if(!flag)
         {
            dispatchEvent(new Event("updateView"));
         }
      }
      
      private function openOrClose(pkg:PackageIn) : void
      {
         isOpen = pkg.readBoolean();
      }
      
      private function updateResource(pkg:PackageIn) : void
      {
         var i:int = 0;
         var resourceInfo:* = null;
         var info:* = null;
         var sex:int = 0;
         var j:int = 0;
         var haveResourceInfo:* = null;
         resourceList = [];
         haveResourceList = [];
         var resourceCount:int = pkg.readInt();
         for(i = 0; i < resourceCount; )
         {
            resourceInfo = new AnotherDimensionResourceInfo();
            resourceInfo.isHave = false;
            resourceInfo.resourcePos = pkg.readInt();
            resourceInfo.monsterId = pkg.readInt();
            if(resourceInfo.monsterId == 0)
            {
               info = new PlayerInfo();
               info.ID = pkg.readInt();
               info.NickName = pkg.readUTF();
               sex = pkg.readInt();
               info.Sex = sex == 0?false:true;
               info.Hide = pkg.readInt();
               info.Style = pkg.readUTF();
               info.Colors = pkg.readUTF();
               info.Skin = pkg.readUTF();
               info.Grade = pkg.readInt();
               resourceInfo.resourcePlayerInfo = info;
            }
            else
            {
               pkg.readInt();
               pkg.readUTF();
               pkg.readInt();
               pkg.readInt();
               pkg.readUTF();
               pkg.readUTF();
               pkg.readUTF();
               pkg.readInt();
            }
            pkg.readInt();
            resourceInfo.resourceLevel = pkg.readInt();
            resourceInfo.resourceState = pkg.readInt();
            resourceInfo.haveResourceTime = pkg.readDate();
            resourceInfo.lastMaxMunites = pkg.readInt();
            resourceInfo.itemId = pkg.readInt();
            resourceInfo.itemCountPerHour = pkg.readInt();
            resourceList.push(resourceInfo);
            i++;
         }
         var haveResourceCount:int = pkg.readInt();
         var resourcePosId:int = 3;
         for(j = 0; j < haveResourceCount; )
         {
            haveResourceInfo = new AnotherDimensionResourceInfo();
            resourcePosId++;
            haveResourceInfo.isHave = true;
            haveResourceInfo.resourcePos = resourcePosId;
            haveResourceInfo.resourcePlayerInfo = PlayerManager.Instance.Self;
            haveResourceInfo.resourceLevel = pkg.readInt();
            haveResourceInfo.haveResourceTime = pkg.readDate();
            haveResourceInfo.haveResourceLast = pkg.readInt();
            haveResourceInfo.lastMaxMunites = haveResourceInfo.haveResourceLast;
            haveResourceInfo.itemId = pkg.readInt();
            haveResourceInfo.itemCountPerHour = pkg.readInt();
            haveResourceList.push(haveResourceInfo);
            j++;
         }
         dispatchEvent(new Event("updateResourceData"));
      }
      
      public function checkShowIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 30)
         {
            HallIconManager.instance.updateSwitchHandler("buried",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("buried",true,30);
         }
      }
   }
}
