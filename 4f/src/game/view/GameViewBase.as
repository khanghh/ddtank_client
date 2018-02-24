package game.view
{
   import bagAndInfo.BagAndInfoManager;
   import bagAndInfo.bag.ring.data.RingSystemData;
   import bagAndInfo.info.PlayerInfoViewControl;
   import bombKing.BombKingManager;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.data.map.MissionInfo;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.DungeonInfoEvent;
   import ddt.events.GameEvent;
   import ddt.events.LivingEvent;
   import ddt.manager.BallManager;
   import ddt.manager.BitmapManager;
   import ddt.manager.ChatManager;
   import ddt.manager.IMEManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.PolarRegionManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.states.BaseStateView;
   import ddt.utils.Helpers;
   import ddt.utils.MenoryUtil;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.GameCharacter;
   import ddt.view.character.ICharacter;
   import ddt.view.character.ShowCharacter;
   import ddt.view.chat.ChatBugleView;
   import ddt.view.chat.chatBall.ChatBallBoss;
   import ddt.view.rescue.RescueRoomItemView;
   import ddt.view.rescue.RescueScoreAlertView;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   import game.GameDecorateManager;
   import game.actions.ViewEachPlayerAction;
   import game.objects.GameLiving;
   import game.objects.GameLocalPlayer;
   import game.objects.GamePlayer;
   import game.view.heroAuto.HeroAutoView;
   import game.view.map.MapView;
   import gameCommon.BloodNumberCreater;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   import gameCommon.GameMessageTipManager;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.LocalPlayer;
   import gameCommon.model.Player;
   import gameCommon.model.SmallEnemy;
   import gameCommon.model.TurnedLiving;
   import gameCommon.view.AthleticsHelpView;
   import gameCommon.view.DamageView;
   import gameCommon.view.DungeonHelpView;
   import gameCommon.view.DungeonInfoView;
   import gameCommon.view.FightAchievBar;
   import gameCommon.view.GameCountDownView;
   import gameCommon.view.GameTrusteeshipView;
   import gameCommon.view.LeftPlayerCartoonView;
   import gameCommon.view.SelfMarkBar;
   import gameCommon.view.VaneView;
   import gameCommon.view.buff.SelfBuffBar;
   import gameCommon.view.control.ControlState;
   import gameCommon.view.control.FightControlBar;
   import gameCommon.view.control.LiveState;
   import gameCommon.view.playerThumbnail.PlayerThumbnailController;
   import gameCommon.view.propContainer.PlayerStateContainer;
   import kingBless.KingBlessManager;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import phy.math.EulerVector;
   import pvePowerBuff.PvePowerBuffManager;
   import rescue.data.RescueRoomInfo;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import road7th.data.StringObject;
   import road7th.utils.MovieClipWrapper;
   import room.RoomManager;
   import room.model.RoomPlayer;
   import trainer.controller.NewHandGuideManager;
   import trainer.controller.WeakGuildManager;
   import worldboss.WorldBossManager;
   
   public class GameViewBase extends BaseStateView
   {
       
      
      protected var _arrowLeft:SpringArrowView;
      
      protected var _arrowRight:SpringArrowView;
      
      protected var _arrowUp:SpringArrowView;
      
      protected var _arrowDown:SpringArrowView;
      
      protected var _selfUsedProp:PlayerStateContainer;
      
      protected var _leftPlayerView:LeftPlayerCartoonView;
      
      protected var _missionHelp:DungeonHelpView;
      
      protected var _fightControlBar:FightControlBar;
      
      protected var _cs:ControlState;
      
      protected var _vane:VaneView;
      
      protected var _playerThumbnailLController:PlayerThumbnailController;
      
      protected var _map:MapView;
      
      protected var _smallMapBorderBg:Bitmap;
      
      protected var _players:Dictionary;
      
      protected var _gameInfo:GameInfo;
      
      protected var _selfGamePlayer:GameLocalPlayer;
      
      protected var _selfBuffBar:SelfBuffBar;
      
      protected var _selfMarkBar:SelfMarkBar;
      
      protected var _achievBar:FightAchievBar;
      
      protected var _bitmapMgr:BitmapManager;
      
      private var _buffIconBox:HBox;
      
      protected var _kingblessIcon:Image;
      
      protected var _trialBuffIcon:Image;
      
      protected var _ringSkillIcon:Image;
      
      protected var _guardCoreIcon:Image;
      
      protected var _gameTrusteeshipView:GameTrusteeshipView;
      
      protected var _heroAutoView:HeroAutoView;
      
      protected var _gameCountDownView:GameCountDownView;
      
      private var _damageView:DamageView;
      
      private var _rescueRoomItemView:RescueRoomItemView;
      
      protected var _rescueScoreView:RescueScoreAlertView;
      
      protected var _sceneEffectsBar:SceneEffectsBar;
      
      private var _messageBtn:BaseButton;
      
      private var _pirateBall:ChatBallBoss;
      
      public var explorersLiving:Living;
      
      private var buffIcon:Image;
      
      private var buffTxt:FilterFrameText;
      
      protected var _weatherView:GameWeatherView;
      
      protected var _barrier:DungeonInfoView;
      
      private const GUIDEID:int = 10029;
      
      protected var _barrierVisible:Boolean = true;
      
      private var _self:LocalPlayer;
      
      private var _level:int;
      
      private var _gameLiving:GameLiving;
      
      private var _selfGameLiving:GamePlayer;
      
      private var _allLivings:DictionaryData;
      
      private var _mass:Number = 10;
      
      private var _gravityFactor:Number = 70;
      
      protected var _windFactor:Number = 240;
      
      private var _powerRef:Number = 1;
      
      private var _reangle:Number = 0;
      
      private var _dt:Number = 0.04;
      
      private var _arf:Number;
      
      private var _gf:Number;
      
      private var _ga:Number;
      
      private var _mapWind:Number = 0;
      
      private var _wa:Number;
      
      private var _ef:Point;
      
      private var _shootAngle:Number;
      
      private var _state:Boolean = false;
      
      private var _useAble:Boolean = false;
      
      private var _stateFlag:int;
      
      private var _currentLivID:int;
      
      private var _collideRect:Rectangle;
      
      private var _drawRoute:Sprite;
      
      public function GameViewBase(){super();}
      
      override public function prepare() : void{}
      
      override public function fadingComplete() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function addSmallMapBg() : Bitmap{return null;}
      
      protected function creatWeatherView() : void{}
      
      protected function __addRescueScore(param1:CrazyTankSocketEvent) : void{}
      
      private function setScoreViewInvisible() : void{}
      
      protected function __updateRescueItemInfo(param1:CrazyTankSocketEvent) : void{}
      
      public function addMessageBtn() : void{}
      
      protected function __onMessageClick(param1:MouseEvent) : void{}
      
      private function initGameCountDownView() : void{}
      
      private function isShowTrusteeship() : Boolean{return false;}
      
      public function updateDamageView() : void{}
      
      protected function kingBlessIconInit() : void{}
      
      private function trialBuffIconInit() : void{}
      
      private function addRingSkillIcon() : void{}
      
      protected function updateGuardCoreIcon() : void{}
      
      private function setSkillTipData(param1:Image) : void{}
      
      private function resetPlayerCharacters() : void{}
      
      protected function __wishClick(param1:Event) : void{}
      
      protected function __selfDie(param1:LivingEvent) : void{}
      
      protected function drawMissionInfo() : void{}
      
      public function testHelpOpen() : void{}
      
      public function testHelpClose(param1:Rectangle) : void{}
      
      protected function __updateSmallMapView(param1:GameEvent) : void{}
      
      protected function __dungeonHelpChanged(param1:GameEvent) : void{}
      
      protected function __dungeonVisibleChanged(param1:DungeonInfoEvent) : void{}
      
      private function __onMissonHelpClick(param1:MouseEvent) : void{}
      
      protected function initEvent() : void{}
      
      private function __selfBuffBarUpdateCellHandler(param1:CEvent) : void{}
      
      private function addPlayerHander(param1:DictionaryEvent) : void{}
      
      protected function loadWeakGuild() : void{}
      
      private function isWishGuideLoad() : Boolean{return false;}
      
      private function propOpenShow(param1:String) : void{}
      
      protected function newMap() : MapView{return null;}
      
      private function __soundChange(param1:Event) : void{}
      
      public function restoreSmallMap() : void{}
      
      protected function disposeUI() : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function dispose() : void{}
      
      protected function setupGameData() : void{}
      
      protected function __onAddRingAnimation(param1:GameEvent) : void{}
      
      protected function __onAddGuardCoreAnimation(param1:GameEvent) : void{}
      
      protected function setProperty(param1:GameLiving, param2:String, param3:String) : void{}
      
      private function initDiePlayer() : void{}
      
      private function removeGameData() : void{}
      
      public function addLiving(param1:Living) : void{}
      
      private function updatePlayerState(param1:Living) : void{}
      
      public function setCurrentPlayer(param1:Living) : void{}
      
      private function updateBuffIconBoxPos() : void{}
      
      public function updateControlBarState(param1:Living) : void{}
      
      protected function setPropBarClickEnable(param1:Boolean, param2:Boolean) : void{}
      
      protected function gameOver() : void{}
      
      protected function set barrierInfo(param1:CrazyTankSocketEvent) : void{}
      
      protected function set arrowHammerEnable(param1:Boolean) : void{}
      
      public function blockHammer() : void{}
      
      public function allowHammer() : void{}
      
      protected function defaultForbidDragFocus() : void{}
      
      protected function setBarrierVisible(param1:Boolean) : void{}
      
      protected function setVaneVisible(param1:Boolean) : void{}
      
      protected function setPlayerThumbVisible(param1:Boolean) : void{}
      
      protected function setEnergyVisible(param1:Boolean) : void{}
      
      public function setRecordRotation() : void{}
      
      public function get map() : *{return null;}
      
      protected function set mapWind(param1:Number) : void{}
      
      public function get currentLivID() : int{return 0;}
      
      public function set currentLivID(param1:int) : void{}
      
      private function showFightPower() : void{}
      
      private function wishInit() : void{}
      
      private function wishRemoveEvent() : void{}
      
      private function __useRescueKingBless(param1:CrazyTankSocketEvent) : void{}
      
      protected function __KeyDown(param1:KeyboardEvent) : void{}
      
      protected function showShoot() : void{}
      
      protected function judgeMaxPower(param1:Point, param2:Point, param3:Number, param4:Boolean, param5:Boolean) : Boolean{return false;}
      
      protected function getPower(param1:Number, param2:Number, param3:Point, param4:Point, param5:Number, param6:Boolean, param7:Boolean) : Number{return 0;}
      
      protected function ifHit(param1:Number, param2:Number, param3:Point) : Boolean{return false;}
      
      private function isOutOfMap(param1:EulerVector, param2:EulerVector) : Boolean{return false;}
      
      private function drawRouteLine(param1:int) : void{}
      
      private function getRouteData(param1:Number, param2:Number, param3:Point, param4:Point) : Vector.<Point>{return null;}
      
      public function drawDashed(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:Number) : void{}
      
      private function drawArrow(param1:Graphics, param2:Point, param3:Point, param4:Number, param5:int) : void{}
      
      protected function __playerChange(param1:CrazyTankSocketEvent) : void{}
      
      private function __playerExit(param1:Event) : void{}
      
      protected function __changeAngle(param1:LivingEvent) : void{}
      
      protected function __wishofdd(param1:CrazyTankSocketEvent) : void{}
      
      private function __thumbnailControlHandle(param1:GameEvent) : void{}
      
      private function calculateRecent() : int{return 0;}
      
      private function getDistance(param1:Point, param2:Point) : int{return 0;}
      
      public function get barrier() : DungeonInfoView{return null;}
      
      public function get messageBtn() : BaseButton{return null;}
   }
}
