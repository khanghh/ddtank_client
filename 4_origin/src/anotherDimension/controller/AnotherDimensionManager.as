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
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
               openOrClose(_loc3_);
               break;
            case 1:
               updateInfo(_loc3_);
               break;
            case 2:
               openMainView(_loc3_);
               break;
            case 3:
               updateResource(_loc3_);
               break;
            default:
               updateResource(_loc3_);
               break;
            default:
               updateResource(_loc3_);
               break;
            case 6:
               receiveMsg(_loc3_);
         }
      }
      
      private function receiveMsg(param1:PackageIn) : void
      {
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         if(msgArr == null)
         {
            msgArr = [];
         }
         var _loc3_:Boolean = param1.readBoolean();
         if(_loc3_)
         {
            _loc2_ = param1.readInt();
            _loc8_ = 0;
            while(_loc8_ < _loc2_)
            {
               _loc7_ = new AnotherDimensionMsgInfo();
               _loc7_.userID = param1.readInt();
               _loc7_.ownUserID = param1.readInt();
               _loc7_.ownName = param1.readUTF();
               _loc7_.resPos = param1.readInt();
               _loc7_.restatus = param1.readInt();
               if(msgArr.length < 30)
               {
                  msgArr.push(_loc7_);
               }
               _loc8_++;
            }
         }
         else
         {
            _loc5_ = param1.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = new AnotherDimensionMsgInfo();
               _loc4_.userID = param1.readInt();
               _loc4_.ownUserID = param1.readInt();
               _loc4_.ownName = param1.readUTF();
               _loc4_.resPos = param1.readInt();
               _loc4_.restatus = param1.readInt();
               if(msgArr.length < 30)
               {
                  msgArr.unshift(_loc4_);
               }
               else
               {
                  msgArr.unshift(_loc4_);
                  msgArr.pop();
               }
               _loc6_++;
            }
         }
         dispatchEvent(new Event("addMsg"));
      }
      
      private function openMainView(param1:PackageIn) : void
      {
         var _loc10_:int = 0;
         var _loc4_:* = null;
         var _loc9_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         resourceList = [];
         haveResourceList = [];
         gameOver = false;
         var _loc2_:int = param1.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            _loc4_ = new AnotherDimensionResourceInfo();
            _loc4_.isHave = false;
            _loc4_.resourcePos = param1.readInt();
            _loc4_.monsterId = param1.readInt();
            if(_loc4_.monsterId == 0)
            {
               _loc9_ = new PlayerInfo();
               _loc9_.ID = param1.readInt();
               _loc9_.NickName = param1.readUTF();
               _loc3_ = param1.readInt();
               _loc9_.Sex = _loc3_ == 0?false:true;
               _loc9_.Hide = param1.readInt();
               _loc9_.Style = param1.readUTF();
               _loc9_.Colors = param1.readUTF();
               _loc9_.Skin = param1.readUTF();
               _loc9_.Grade = param1.readInt();
               _loc4_.resourcePlayerInfo = _loc9_;
            }
            else
            {
               param1.readInt();
               param1.readUTF();
               param1.readInt();
               param1.readInt();
               param1.readUTF();
               param1.readUTF();
               param1.readUTF();
               param1.readInt();
            }
            param1.readInt();
            _loc4_.resourceLevel = param1.readInt();
            _loc4_.resourceState = param1.readInt();
            _loc4_.haveResourceTime = param1.readDate();
            _loc4_.lastMaxMunites = param1.readInt();
            _loc4_.itemId = param1.readInt();
            _loc4_.itemCountPerHour = param1.readInt();
            resourceList.push(_loc4_);
            _loc10_++;
         }
         var _loc8_:int = param1.readInt();
         var _loc7_:int = 3;
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc5_ = new AnotherDimensionResourceInfo();
            _loc7_++;
            _loc5_.isHave = true;
            _loc5_.resourcePos = _loc7_;
            _loc5_.resourcePlayerInfo = PlayerManager.Instance.Self;
            _loc5_.resourceLevel = param1.readInt();
            _loc5_.haveResourceTime = param1.readDate();
            _loc5_.haveResourceLast = param1.readInt();
            _loc5_.lastMaxMunites = _loc5_.haveResourceLast;
            _loc5_.itemId = param1.readInt();
            _loc5_.itemCountPerHour = param1.readInt();
            haveResourceList.push(_loc5_);
            _loc6_++;
         }
         show();
      }
      
      private function updateInfo(param1:PackageIn) : void
      {
         var _loc2_:Boolean = false;
         anotherDimensionInfo = new AnotherDimensionInfo();
         anotherDimensionInfo.occupyCount = param1.readInt();
         anotherDimensionInfo.totalOccupyCount = param1.readInt();
         anotherDimensionInfo.lootCount = param1.readInt();
         anotherDimensionInfo.totalLootCount = param1.readInt();
         anotherDimensionInfo.refreshCount = param1.readInt();
         if(anotherDimensionInfo.refreshCount != refreshOnly)
         {
            _loc2_ = true;
         }
         anotherDimensionInfo.timeControlLv = param1.readInt();
         anotherDimensionInfo.timeControlExp = param1.readInt();
         anotherDimensionInfo.spaceControlLv = param1.readInt();
         anotherDimensionInfo.spaceControlExp = param1.readInt();
         anotherDimensionInfo.looterControlLv = param1.readInt();
         anotherDimensionInfo.looterControlExp = param1.readInt();
         refreshOnly = anotherDimensionInfo.refreshCount;
         if(!_loc2_)
         {
            dispatchEvent(new Event("updateView"));
         }
      }
      
      private function openOrClose(param1:PackageIn) : void
      {
         isOpen = param1.readBoolean();
      }
      
      private function updateResource(param1:PackageIn) : void
      {
         var _loc10_:int = 0;
         var _loc4_:* = null;
         var _loc9_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         resourceList = [];
         haveResourceList = [];
         var _loc2_:int = param1.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            _loc4_ = new AnotherDimensionResourceInfo();
            _loc4_.isHave = false;
            _loc4_.resourcePos = param1.readInt();
            _loc4_.monsterId = param1.readInt();
            if(_loc4_.monsterId == 0)
            {
               _loc9_ = new PlayerInfo();
               _loc9_.ID = param1.readInt();
               _loc9_.NickName = param1.readUTF();
               _loc3_ = param1.readInt();
               _loc9_.Sex = _loc3_ == 0?false:true;
               _loc9_.Hide = param1.readInt();
               _loc9_.Style = param1.readUTF();
               _loc9_.Colors = param1.readUTF();
               _loc9_.Skin = param1.readUTF();
               _loc9_.Grade = param1.readInt();
               _loc4_.resourcePlayerInfo = _loc9_;
            }
            else
            {
               param1.readInt();
               param1.readUTF();
               param1.readInt();
               param1.readInt();
               param1.readUTF();
               param1.readUTF();
               param1.readUTF();
               param1.readInt();
            }
            param1.readInt();
            _loc4_.resourceLevel = param1.readInt();
            _loc4_.resourceState = param1.readInt();
            _loc4_.haveResourceTime = param1.readDate();
            _loc4_.lastMaxMunites = param1.readInt();
            _loc4_.itemId = param1.readInt();
            _loc4_.itemCountPerHour = param1.readInt();
            resourceList.push(_loc4_);
            _loc10_++;
         }
         var _loc8_:int = param1.readInt();
         var _loc7_:int = 3;
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            _loc5_ = new AnotherDimensionResourceInfo();
            _loc7_++;
            _loc5_.isHave = true;
            _loc5_.resourcePos = _loc7_;
            _loc5_.resourcePlayerInfo = PlayerManager.Instance.Self;
            _loc5_.resourceLevel = param1.readInt();
            _loc5_.haveResourceTime = param1.readDate();
            _loc5_.haveResourceLast = param1.readInt();
            _loc5_.lastMaxMunites = _loc5_.haveResourceLast;
            _loc5_.itemId = param1.readInt();
            _loc5_.itemCountPerHour = param1.readInt();
            haveResourceList.push(_loc5_);
            _loc6_++;
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
