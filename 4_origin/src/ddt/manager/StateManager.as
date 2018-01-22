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
      
      public static function set currentStateType(param1:String) : void
      {
         _currentStateType = param1;
      }
      
      public static function get lastStateType() : String
      {
         return _lastStateType;
      }
      
      public static function set lastStateType(param1:String) : void
      {
         _lastStateType = param1;
      }
      
      public static function get nextState() : BaseStateView
      {
         return next;
      }
      
      public static function setup(param1:Sprite, param2:StateCreater, param3:Boolean = false) : void
      {
         dic = new Dictionary();
         root = param1;
         _creator = param2;
         RecordFlag = param3;
         fadingBlock = new FadingBlock(addNextToStage,showLoading);
      }
      
      public static function setState(param1:String = "default", param2:Object = null, param3:int = 0) : void
      {
         if(param1 == "roomlist")
         {
            isOpenRoomList = true;
            PolarRegionManager.Instance.ShowFlag = false;
            param1 = "main";
            currentStateType = param1;
         }
         if(param1 == "dungeon")
         {
            isOpenDungeonList = true;
            param1 = "main";
            currentStateType = param1;
         }
         if(param1 != "braveDoorRoom" && currentStateType == "braveDoorRoom")
         {
            BraveDoorManager.instance.moduleIsShow = false;
         }
         var _loc4_:BaseStateView = getState(param1);
         if(param1 == "roomlist" && current.getType() == "matchRoom")
         {
            if(getInGame_Step_1 && getInGame_Step_2)
            {
               if(getInGame_Step_3 && !getInGame_Step_4)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + param1 + "游戏步骤进行到3之后停止了");
               }
               else if(getInGame_Step_4 && !getInGame_Step_5)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + param1 + "游戏步骤进行到4之后停止了");
               }
               else if(getInGame_Step_5 && !getInGame_Step_6)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + param1 + "游戏步骤进行到5之后停止了");
               }
               else if(getInGame_Step_6 && !getInGame_Step_7)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + param1 + "游戏步骤进行到6之后停止了");
               }
               else if(getInGame_Step_7 && !getInGame_Step_8)
               {
                  SocketManager.Instance.out.sendErrorMsg("房间类型：" + param1 + "游戏步骤进行到7之后停止了");
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
         _data = param2;
         _enterType = param1;
         if(_loc4_)
         {
            setStateImp(_loc4_,param3);
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
      
      private static function createCallbak(param1:BaseStateView) : void
      {
         if(param1)
         {
            dic[param1.getType()] = param1;
         }
         setStateImp(param1);
      }
      
      private static function setStateImp(param1:BaseStateView, param2:int = 0) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.getType() != _enterType)
         {
            return false;
         }
         _enterType = "";
         if(param1 == current || next == param1)
         {
            if(!CampBattleManager.instance.campViewFlag)
            {
               current.refresh();
               showAlertRoomDungeon();
               return false;
            }
         }
         if(param1.check(currentStateType))
         {
            QueueManager.pause();
            next = param1;
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
         var _loc1_:BaseStateView = current;
         current = next;
         currentStateType = current.getType();
         next = null;
         enterStarlingScene(currentStateType);
         current.enter(_loc1_,_data);
         MenoryUtil.clearMenory();
         root.addChild(current.getView());
         current.addedToStage();
         if(_loc1_ && !CampBattleManager.instance.campViewFlag)
         {
            if(_loc1_.getView().parent)
            {
               _loc1_.getView().parent.removeChild(_loc1_.getView());
            }
            _loc1_.removedFromStage();
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
      
      private static function enterStarlingScene(param1:String) : void
      {
         var _loc2_:* = undefined;
         if(param1 == "main")
         {
            StarlingMain.instance.enterScene(new HallScene());
         }
         else if(param1 == "fighting3d")
         {
            _loc2_ = getDefinitionByName("gameStarling.view.scene.GameViewScene");
            StarlingMain.instance.enterScene(new _loc2_());
         }
         else if(param1 == "demon_chi_you")
         {
            StarlingMain.instance.enterScene(new DemonChiYouScene());
         }
         else if(param1 == "consortia_domain")
         {
            StarlingMain.instance.enterScene(new ConsortiaDomainScene());
         }
         else if(param1 == "consortiaGuard")
         {
            _loc2_ = getDefinitionByName("starling.scene.consortiaGuard.ConsortiaGuardScene");
            StarlingMain.instance.enterScene(new _loc2_());
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
         var _loc1_:* = null;
         if(current != null)
         {
            _loc1_ = current.getBackType();
            if(_loc1_ != "")
            {
               setState(_loc1_);
            }
         }
      }
      
      public static function getState(param1:String) : BaseStateView
      {
         return dic[param1] as BaseStateView;
      }
      
      public static function createStateAsync(param1:String, param2:Function = null) : void
      {
         _creator.createAsync(param1,param2);
      }
      
      public static function isExitGame(param1:String) : Boolean
      {
         return param1 != "fighting" && param1 != "fighting3d" && param1 != "missionResult" && param1 != "fightLabGameView";
      }
      
      public static function isExitRoom(param1:String) : Boolean
      {
         return param1 != "fighting" && param1 != "fighting3d" && param1 != "matchRoom" && param1 != "teamRoom" && param1 != "missionResult" && param1 != "dungeonRoom" && param1 != "challengeRoom" && param1 != "roomLoading" && param1 != "encounterLoading" && param1 != "fightLib" && param1 != "trainer1" && param1 != "trainer2" && param1 != "fightLabGameView" && param1 != "consortiaBattleScene" && param1 != "campBattleScene" && param1 != "battleRoom" && param1 != "consortia_domain" && param1 != "consortiaGuard";
      }
      
      public static function isInGame(param1:String) : Boolean
      {
         var _loc2_:* = param1;
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
                  addr9:
                  return true;
               }
               addr8:
               §§goto(addr9);
            }
            addr7:
            §§goto(addr8);
         }
         §§goto(addr7);
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
