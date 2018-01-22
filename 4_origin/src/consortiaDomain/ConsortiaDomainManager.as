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
      
      public function ConsortiaDomainManager(param1:IEventDispatcher = null)
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
      
      private function onActiveSate(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         if(activeState != _loc2_)
         {
            activeState = _loc2_;
            checkIcon();
         }
         _hasAskActiveSate = true;
         var _loc6_:* = StateManager.currentStateType == "consortia_domain";
         if(activeState == 1)
         {
            _loc5_ = new ChatData();
            _loc5_.channel = 3;
            _loc5_.type = 113;
            _loc5_.msg = LanguageMgr.GetTranslation("consortiadomain.clickChatLinkEnterScene");
            ChatManager.Instance.chat(_loc5_);
            if(StateManager.currentStateType != "fighting" && StateManager.currentStateType != "gameLoading" && !_loc6_)
            {
               _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.activeOpenAleart"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _loc3_.addEventListener("response",onActiveOpenAleartResponse);
            }
         }
         if(_loc6_)
         {
            playMusic();
         }
         dispatchEvent(new Event("event_active_state_change"));
      }
      
      private function onActiveOpenAleartResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onActiveOpenAleartResponse);
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               enterScene(false);
            default:
               enterScene(false);
         }
         _loc2_.dispose();
      }
      
      private function onActive(param1:PkgEvent) : void
      {
         model.isActive = true;
         dispatchEvent(new Event("event_active_res"));
      }
      
      private function onGetKillInfo(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         model.killRankArr = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = {};
            _loc4_["UserID"] = _loc3_.readInt();
            _loc4_["NickName"] = _loc3_.readUTF();
            _loc4_["KillCount"] = _loc3_.readInt();
            model.killRankArr.push(_loc4_);
            _loc5_++;
         }
         model.killRankArr.sortOn("KillCount",2 | 16);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = model.killRankArr[_loc5_];
            _loc4_["Rank"] = _loc5_ + 1;
            if(_loc4_["UserID"] == PlayerManager.Instance.Self.ID)
            {
               model.myRank = _loc4_["Rank"];
               model.myKillNum = _loc4_["KillCount"];
            }
            _loc5_++;
         }
         dispatchEvent(new Event("event_kill_rank_update"));
      }
      
      protected function onSecTickTimer(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
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
         var _loc3_:* = -1;
         if(ConsortiaDomainManager.instance.activeState == 1)
         {
            if(ConsortiaDomainManager.instance.model.monsterBornArr && ConsortiaDomainManager.instance.model.BeginTime)
            {
               _loc4_ = (TimeManager.Instance.NowTime() - ConsortiaDomainManager.instance.model.BeginTime.time) / 1000;
               _loc2_ = ConsortiaDomainManager.instance.model.monsterBornArr;
               _loc6_ = model.monsterWaveIndex + 1;
               while(_loc6_ < _loc2_.length)
               {
                  _loc5_ = _loc2_[_loc6_];
                  if(_loc5_ > _loc4_)
                  {
                     _loc3_ = _loc6_;
                  }
                  _loc6_++;
               }
            }
         }
         if(_loc3_ > model.monsterWaveIndex)
         {
            model.monsterWaveIndex = _loc3_;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortiadomain.monsterIsComing"));
            dispatchEvent(new Event("event_monster_born"));
         }
      }
      
      public function isAllBuildFullHp() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = model.allBuildInfo;
         for each(var _loc1_ in model.allBuildInfo)
         {
            if(_loc1_.Repair != 0)
            {
               return false;
            }
         }
         return true;
      }
      
      private function onStageResize(param1:Event) : void
      {
         bgLayerViewRect.width = StageReferance.stageWidth;
         bgLayerViewRect.height = StageReferance.stageHeight;
         dispatchEvent(new Event("resize"));
      }
      
      private function initFightBuildInfo(param1:int, param2:PackageIn) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:EachBuildInfo = model.allBuildInfo[param1];
         if(!_loc3_)
         {
            _loc3_ = new EachBuildInfo();
            _loc3_.Id = param1;
            model.allBuildInfo[param1] = _loc3_;
         }
         _loc3_.Id = param1;
         _loc3_.Blood = param2.readInt();
         _loc3_.State = param2.readInt();
         if(_loc3_.State == 1)
         {
            _loc3_.State = 6;
         }
         else
         {
            _loc3_.State = 5;
         }
         var _loc4_:* = -1;
         _loc6_ = 0;
         while(_loc6_ < BUILD_LOW_HP_WARN_ARR.length)
         {
            if(_loc3_.Blood < BUILD_LOW_HP_WARN_ARR[_loc6_] * consortiaLandBuildBlood && !_loc3_.lowHpWarnArr[_loc6_])
            {
               _loc3_.lowHpWarnArr[_loc6_] = true;
               _loc4_ = Number(BUILD_LOW_HP_WARN_ARR[_loc6_]);
            }
            _loc6_++;
         }
         if(_loc4_ != -1)
         {
            _loc5_ = LanguageMgr.GetTranslation("consortiadomain.build.lowHp",buildNameArr[param1],int(_loc4_ * 100));
            ChatManager.Instance.sysChatConsortia(_loc5_);
            MessageTipManager.getInstance().show(_loc5_);
         }
      }
      
      private function initUnFightBuildInfo(param1:int, param2:PackageIn) : void
      {
         var _loc3_:EachBuildInfo = model.allBuildInfo[param1];
         if(!_loc3_)
         {
            _loc3_ = new EachBuildInfo();
            _loc3_.Id = param1;
            model.allBuildInfo[param1] = _loc3_;
         }
         if(param1 == 5)
         {
            _loc3_.Repair = 0;
            _loc3_.State = 0;
         }
         else if(param2 != null)
         {
            _loc3_.Repair = param2.readInt();
            _loc3_.State = param2.readInt();
            if(_loc3_.Repair == 0)
            {
               _loc3_.State = 0;
            }
         }
         _loc3_.State = getFixUnFightBuildState(param1,_loc3_.State,_loc3_.Repair);
      }
      
      public function isCanGradeBuild(param1:int) : Boolean
      {
         if(param1 == 5)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(0) && checkGoldOrLevel(0);
         }
         if(param1 == 4)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(1) && checkGoldOrLevel(1);
         }
         if(param1 == 3)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(2) && checkGoldOrLevel(2);
         }
         if(param1 == 1)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(3) && checkGoldOrLevel(3);
         }
         if(param1 == 2)
         {
            return ConsortionModelManager.Instance.model.checkConsortiaRichesForUpGrade(4) && checkGoldOrLevel(4);
         }
         return false;
      }
      
      public function getBuildLv(param1:int) : int
      {
         if(param1 == 5)
         {
            return PlayerManager.Instance.Self.consortiaInfo.Level;
         }
         if(param1 == 3)
         {
            return PlayerManager.Instance.Self.consortiaInfo.ShopLevel;
         }
         if(param1 == 4)
         {
            return PlayerManager.Instance.Self.consortiaInfo.SmithLevel;
         }
         if(param1 == 1)
         {
            return PlayerManager.Instance.Self.consortiaInfo.StoreLevel;
         }
         if(param1 == 2)
         {
            return PlayerManager.Instance.Self.consortiaInfo.BufferLevel;
         }
         return 0;
      }
      
      private function checkGoldOrLevel(param1:int) : Boolean
      {
         switch(int(param1))
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
         if(param1 == 0 && PlayerManager.Instance.Self.Gold < ConsortionModelManager.Instance.model.getLevelData(PlayerManager.Instance.Self.consortiaInfo.Level + 1).NeedGold)
         {
            return false;
         }
         return true;
      }
      
      private function onGetMonsterInfo(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc7_:int = _loc4_.readInt();
         model.monsterBornArr = [];
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            _loc3_ = _loc4_.readInt();
            _loc8_ = monsterStateSeverToClient(_loc3_);
            _loc2_ = _loc4_.readInt();
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc5_ = readMonsterInfoSingle(_loc4_);
               _loc5_.state = _loc8_;
               _loc5_.serverMonsterState = _loc3_;
               if(model.monsterBornArr.indexOf(_loc5_.BirthSecond) == -1)
               {
                  model.monsterBornArr.push(_loc5_.BirthSecond);
               }
               _loc6_++;
            }
            _loc9_++;
         }
         model.monsterBornArr.sort(16);
         dispatchEvent(new Event("event_monster_state_change"));
      }
      
      private function monsterStateSeverToClient(param1:int) : int
      {
         var _loc2_:int = 2147483647;
         if(param1 == -6)
         {
            _loc2_ = 1;
         }
         else if(param1 == -1)
         {
            _loc2_ = 100;
         }
         else if(param1 == -2 || param1 == -3)
         {
            _loc2_ = 3;
         }
         else if(param1 == -4)
         {
            _loc2_ = 5;
         }
         else if(param1 == -5)
         {
            _loc2_ = 6;
         }
         else if(param1 > 0)
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      private function readMonsterInfoSingle(param1:PackageIn) : EachMonsterInfo
      {
         var _loc3_:int = param1.readInt();
         var _loc2_:EachMonsterInfo = model.monsterInfo[_loc3_];
         if(!_loc2_)
         {
            _loc2_ = new EachMonsterInfo();
            _loc2_.LivingID = _loc3_;
            model.monsterInfo[_loc3_] = _loc2_;
         }
         _loc2_.LastTargetID = _loc2_.TargetID;
         _loc2_.TargetID = param1.readInt();
         _loc2_.Type = param1.readInt();
         _loc2_.BeginSecond = param1.readInt();
         _loc2_.BirthSecond = param1.readInt();
         _loc2_.FightID = param1.readInt();
         _loc2_.posX = param1.readInt();
         _loc2_.posY = param1.readInt();
         return _loc2_;
      }
      
      private function onMonsterInfoSingle(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc5_:int = monsterStateSeverToClient(_loc2_);
         var _loc4_:EachMonsterInfo = readMonsterInfoSingle(_loc3_);
         _loc4_.state = _loc5_;
         _loc4_.serverMonsterState = _loc2_;
         dispatchEvent(new CEvent("event_monster_info_single",_loc4_));
      }
      
      private function onGetBuildInfoInFight(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _loc2_.readBoolean();
         _loc2_.readDate();
         initFightBuildInfo(1,_loc2_);
         initFightBuildInfo(2,_loc2_);
         initFightBuildInfo(3,_loc2_);
         initFightBuildInfo(4,_loc2_);
         initFightBuildInfo(5,_loc2_);
         dispatchEvent(new Event("event_build_in_fight_state_change"));
      }
      
      private function onGetConsortiaInfo(param1:PkgEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc4_.readBoolean();
         if(_loc3_)
         {
            model.isActive = _loc4_.readInt() == 0?false:true;
            model.BeginTime = _loc4_.readDate();
            initUnFightBuildInfo(1,_loc4_);
            initUnFightBuildInfo(2,_loc4_);
            initUnFightBuildInfo(3,_loc4_);
            initUnFightBuildInfo(4,_loc4_);
            initUnFightBuildInfo(5,null);
            model.EndTime = _loc4_.readDate();
            _loc2_ = new Date();
            _loc2_.time = model.EndTime.time + 172800000;
            model.autoRepairCompleteTime = _loc2_;
         }
         else
         {
            model.isActive = false;
         }
         dispatchEvent(new Event("event_get_consortia_info_res"));
      }
      
      private function getFixUnFightBuildState(param1:int, param2:int, param3:int) : int
      {
         if(param2 == 0)
         {
            if(param3 == 0)
            {
               return !!isCanGradeBuild(param1)?2:1;
            }
            return 4;
         }
         if(param2 == 1)
         {
            return 3;
         }
         return 0;
      }
      
      private function onBuildRepairInfo(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc3_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = _loc5_.readInt();
            _loc2_ = model.allBuildInfo[_loc4_];
            if(!_loc2_)
            {
               _loc2_ = new EachBuildInfo();
               _loc2_.Id = _loc4_;
               model.allBuildInfo[_loc4_] = _loc2_;
            }
            _loc2_.repairPlayerNum = _loc5_.readInt();
            _loc6_++;
         }
         dispatchEvent(new Event("event_repair_player_num_change"));
      }
      
      private function onReduceBloodState(param1:PkgEvent) : void
      {
         var _loc5_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc4_:int = _loc3_.readInt();
         var _loc2_:int = _loc3_.readInt();
         if(_loc4_ == 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("consortiadomain.buildFirstBeBeat",buildNameArr[_loc2_]);
         }
         else if(_loc4_ == 1)
         {
            _loc5_ = LanguageMgr.GetTranslation("consortiadomain.build1MinBeBeat",buildNameArr[_loc2_]);
         }
         ChatManager.Instance.sysChatConsortia(_loc5_);
         MessageTipManager.getInstance().show(_loc5_);
      }
      
      private function onConsortiaBuildLevelUp(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [1,2,3,4,5];
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = model.allBuildInfo[_loc4_];
            _loc2_.State = !!isCanGradeBuild(_loc4_)?2:1;
         }
         dispatchEvent(new Event("event_get_consortia_info_res"));
      }
      
      public function enterScene(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(model.isActive)
         {
            if(PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               if(param1)
               {
                  _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.enterSceneAlert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                  _loc2_.addEventListener("response",onEnterSceneResponse);
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
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.activityActiveAlert"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
            _loc3_.addEventListener("response",onActivityActiveAlertResponse);
         }
      }
      
      private function onActivityActiveAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onActivityActiveAlertResponse);
         _loc2_.dispose();
      }
      
      private function onEnterSceneResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onEnterSceneResponse);
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               GameInSocketOut.sendSingleRoomBegin(22);
            default:
               GameInSocketOut.sendSingleRoomBegin(22);
         }
         _loc2_.dispose();
      }
      
      private function onSingleRoomBeginRes(param1:Event) : void
      {
         if(RoomManager.Instance.current.type == 150)
         {
            StateManager.setState("consortia_domain");
         }
      }
      
      public function leaveScene() : void
      {
         var _loc1_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("consortiadomain.leaveSceneAlert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
         _loc1_.addEventListener("response",onLeaveSceneResponse);
      }
      
      private function onLeaveSceneResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",onLeaveSceneResponse);
         switch(int(param1.responseCode))
         {
            default:
            default:
            case 2:
            case 3:
               SocketManager.Instance.out.leaveConsortiaDomainScene();
            default:
               SocketManager.Instance.out.leaveConsortiaDomainScene();
         }
         _loc2_.dispose();
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
         var _loc2_:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandBuildBlood"];
         if(_loc2_ != null)
         {
            consortiaLandBuildBlood = int(_loc2_.Value);
         }
         else
         {
            consortiaLandBuildBlood = 1000;
         }
         var _loc1_:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandRepairBlood"];
         if(_loc1_ != null)
         {
            consortiaLandRepairBlood = int(_loc1_.Value);
         }
         else
         {
            consortiaLandRepairBlood = 36000;
         }
         var _loc4_:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandMonsterSpeedInfo"];
         if(_loc4_ != null)
         {
            consortiaLandMonsterSpeed = int(_loc4_.Value);
         }
         else
         {
            consortiaLandMonsterSpeed = 10;
         }
         var _loc3_:ServerConfigInfo = ServerConfigManager.instance.serverConfigInfo["ConsortiaLandRepairCountInfo"];
         if(_loc3_ != null)
         {
            consortiaLandRepairCount = int(_loc3_.Value);
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
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = null;
         if(param1.keyCode == 75 && ConsortiaDomainManager.CAN_USE_K)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("consortionBankFrame");
            LayerManager.Instance.addToLayer(_loc2_,3,true,1);
         }
         else if(param1.keyCode == 82 && ConsortiaDomainManager.CAN_USE_R)
         {
            MailManager.Instance.switchVisible();
         }
         else if(param1.keyCode == 81 && ConsortiaDomainManager.CAN_USE_Q)
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
      
      private function onRemovePlayer(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(PlayerManager.Instance.Self.ID == _loc2_)
         {
            if(StateManager.currentStateType == "consortia_domain")
            {
               StateManager.setState("main");
            }
         }
         else
         {
            dispatchEvent(new CEvent("event_remove_other_player",_loc2_));
         }
      }
      
      public function getIntersectionPoint(param1:int, param2:int, param3:int, param4:*, param5:*) : Point
      {
         var _loc7_:int = (param1 - param4) * (param1 - param4) + (param2 - param5) * (param2 - param5);
         if(_loc7_ <= param3 * param3)
         {
            return null;
         }
         if(param4 == param1)
         {
            if(param5 > param2)
            {
               return new Point(param1,param2 + param3);
            }
            return new Point(param1,param2 - param3);
         }
         var _loc9_:Number = Math.atan2(param5 - param2,param4 - param1);
         var _loc8_:Number = Math.cos(_loc9_);
         var _loc6_:Number = Math.sin(_loc9_);
         return new Point(param1 + _loc8_ * param3,param2 + _loc6_ * param3);
      }
      
      public function getBuildViewUpGradeBtnTexture() : Texture
      {
         var _loc1_:* = null;
         if(!_buildViewUpGradeBtnTexture)
         {
            if(!_bulidViewBtn)
            {
               _bulidViewBtn = UICreatShortcut.creatAndAdd("consortiadomain.buildView.openBtn");
            }
            _bulidViewBtn.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.okLabel");
            _loc1_ = new BitmapData(_bulidViewBtn.width,_bulidViewBtn.height,true,0);
            _loc1_.draw(_bulidViewBtn);
            _buildViewUpGradeBtnTexture = Texture.fromBitmapData(_loc1_,true);
            _loc1_.dispose();
         }
         return _buildViewUpGradeBtnTexture;
      }
      
      public function getBuildViewOpenBtnTexture() : Texture
      {
         var _loc1_:* = null;
         if(!_buildViewOpenBtnTexture)
         {
            if(!_bulidViewBtn)
            {
               _bulidViewBtn = UICreatShortcut.creatAndAdd("consortiadomain.buildView.openBtn");
            }
            _bulidViewBtn.text = LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaUpgrade.openLabel");
            _loc1_ = new BitmapData(_bulidViewBtn.width,_bulidViewBtn.height,true,0);
            _loc1_.draw(_bulidViewBtn);
            _buildViewOpenBtnTexture = Texture.fromBitmapData(_loc1_,true);
            _loc1_.dispose();
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
      
      public function initHall(param1:IHallStateView) : void
      {
         _hall = param1;
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
