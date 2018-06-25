package ddt.manager
{
   import BraveDoor.BraveDoorManager;
   import bombKing.BombKingManager;
   import campbattle.CampBattleManager;
   import catchbeast.CatchBeastManager;
   import church.ChurchManager;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import cryptBoss.CryptBossManager;
   import ddt.loader.StateLoader;
   import ddt.states.BaseStateView;
   import ddt.states.FadingBlock;
   import ddt.states.StateCreater;
   import ddt.utils.MenoryUtil;
   import ddt.view.chat.ChatBugleView;
   import email.MailManager;
   import farm.FarmModelController;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import ringStation.RingStationManager;
   import road7th.StarlingMain;
   import roomList.pveRoomList.DungeonListManager;
   import roomList.pvpRoomList.RoomListManager;
   import starling.scene.consortiaDomain.ConsortiaDomainScene;
   import starling.scene.demonChiYou.DemonChiYouScene;
   import starling.scene.hall.HallScene;
   
   public class StateManager
   {
      
      private static var dic:Dictionary;
      
      private static var root:Sprite;
      
      private static var current:BaseStateView;
      
      private static var next:BaseStateView;
      
      private static var _currentStateType:String;
      
      private static var _lastStateType:String;
      
      public static var getInGame_Step_1:Boolean = false;
      
      public static var getInGame_Step_2:Boolean = false;
      
      public static var getInGame_Step_3:Boolean = false;
      
      public static var getInGame_Step_4:Boolean = false;
      
      public static var getInGame_Step_5:Boolean = false;
      
      public static var getInGame_Step_6:Boolean = false;
      
      public static var getInGame_Step_7:Boolean = false;
      
      public static var getInGame_Step_8:Boolean = false;
      
      private static var _stage:Stage;
      
      public static var isShowFadingAnimation:Boolean = true;
      
      private static var fadingBlock:FadingBlock;
      
      private static var _creator:StateCreater;
      
      public static var RecordFlag:Boolean;
      
      private static var _data:Object;
      
      private static var _enterType:String;
      
      public static var isOpenRoomList:Boolean;
      
      public static var isOpenDungeonList:Boolean;
      
      public static var isOpenDemonChiYouRewardSelectFrame:Boolean;
       
      
      public function StateManager()
      {
         super();
      }
      
      public static function get currentStateType() : String
      {
         return _currentStateType;
      }
      
      public static function set currentStateType(value:String) : void
      {
         _currentStateType = value;
      }
      
      public static function get lastStateType() : String
      {
         return _lastStateType;
      }
      
      public static function set lastStateType(value:String) : void
      {
         _lastStateType = value;
      }
      
      public static function get nextState() : BaseStateView
      {
         return next;
      }
      
      public static function setup(parent:Sprite, creator:StateCreater, recordFlag:Boolean = false) : void
      {
         dic = new Dictionary();
         root = parent;
         _creator = creator;
         RecordFlag = recordFlag;
         fadingBlock = new FadingBlock(addNextToStage,showLoading);
      }
      
      public static function setState(type:String = "default", data:Object = null, mapId:int = 0) : void
      {
         if(type == "roomlist")
         {
            isOpenRoomList = true;
            PolarRegionManager.Instance.ShowFlag = false;
            type = "main";
            currentStateType = type;
         }
         if(type == "dungeon")
         {
            isOpenDungeonList = true;
            type = "main";
            currentStateType = type;
         }
         if(type != "braveDoorRoom" && currentStateType == "braveDoorRoom")
         {
            BraveDoorManager.instance.moduleIsShow = false;
         }
         var next:BaseStateView = getState(type);
         if(type == "roomlist" && current.getType() == "matchRoom")
         {
            if(getInGame_Step_1 && getInGame_Step_2)
            {
               if(getInGame_Step_3 && !getInGame_Step_4)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + type + "游戏步骤进行到3之后停止了");
               }
               else if(getInGame_Step_4 && !getInGame_Step_5)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + type + "游戏步骤进行到4之后停止了");
               }
               else if(getInGame_Step_5 && !getInGame_Step_6)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + type + "游戏步骤进行到5之后停止了");
               }
               else if(getInGame_Step_6 && !getInGame_Step_7)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + type + "游戏步骤进行到6之后停止了");
               }
               else if(getInGame_Step_7 && !getInGame_Step_8)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + type + "游戏步骤进行到7之后停止了");
               }
               getInGame_Step_8 = false;
               getInGame_Step_7 = false;
               getInGame_Step_6 = false;
               getInGame_Step_5 = false;
               getInGame_Step_4 = false;
               getInGame_Step_3 = false;
               getInGame_Step_2 = false;
               getInGame_Step_1 = false;
            }
         }
         _data = data;
         _enterType = type;
         if(next)
         {
            setStateImp(next,mapId);
         }
         else
         {
            createStateAsync(_enterType,createCallbak);
         }
      }
      
      public static function stopImidily() : void
      {
         fadingBlock.stopImidily();
      }
      
      private static function createCallbak(value:BaseStateView) : void
      {
         if(value)
         {
            dic[value.getType()] = value;
         }
         setStateImp(value);
      }
      
      private static function setStateImp(value:BaseStateView, id:int = 0) : Boolean
      {
         if(value == null)
         {
            return false;
         }
         if(value.getType() != _enterType)
         {
            return false;
         }
         _enterType = "";
         if(value == current || next == value)
         {
            if(!CampBattleManager.instance.campViewFlag)
            {
               current.refresh();
               showAlertRoomDungeon();
               return false;
            }
         }
         if(value.check(currentStateType))
         {
            QueueManager.pause();
            next = value;
            if(!next.prepared)
            {
               next.prepare();
            }
            ShowTipManager.Instance.removeAllTip();
            LayerManager.Instance.clearnGameDynamic();
            if(current)
            {
               fadingBlock.setNextState(next);
               fadingBlock.update();
            }
            else
            {
               addNextToStage();
            }
            return true;
         }
         return false;
      }
      
      private static function addNextToStage() : void
      {
         QueueManager.resume();
         if(current)
         {
            current.leaving(next);
         }
         StarlingMain.instance.leaveCurrentScene();
         StateLoader.startStarlingBonesLoad(!!current?current.getType():null,next.getType(),enterScene);
      }
      
      public static function enterScene() : void
      {
         var last:BaseStateView = current;
         current = next;
         currentStateType = current.getType();
         next = null;
         enterStarlingScene(currentStateType);
         current.enter(last,_data);
         MenoryUtil.clearMenory();
         root.addChild(current.getView());
         current.addedToStage();
         if(last && !CampBattleManager.instance.campViewFlag)
         {
            if(last.getView().parent)
            {
               last.getView().parent.removeChild(last.getView());
            }
            last.removedFromStage();
         }
         if(current.goBack())
         {
            fadingBlock.executed = false;
            back();
         }
         EnthrallManager.getInstance().updateEnthrallView();
         ChatBugleView.instance.updatePos();
         MailManager.Instance.isOpenFromBag = false;
         if(ChurchManager.instance.isUnwedding)
         {
            ChurchManager.instance.isUnwedding = false;
            ChurchManager.instance.openAlert();
         }
         if(!BombKingManager.instance.Recording)
         {
            if(RingStationManager.instance.RoomType == 24 && currentStateType == "main")
            {
               RingStationManager.instance.show();
            }
            if(CatchBeastManager.instance.RoomType == 26 && currentStateType == "main")
            {
               CatchBeastManager.instance.show();
            }
            if(CryptBossManager.instance.RoomType == 51 && currentStateType == "main")
            {
               CryptBossManager.instance.show();
            }
            showAlertRoomDungeon();
         }
         if(currentStateType != "main")
         {
            SocketManager.Instance.out.sendPlayerExit(PlayerManager.Instance.Self.ID);
         }
         else if(BombKingManager.instance.Recording)
         {
            BombKingManager.instance.show();
            BombKingManager.instance.Recording = false;
         }
         fadingBlock.canDisappear = true;
      }
      
      private static function enterStarlingScene(type:String) : void
      {
         var scene:* = undefined;
         if(type == "main")
         {
            StarlingMain.instance.enterScene(new HallScene());
         }
         else if(type == "fighting3d")
         {
            scene = getDefinitionByName("gameStarling.view.scene.GameViewScene");
            StarlingMain.instance.enterScene(new scene());
         }
         else if(type == "demon_chi_you")
         {
            StarlingMain.instance.enterScene(new DemonChiYouScene());
         }
         else if(type == "consortia_domain")
         {
            StarlingMain.instance.enterScene(new ConsortiaDomainScene());
         }
         else if(type == "consortiaGuard")
         {
            scene = getDefinitionByName("starling.scene.consortiaGuard.ConsortiaGuardScene");
            StarlingMain.instance.enterScene(new scene());
         }
         else
         {
            StarlingMain.instance.enterScene(null);
         }
      }
      
      private static function showAlertRoomDungeon() : void
      {
         if(isOpenRoomList)
         {
            isOpenRoomList = false;
            RoomListManager.instance.enter();
         }
         if(isOpenDungeonList)
         {
            isOpenDungeonList = false;
            if(!FarmModelController.instance.FightPoultryFlag)
            {
               DungeonListManager.instance.enter();
            }
            else
            {
               FarmModelController.instance.FightPoultryFlag = false;
            }
         }
      }
      
      private static function showLoading() : void
      {
         if(!LoaderSavingManager.hasFileToSave)
         {
         }
      }
      
      public static function back() : void
      {
         var backtype:* = null;
         if(current != null)
         {
            backtype = current.getBackType();
            if(backtype != "")
            {
               setState(backtype);
            }
         }
      }
      
      public static function getState(type:String) : BaseStateView
      {
         return dic[type] as BaseStateView;
      }
      
      public static function createStateAsync(type:String, callbak:Function = null) : void
      {
         _creator.createAsync(type,callbak);
      }
      
      public static function isExitGame(type:String) : Boolean
      {
         return type != "fighting" && type != "fighting3d" && type != "missionResult" && type != "fightLabGameView";
      }
      
      public static function isExitRoom(type:String) : Boolean
      {
         return type != "fighting" && type != "fighting3d" && type != "matchRoom" && type != "teamRoom" && type != "missionResult" && type != "dungeonRoom" && type != "challengeRoom" && type != "roomLoading" && type != "encounterLoading" && type != "fightLib" && type != "trainer1" && type != "trainer2" && type != "fightLabGameView" && type != "consortiaBattleScene" && type != "campBattleScene" && type != "battleRoom" && type != "consortia_domain" && type != "consortiaGuard";
      }
      
      public static function isInGame(type:String) : Boolean
      {
         var _loc2_:* = type;
         if("fighting" !== _loc2_)
         {
            if("fighting3d" !== _loc2_)
            {
               if("trainer1" !== _loc2_)
               {
                  if("trainer2" !== _loc2_)
                  {
                     if("fightLabGameView" !== _loc2_)
                     {
                        return false;
                     }
                  }
                  addr12:
                  return true;
               }
               addr11:
               §§goto(addr12);
            }
            addr10:
            §§goto(addr11);
         }
         §§goto(addr10);
      }
      
      public static function leaving() : void
      {
         if(current != null)
         {
            current.dispose();
         }
      }
   }
}
