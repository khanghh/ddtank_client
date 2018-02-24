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
      
      public function ConsortiaDomainManager(param1:IEventDispatcher = null){super();}
      
      public static function get instance() : ConsortiaDomainManager{return null;}
      
      public function setup() : void{}
      
      public function askActiveSate() : void{}
      
      private function onActiveSate(param1:PkgEvent) : void{}
      
      private function onActiveOpenAleartResponse(param1:FrameEvent) : void{}
      
      private function onActive(param1:PkgEvent) : void{}
      
      private function onGetKillInfo(param1:PkgEvent) : void{}
      
      protected function onSecTickTimer(param1:TimerEvent) : void{}
      
      public function isAllBuildFullHp() : Boolean{return false;}
      
      private function onStageResize(param1:Event) : void{}
      
      private function initFightBuildInfo(param1:int, param2:PackageIn) : void{}
      
      private function initUnFightBuildInfo(param1:int, param2:PackageIn) : void{}
      
      public function isCanGradeBuild(param1:int) : Boolean{return false;}
      
      public function getBuildLv(param1:int) : int{return 0;}
      
      private function checkGoldOrLevel(param1:int) : Boolean{return false;}
      
      private function onGetMonsterInfo(param1:PkgEvent) : void{}
      
      private function monsterStateSeverToClient(param1:int) : int{return 0;}
      
      private function readMonsterInfoSingle(param1:PackageIn) : EachMonsterInfo{return null;}
      
      private function onMonsterInfoSingle(param1:PkgEvent) : void{}
      
      private function onGetBuildInfoInFight(param1:PkgEvent) : void{}
      
      private function onGetConsortiaInfo(param1:PkgEvent) : void{}
      
      private function getFixUnFightBuildState(param1:int, param2:int, param3:int) : int{return 0;}
      
      private function onBuildRepairInfo(param1:PkgEvent) : void{}
      
      private function onReduceBloodState(param1:PkgEvent) : void{}
      
      private function onConsortiaBuildLevelUp(param1:Event) : void{}
      
      public function enterScene(param1:Boolean) : void{}
      
      private function onActivityActiveAlertResponse(param1:FrameEvent) : void{}
      
      private function onEnterSceneResponse(param1:FrameEvent) : void{}
      
      private function onSingleRoomBeginRes(param1:Event) : void{}
      
      public function leaveScene() : void{}
      
      private function onLeaveSceneResponse(param1:FrameEvent) : void{}
      
      public function onEnterScene() : void{}
      
      private function __onKeyDown(param1:KeyboardEvent) : void{}
      
      public function onLeaveScene() : void{}
      
      public function getInfoOnEnterScene() : void{}
      
      private function playMusic() : void{}
      
      private function onRemovePlayer(param1:PkgEvent) : void{}
      
      public function getIntersectionPoint(param1:int, param2:int, param3:int, param4:*, param5:*) : Point{return null;}
      
      public function getBuildViewUpGradeBtnTexture() : Texture{return null;}
      
      public function getBuildViewOpenBtnTexture() : Texture{return null;}
      
      public function disposeBuildViewBtn() : void{}
      
      public function initHall(param1:IHallStateView) : void{}
      
      public function checkIcon() : void{}
      
      public function deleteIcon() : void{}
   }
}
