package consortiaDomain
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.CoreManager;
   import ddt.data.ServerConfigInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.view.ConsortiaDomainIcon;
   import ddt.view.chat.ChatData;
   import email.MailManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import hall.IHallStateView;
   import hall.aStar.AStarPathFinder;
   import org.aswing.KeyboardManager;
   import quest.TaskManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import starling.scene.hall.SceneMapGridData;
   import starling.textures.Texture;
   
   public class ConsortiaDomainManager extends CoreManager
   {
      
      public static const EVENT_BUILD_IN_FIGHT_STATE_CHANGE:String = "event_build_in_fight_state_change";
      
      public static const EVENT_MONSTER_STATE_CHANGE:String = "event_monster_state_change";
      
      public static const EVENT_KILL_RANK_UPDATE:String = "event_kill_rank_update";
      
      public static const EVENT_GET_CONSORTIA_INFO_RES:String = "event_get_consortia_info_res";
      
      public static const EVENT_ACTIVE_RES:String = "event_active_res";
      
      public static const EVENT_ACTIVE_STATE_CHANGE:String = "event_active_state_change";
      
      public static const EVENT_REMOVE_OTHER_PLAYER:String = "event_remove_other_player";
      
      public static const EVENT_MONSTER_INFO_SINGLE:String = "event_monster_info_single";
      
      public static const EVENT_REMOVE_CHILD_MONSTER:String = "event_remove_child_monster";
      
      public static const EVENT_REPAIR_PLAYER_NUM_CHANGE:String = "event_repair_player_num_change";
      
      public static const EVENT_MONSTER_BORN:String = "event_monster_born";
      
      public static const ACTIVE_STATE_MIN10_BEFORE:int = -10;
      
      public static const ACTIVE_STATE_MIN5_BEFORE:int = -5;
      
      public static const ACTIVE_STATE_MIN4_BEFORE:int = -4;
      
      public static const ACTIVE_STATE_MIN3_BEFORE:int = -3;
      
      public static const ACTIVE_STATE_MIN2_BEFORE:int = -2;
      
      public static const ACTIVE_STATE_MIN1_BEFORE:int = -1;
      
      public static const ACTIVE_STATE_INIT:int = 0;
      
      public static const ACTIVE_STATE_OPEN:int = 1;
      
      public static const ACTIVE_STATE_END:int = 100;
      
      public static const CONSORTIA_HOME_BANK_ID:int = 1;
      
      public static const CONSORTIA_SKILL_ID:int = 2;
      
      public static const CONSORTIA_SHOP_ID:int = 3;
      
      public static const CONSORTIA_BAG_STORE_ID:int = 4;
      
      public static const CONSORTIA_CITY_ID:int = 5;
      
      public static const BUILD_CENTER_POS_ARR:Array = [null,new Point(856,902),new Point(2221,851),new Point(1140,495),new Point(1982,442),new Point(1597,880)];
      
      public static const BUILD_RADIUS_ARR:Array = [null,123,180,197,169,320];
      
      public static const BUILD_RES_NAME_ARR:Array = [null,"consortiaDomainHomeBank","consortiaDomainConsortiaSkill","consortiaDomainConsortiaShop","consortiaDomainBagStore","consortiaDomainConsortiaCity"];
      
      public static const MONSTER_ATK_TYPE_NORMAL:int = 0;
      
      public static const MONSTER_ATK_TYPE_BUILD:int = 1;
      
      public static const MONSTER_BORN_BUILD_STATE_CLOSE:int = 1;
      
      public static const MONSTER_BORN_BUILD_STATE_OPEN:int = 2;
      
      public static const MONSTER_STATE_BORN:int = 1;
      
      public static const MONSTER_STATE_WALK:int = 3;
      
      public static const MONSTER_STATE_BEAT_BUILD:int = 4;
      
      public static const MONSTER_STATE_BEAT_PLAYER:int = 5;
      
      public static const MONSTER_STATE_DIE:int = 6;
      
      public static const MONSTER_STATE_NOT_BORN:int = 100;
      
      public static const PLAYER_STATE_STAND:int = 1;
      
      public static const PLAYER_STATE_WALK:int = 2;
      
      public static const PLAYER_STATE_BEAT_MONSTER:int = 3;
      
      public static const PLAYER_STATE_DIE:int = 4;
      
      public static const BUILD_STATE_NORMAL:int = 1;
      
      public static const BUILD_STATE_WAIT_GRADE:int = 2;
      
      public static const BUILD_STATE_REPAIR:int = 3;
      
      public static const BUILD_STATE_WAIT_REPAIR:int = 4;
      
      public static const BUILD_STATE_FIGHT:int = 5;
      
      public static const BUILD_STATE_BE_BEAT:int = 6;
      
      public static const MONSTER_ACTION_STAND:String = "stand";
      
      public static const MONSTER_ACTION_WALK:String = "walk";
      
      public static const MONSTER_ACTION_DIE:String = "die";
      
      public static var CAN_USE_K:Boolean = true;
      
      public static var CAN_USE_R:Boolean = true;
      
      public static var CAN_USE_Q:Boolean = true;
      
      public static const BUILD_LOW_HP_WARN_ARR:Array = [0.75,0.5,0.25,0.1,0.05,0.01];
      
      public static const AUTO_REPAIR_TIME:int = 172800000;
      
      private static var _instance:ConsortiaDomainManager;
       
      
      public var model:ConsortiaDomainModel;
      
      public var sceneMapGridData:SceneMapGridData;
      
      public var bgLayerViewRect:Rectangle;
      
      private var _hall:IHallStateView;
      
      private var _icon:ConsortiaDomainIcon;
      
      private var _secTickTimer:Timer;
      
      public var aStarPathFinder:AStarPathFinder;
      
      private var _hasAskActiveSate:Boolean = false;
      
      public var activeState:int = 0;
      
      private var _buildViewUpGradeBtnTexture:Texture;
      
      private var _buildViewOpenBtnTexture:Texture;
      
      private var _bulidViewBtn:TextButton;
      
      public var consortiaLandBuildBlood:int;
      
      public var consortiaLandRepairBlood:int;
      
      public var consortiaLandMonsterSpeed:int;
      
      public var consortiaLandRepairCount:int;
      
      public var buildNameArr:Array;
      
      public var isShowFightMonster:Boolean = true;
      
      public function ConsortiaDomainManager(target:IEventDispatcher = null)
      {
         super();
         _instance = this;
         model = new ConsortiaDomainModel();
         model.monsterInfo = {};
         model.allBuildInfo = {};
         SocketManager.Instance.addEventListener(PkgEvent.format(371,12),onGetConsortiaInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,7),onActive);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,15),onActiveSate);
         RoomManager.Instance.addEventListener("SINGLE_ROOM_BEGIN",onSingleRoomBeginRes);
      }
      
      public static function get instance() : ConsortiaDomainManager
      {
         if(_instance == null)
         {
            _instance = new ConsortiaDomainManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
      
      public function askActiveSate() : void
      {
         if(_hasAskActiveSate)
         {
            return;
         }
         SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
         SocketManager.Instance.out.getConsortiaDomainActiveState();
      }
      
      private function onActiveSate(event:PkgEvent) : void
      {
         var alert:* = null;
         var chatData:* = null;
         var pkg:PackageIn = event.pkg;
         var newActiveState:int = pkg.readInt();
         if(activeState != newActiveState)
         {
            activeState = newActiveState;
            checkIcon();
         }
         _hasAskActiveSate = true;
         var isInConsortiaDomainScene:* = StateManager.currentStateType == "consortia_domain";
         if(activeState == 1)
         {
            chatData = new ChatData();
            chatData.channel = 3;
            chatData.type = 113;
            chatData.msg = LanguageMgr.GetTranslation("consortiadomain.clickChatLinkEnterScene");
            ChatManager.Instance.chat(chatData);
            if(StateManager.currentStateType != "fighting" && StateManager.currentStateType != "gameLoading" && !isInConsortiaDomainScene)
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.activeOpenAleart"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert.addEventListener("response",onActiveOpenAleartResponse);
            }
         }
         if(isInConsortiaDomainScene)
         {
            playMusic();
         }
         dispatchEvent(new Event("event_active_state_change"));
      }
      
      private function onActiveOpenAleartResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onActiveOpenAleartResponse);
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               enterScene(false);
            default:
               enterScene(false);
         }
         alert.dispose();
      }
      
      private function onActive(event:PkgEvent) : void
      {
         model.isActive = true;
         dispatchEvent(new Event("event_active_res"));
      }
      
      private function onGetKillInfo(event:PkgEvent) : void
      {
         var obj:* = null;
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         model.killRankArr = [];
         for(i = 0; i < count; )
         {
            obj = {};
            obj["UserID"] = pkg.readInt();
            obj["NickName"] = pkg.readUTF();
            obj["KillCount"] = pkg.readInt();
            model.killRankArr.push(obj);
            i++;
         }
         model.killRankArr.sortOn("KillCount",2 | 16);
         for(i = 0; i < count; )
         {
            obj = model.killRankArr[i];
            obj["Rank"] = i + 1;
            if(obj["UserID"] == PlayerManager.Instance.Self.ID)
            {
               model.myRank = obj["Rank"];
               model.myKillNum = obj["KillCount"];
            }
            i++;
         }
         dispatchEvent(new Event("event_kill_rank_update"));
      }
      
      protected function onSecTickTimer(event:TimerEvent) : void
      {
         var activeOpenSec:int = 0;
         var monsterBornArr:* = null;
         var i:int = 0;
         var bornSec:int = 0;
         if(_secTickTimer.currentCount % 5 == 0)
         {
            if(activeState == 0 || activeState == 100 || activeState == -10)
            {
               if(!isAllBuildFullHp())
               {
                  SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
               }
            }
            else if(activeState == 1)
            {
               SocketManager.Instance.out.getConsortiaDomainBuildInfoInFight();
               SocketManager.Instance.out.getConsortiaDomainKillInfo();
            }
         }
         var nowMonsterWaveIndex:* = -1;
         if(ConsortiaDomainManager.instance.activeState == 1)
         {
            if(ConsortiaDomainManager.instance.model.monsterBornArr && ConsortiaDomainManager.instance.model.BeginTime)
            {
               activeOpenSec = (TimeManager.Instance.NowTime() - ConsortiaDomainManager.instance.model.BeginTime.time) / 1000;
               monsterBornArr = ConsortiaDomainManager.instance.model.monsterBornArr;
               for(i = model.monsterWaveIndex + 1; i < monsterBornArr.length; )
               {
                  bornSec = monsterBornArr[i];
                  if(bornSec > activeOpenSec)
                  {
                     nowMonsterWaveIndex = i;
                  }
                  i++;
               }
            }
         }
         if(nowMonsterWaveIndex > model.monsterWaveIndex)
         {
            model.monsterWaveIndex = nowMonsterWaveIndex;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortiadomain.monsterIsComing"));
            dispatchEvent(new Event("event_monster_born"));
         }
      }
      
      public function isAllBuildFullHp() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = model.allBuildInfo;
         for each(var eachBuildInfo in model.allBuildInfo)
         {
            if(eachBuildInfo.Repair != 0)
            {
               return false;
            }
         }
         return true;
      }
      
      private function onStageResize(evt:Event) : void
      {
         bgLayerViewRect.width = StageReferance.stageWidth;
         bgLayerViewRect.height = StageReferance.stageHeight;
         dispatchEvent(new Event("resize"));
      }
      
      private function initFightBuildInfo(buildId:int, pkg:PackageIn) : void
      {
         var i:int = 0;
         var msg:* = null;
         var eachBuildInfo:EachBuildInfo = model.allBuildInfo[buildId];
         if(!eachBuildInfo)
         {
            eachBuildInfo = new EachBuildInfo();
            eachBuildInfo.Id = buildId;
            model.allBuildInfo[buildId] = eachBuildInfo;
         }
         eachBuildInfo.Id = buildId;
         eachBuildInfo.Blood = pkg.readInt();
         eachBuildInfo.State = pkg.readInt();
         if(eachBuildInfo.State == 1)
         {
            eachBuildInfo.State = 6;
         }
         else
         {
            eachBuildInfo.State = 5;
         }
         var warnBlood:* = -1;
         for(i = 0; i < BUILD_LOW_HP_WARN_ARR.length; )
         {
            if(eachBuildInfo.Blood < BUILD_LOW_HP_WARN_ARR[i] * consortiaLandBuildBlood && !eachBuildInfo.lowHpWarnArr[i])
            {
               eachBuildInfo.lowHpWarnArr[i] = true;
               warnBlood = Number(BUILD_LOW_HP_WARN_ARR[i]);
            }
            i++;
         }
         if(warnBlood != -1)
         {
            msg = LanguageMgr.GetTranslation("consortiadomain.build.lowHp",buildNameArr[buildId],int(warnBlood * 100));
            ChatManager.Instance.sysChatConsortia(msg);
            MessageTipManager.getInstance().show(msg);
         }
      }
      
      private function initUnFightBuildInfo(buildId:int, pkg:PackageIn) : void
      {
         var eachBuildInfo:EachBuildInfo = model.allBuildInfo[buildId];
         if(!eachBuildInfo)
         {
            eachBuildInfo = new EachBuildInfo();
            eachBuildInfo.Id = buildId;
            model.allBuildInfo[buildId] = eachBuildInfo;
         }
         if(buildId == 5)
         {
            eachBuildInfo.Repair = 0;
            eachBuildInfo.State = 0;
         }
         else if(pkg != null)
         {
            eachBuildInfo.Repair = pkg.readInt();
            eachBuildInfo.State = pkg.readInt();
            if(eachBuildInfo.Repair == 0)
            {
               eachBuildInfo.State = 0;
            }
         }
         eachBuildInfo.State = getFixUnFightBuildState(buildId,eachBuildInfo.State,eachBuildInfo.Repair);
      }
      
      public function isCanGradeBuild(buildId:int) : Boolean
      {
         if(buildId == 5)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(0) && checkGoldOrLevel(0);
         }
         if(buildId == 4)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(1) && checkGoldOrLevel(1);
         }
         if(buildId == 3)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(2) && checkGoldOrLevel(2);
         }
         if(buildId == 1)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(3) && checkGoldOrLevel(3);
         }
         if(buildId == 2)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(4) && checkGoldOrLevel(4);
         }
         return false;
      }
      
      public function getBuildLv(buildId:int) : int
      {
         if(buildId == 5)
         {
            return PlayerManager.Instance.Self.consortiaInfo.Level;
         }
         if(buildId == 3)
         {
            return PlayerManager.Instance.Self.consortiaInfo.ShopLevel;
         }
         if(buildId == 4)
         {
            return PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         }
         if(buildId == 1)
         {
            return PlayerManager.Instance.Self.consortiaInfo.StoreLevel;
         }
         if(buildId == 2)
         {
            return PlayerManager.Instance.Self.consortiaInfo.BufferLevel;
         }
         return 0;
      }
      
      private function checkGoldOrLevel(_selectIndex:int) : Boolean
      {
         switch(int(_selectIndex))
         {
            case 0:
               if(PlayerManager.Instance.Self.consortiaInfo.Level >= 10)
               {
                  return false;
               }
               break;
            case 1:
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel >= 10)
               {
                  return false;
               }
               if(PlayerManager.Instance.Self.consortiaInfo.SmithLevel >= PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  return false;
               }
               break;
            case 2:
               if(PlayerManager.Instance.Self.consortiaInfo.ShopLevel >= 5)
               {
                  return false;
               }
               if((PlayerManager.Instance.Self.consortiaInfo.ShopLevel + 1) * 2 > PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  return false;
               }
               break;
            case 3:
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel >= 10)
               {
                  return false;
               }
               if(PlayerManager.Instance.Self.consortiaInfo.StoreLevel >= PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  return false;
               }
               break;
            case 4:
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel >= 10)
               {
                  return false;
               }
               if(PlayerManager.Instance.Self.consortiaInfo.BufferLevel >= PlayerManager.Instance.Self.consortiaInfo.Level && PlayerManager.Instance.Self.consortiaInfo.Level != 10)
               {
                  return false;
               }
               break;
         }
         if(_selectIndex == 0 && PlayerManager.Instance.Self.Gold < ConsortionModelManager.Instance.model.getLevelData(PlayerManager.Instance.Self.consortiaInfo.Level + 1).NeedGold)
         {
            return false;
         }
         return true;
      }
      
      private function onGetMonsterInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var serverMonsterState:int = 0;
         var clientMonsterState:int = 0;
         var inCount:int = 0;
         var j:int = 0;
         var eachMonsterInfo:* = null;
         var pkg:PackageIn = event.pkg;
         var outCount:int = pkg.readInt();
         model.monsterBornArr = [];
         for(i = 0; i < outCount; )
         {
            serverMonsterState = pkg.readInt();
            clientMonsterState = monsterStateSeverToClient(serverMonsterState);
            inCount = pkg.readInt();
            for(j = 0; j < inCount; )
            {
               eachMonsterInfo = readMonsterInfoSingle(pkg);
               eachMonsterInfo.state = clientMonsterState;
               eachMonsterInfo.serverMonsterState = serverMonsterState;
               if(model.monsterBornArr.indexOf(eachMonsterInfo.BirthSecond) == -1)
               {
                  model.monsterBornArr.push(eachMonsterInfo.BirthSecond);
               }
               j++;
            }
            i++;
         }
         model.monsterBornArr.sort(16);
         dispatchEvent(new Event("event_monster_state_change"));
      }
      
      private function monsterStateSeverToClient(serverMonsterState:int) : int
      {
         var clientMonsterState:int = 2147483647;
         if(serverMonsterState == -6)
         {
            clientMonsterState = 1;
         }
         else if(serverMonsterState == -1)
         {
            clientMonsterState = 100;
         }
         else if(serverMonsterState == -2 || serverMonsterState == -3)
         {
            clientMonsterState = 3;
         }
         else if(serverMonsterState == -4)
         {
            clientMonsterState = 5;
         }
         else if(serverMonsterState == -5)
         {
            clientMonsterState = 6;
         }
         else if(serverMonsterState > 0)
         {
            clientMonsterState = 4;
         }
         return clientMonsterState;
      }
      
      private function readMonsterInfoSingle(pkg:PackageIn) : EachMonsterInfo
      {
         var livingID:int = pkg.readInt();
         var eachMonsterInfo:EachMonsterInfo = model.monsterInfo[livingID];
         if(!eachMonsterInfo)
         {
            eachMonsterInfo = new EachMonsterInfo();
            eachMonsterInfo.LivingID = livingID;
            model.monsterInfo[livingID] = eachMonsterInfo;
         }
         eachMonsterInfo.LastTargetID = eachMonsterInfo.TargetID;
         eachMonsterInfo.TargetID = pkg.readInt();
         eachMonsterInfo.Type = pkg.readInt();
         eachMonsterInfo.BeginSecond = pkg.readInt();
         eachMonsterInfo.BirthSecond = pkg.readInt();
         eachMonsterInfo.FightID = pkg.readInt();
         eachMonsterInfo.posX = pkg.readInt();
         eachMonsterInfo.posY = pkg.readInt();
         return eachMonsterInfo;
      }
      
      private function onMonsterInfoSingle(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var serverMonsterState:int = pkg.readInt();
         var clientMonsterState:int = monsterStateSeverToClient(serverMonsterState);
         var eachMonsterInfo:EachMonsterInfo = readMonsterInfoSingle(pkg);
         eachMonsterInfo.state = clientMonsterState;
         eachMonsterInfo.serverMonsterState = serverMonsterState;
         dispatchEvent(new CEvent("event_monster_info_single",eachMonsterInfo));
      }
      
      private function onGetBuildInfoInFight(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         pkg.readBoolean();
         pkg.readDate();
         initFightBuildInfo(1,pkg);
         initFightBuildInfo(2,pkg);
         initFightBuildInfo(3,pkg);
         initFightBuildInfo(4,pkg);
         initFightBuildInfo(5,pkg);
         dispatchEvent(new Event("event_build_in_fight_state_change"));
      }
      
      private function onGetConsortiaInfo(event:PkgEvent) : void
      {
         var autoRepairCompleteTime:* = null;
         var pkg:PackageIn = event.pkg;
         var isCanGet:Boolean = pkg.readBoolean();
         if(isCanGet)
         {
            model.isActive = pkg.readInt() == 0?false:true;
            model.BeginTime = pkg.readDate();
            initUnFightBuildInfo(1,pkg);
            initUnFightBuildInfo(2,pkg);
            initUnFightBuildInfo(3,pkg);
            initUnFightBuildInfo(4,pkg);
            initUnFightBuildInfo(5,null);
            model.EndTime = pkg.readDate();
            autoRepairCompleteTime = new Date();
            autoRepairCompleteTime.time = model.EndTime.time + 172800000;
            model.autoRepairCompleteTime = autoRepairCompleteTime;
         }
         else
         {
            model.isActive = false;
         }
         dispatchEvent(new Event("event_get_consortia_info_res"));
      }
      
      private function getFixUnFightBuildState(buildId:int, buildState:int, buildRepair:int) : int
      {
         if(buildState == 0)
         {
            if(buildRepair == 0)
            {
               return !!isCanGradeBuild(buildId)?2:1;
            }
            return 4;
         }
         if(buildState == 1)
         {
            return 3;
         }
         return 0;
      }
      
      private function onBuildRepairInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var buildId:int = 0;
         var eachBuildInfo:* = null;
         var pkg:PackageIn = event.pkg;
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            buildId = pkg.readInt();
            eachBuildInfo = model.allBuildInfo[buildId];
            if(!eachBuildInfo)
            {
               eachBuildInfo = new EachBuildInfo();
               eachBuildInfo.Id = buildId;
               model.allBuildInfo[buildId] = eachBuildInfo;
            }
            eachBuildInfo.repairPlayerNum = pkg.readInt();
            i++;
         }
         dispatchEvent(new Event("event_repair_player_num_change"));
      }
      
      private function onReduceBloodState(event:PkgEvent) : void
      {
         var msg:* = null;
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readInt();
         var buildId:int = pkg.readInt();
         if(type == 0)
         {
            msg = LanguageMgr.GetTranslation("consortiadomain.buildFirstBeBeat",buildNameArr[buildId]);
         }
         else if(type == 1)
         {
            msg = LanguageMgr.GetTranslation("consortiadomain.build1MinBeBeat",buildNameArr[buildId]);
         }
         ChatManager.Instance.sysChatConsortia(msg);
         MessageTipManager.getInstance().show(msg);
      }
      
      private function onConsortiaBuildLevelUp(evt:Event) : void
      {
         var eachBuildInfo:* = null;
         var buildIdArr:Array = [1,2,3,4,5];
         var _loc6_:int = 0;
         var _loc5_:* = buildIdArr;
         for each(var buildId in buildIdArr)
         {
            eachBuildInfo = model.allBuildInfo[buildId];
            eachBuildInfo.State = !!isCanGradeBuild(buildId)?2:1;
         }
         dispatchEvent(new Event("event_get_consortia_info_res"));
      }
      
      public function enterScene(needEnterAlert:Boolean) : void
      {
         var alert:* = null;
         var alert2:* = null;
         if(model.isActive)
         {
            if(PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               if(needEnterAlert)
               {
                  alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.enterSceneAlert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  alert.addEventListener("response",onEnterSceneResponse);
               }
               else
               {
                  GameInSocketOut.sendSingleRoomBegin(22);
               }
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("demonChiYou.cannotEnter.noConsortia"));
            }
         }
         else
         {
            alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.activityActiveAlert"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            alert2.addEventListener("response",onActivityActiveAlertResponse);
         }
      }
      
      private function onActivityActiveAlertResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onActivityActiveAlertResponse);
         alert.dispose();
      }
      
      private function onEnterSceneResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onEnterSceneResponse);
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               GameInSocketOut.sendSingleRoomBegin(22);
            default:
               GameInSocketOut.sendSingleRoomBegin(22);
         }
         alert.dispose();
      }
      
      private function onSingleRoomBeginRes(evt:Event) : void
      {
         if(RoomManager.Instance.current.type == 150)
         {
            StateManager.setState("consortia_domain");
         }
      }
      
      public function leaveScene() : void
      {
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.leaveSceneAlert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         alert.addEventListener("response",onLeaveSceneResponse);
      }
      
      private function onLeaveSceneResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",onLeaveSceneResponse);
         switch(int(e.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               SocketManager.Instance.out.leaveConsortiaDomainScene();
            default:
               SocketManager.Instance.out.leaveConsortiaDomainScene();
         }
         alert.dispose();
      }
      
      public function onEnterScene() : void
      {
         KeyboardManager.getInstance().addEventListener("keyDown",__onKeyDown);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,9),onGetMonsterInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,10),onGetBuildInfoInFight);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,13),onGetKillInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,1),onRemovePlayer);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,16),onMonsterInfoSingle);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,17),onBuildRepairInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,19),onReduceBloodState);
         ConsortionModelManager.Instance.addEventListener("event_consortia_level_up",onConsortiaBuildLevelUp);
         var consortiaLandBuildBloodInfo:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandBuildBlood"];
         if(consortiaLandBuildBloodInfo != null)
         {
            consortiaLandBuildBlood = int(consortiaLandBuildBloodInfo.Value);
         }
         else
         {
            consortiaLandBuildBlood = 1000;
         }
         var consortiaLandRepairBloodInfo:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandRepairBlood"];
         if(consortiaLandRepairBloodInfo != null)
         {
            consortiaLandRepairBlood = int(consortiaLandRepairBloodInfo.Value);
         }
         else
         {
            consortiaLandRepairBlood = 36000;
         }
         var consortiaLandMonsterSpeedInfo:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandMonsterSpeedInfo"];
         if(consortiaLandMonsterSpeedInfo != null)
         {
            consortiaLandMonsterSpeed = int(consortiaLandMonsterSpeedInfo.Value);
         }
         else
         {
            consortiaLandMonsterSpeed = 10;
         }
         var consortiaLandRepairCountInfo:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandRepairCountInfo"];
         if(consortiaLandRepairCountInfo != null)
         {
            consortiaLandRepairCount = int(consortiaLandRepairCountInfo.Value);
         }
         else
         {
            consortiaLandRepairCount = 50;
         }
         buildNameArr = LanguageMgr.GetTranslation("consortiadomain.buildNameArr").split(",");
         sceneMapGridData = ComponentFactory.Instance.creatCustomObject("consortiadomain.map.SceneMapGridData");
         aStarPathFinder = new AStarPathFinder();
         aStarPathFinder.init(sceneMapGridData);
         _secTickTimer = new Timer(1000,2147483647);
         _secTickTimer.addEventListener("timer",onSecTickTimer);
         _secTickTimer.start();
         StageReferance.stage.addEventListener("resize",onStageResize);
         bgLayerViewRect = new Rectangle();
         bgLayerViewRect.width = StageReferance.stageWidth;
         bgLayerViewRect.height = StageReferance.stageHeight;
         playMusic();
      }
      
      private function __onKeyDown(e:KeyboardEvent) : void
      {
         var _consortionBankFrame:* = null;
         if(e.keyCode == 75 && ConsortiaDomainManager.CAN_USE_K)
         {
            _consortionBankFrame = ComponentFactory.Instance.creatComponentByStylename("consortionBankFrame");
            LayerManager.Instance.addToLayer(_consortionBankFrame,3,true,1);
         }
         else if(e.keyCode == 82 && ConsortiaDomainManager.CAN_USE_R)
         {
            MailManager.Instance.switchVisible();
         }
         else if(e.keyCode == 81 && ConsortiaDomainManager.CAN_USE_Q)
         {
            TaskManager.instance.switchVisible();
         }
      }
      
      public function onLeaveScene() : void
      {
         KeyboardManager.getInstance().removeEventListener("keyDown",__onKeyDown);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,9),onGetMonsterInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,10),onGetBuildInfoInFight);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,13),onGetKillInfo);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,1),onRemovePlayer);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,16),onMonsterInfoSingle);
         SocketManager.Instance.removeEventListener(PkgEvent.format(371,17),onBuildRepairInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(371,19),onReduceBloodState);
         ConsortionModelManager.Instance.removeEventListener("event_consortia_level_up",onConsortiaBuildLevelUp);
         StageReferance.stage.removeEventListener("resize",onStageResize);
         _secTickTimer.removeEventListener("timer",onSecTickTimer);
         _secTickTimer.stop();
         bgLayerViewRect = null;
      }
      
      public function getInfoOnEnterScene() : void
      {
         if(ConsortiaDomainManager.instance.activeState == 0 || ConsortiaDomainManager.instance.activeState == 100)
         {
            SocketManager.Instance.out.getConsortiaDomainConsortiaInfo();
            SocketManager.Instance.out.getConsortiaDomainBuildRepairInfo();
         }
         else if(ConsortiaDomainManager.instance.activeState == 1)
         {
            SocketManager.Instance.out.getConsortiaDomainBuildInfoInFight();
            SocketManager.Instance.out.getConsortiaDomainMonsterInfoInFight();
         }
      }
      
      private function playMusic() : void
      {
         if(activeState == 1)
         {
            SoundManager.instance.playMusic("12018");
         }
         else
         {
            SoundManager.instance.playMusic("062");
         }
      }
      
      private function onRemovePlayer(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         var leavePlayerId:int = pkg.readInt();
         if(PlayerManager.Instance.Self.ID == leavePlayerId)
         {
            if(StateManager.currentStateType == "consortia_domain")
            {
               StateManager.setState("main");
            }
         }
         else
         {
            dispatchEvent(new CEvent("event_remove_other_player",leavePlayerId));
         }
      }
      
      public function getIntersectionPoint(circleX:int, circleY:int, circleR:int, linePointX:*, linePointY:*) : Point
      {
         var dis:int = (circleX - linePointX) * (circleX - linePointX) + (circleY - linePointY) * (circleY - linePointY);
         if(dis <= circleR * circleR)
         {
            return null;
         }
         if(linePointX == circleX)
         {
            if(linePointY > circleY)
            {
               return new Point(circleX,circleY + circleR);
            }
            return new Point(circleX,circleY - circleR);
         }
         var angle:Number = Math.atan2(linePointY - circleY,linePointX - circleX);
         var cosValue:Number = Math.cos(angle);
         var sinValue:Number = Math.sin(angle);
         return new Point(circleX + cosValue * circleR,circleY + sinValue * circleR);
      }
      
      public function getBuildViewUpGradeBtnTexture() : Texture
      {
         var bmd:* = null;
         if(!_buildViewUpGradeBtnTexture)
         {
            if(!_bulidViewBtn)
            {
               _bulidViewBtn = UICreatShortcut.creatAndAdd("consortiadomain.buildView.openBtn");
            }
            _bulidViewBtn.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.okLabel");
            bmd = new BitmapData(_bulidViewBtn.width,_bulidViewBtn.height,true,0);
            bmd.draw(_bulidViewBtn);
            _buildViewUpGradeBtnTexture = Texture.fromBitmapData(bmd,true);
            bmd.dispose();
         }
         return _buildViewUpGradeBtnTexture;
      }
      
      public function getBuildViewOpenBtnTexture() : Texture
      {
         var bmd:* = null;
         if(!_buildViewOpenBtnTexture)
         {
            if(!_bulidViewBtn)
            {
               _bulidViewBtn = UICreatShortcut.creatAndAdd("consortiadomain.buildView.openBtn");
            }
            _bulidViewBtn.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.openLabel");
            bmd = new BitmapData(_bulidViewBtn.width,_bulidViewBtn.height,true,0);
            bmd.draw(_bulidViewBtn);
            _buildViewOpenBtnTexture = Texture.fromBitmapData(bmd,true);
            bmd.dispose();
         }
         return _buildViewOpenBtnTexture;
      }
      
      public function disposeBuildViewBtn() : void
      {
         ObjectUtils.disposeObject(_bulidViewBtn);
         _bulidViewBtn = null;
         _buildViewOpenBtnTexture && _buildViewOpenBtnTexture.dispose();
         _buildViewOpenBtnTexture = null;
         _buildViewUpGradeBtnTexture && _buildViewUpGradeBtnTexture.dispose();
         _buildViewUpGradeBtnTexture = null;
      }
      
      public function initHall(hall:IHallStateView) : void
      {
         _hall = hall;
         checkIcon();
      }
      
      public function checkIcon() : void
      {
      }
      
      public function deleteIcon() : void
      {
      }
   }
}
