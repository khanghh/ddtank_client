package gameStarling.view{   import bagAndInfo.BagAndInfoManager;   import bagAndInfo.bag.ring.data.RingSystemData;   import bagAndInfo.info.PlayerInfoViewControl;   import bombKing.BombKingManager;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.container.HBox;   import com.pickgliss.ui.image.Image;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import com.pickgliss.utils.StarlingObjectUtils;   import consortion.ConsortionModelManager;   import consortion.data.ConsortionSkillInfo;   import ddt.data.map.MissionInfo;   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.DungeonInfoEvent;   import ddt.events.GameEvent;   import ddt.events.LivingEvent;   import ddt.manager.BallManager;   import ddt.manager.BitmapManager;   import ddt.manager.ChatManager;   import ddt.manager.IMEManager;   import ddt.manager.IMManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.PolarRegionManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.states.BaseStateView;   import ddt.utils.Helpers;   import ddt.utils.MenoryUtil;   import ddt.utils.PositionUtils;   import ddt.view.MainToolBar;   import ddt.view.character.CharactoryFactory;   import ddt.view.character.ICharacter;   import ddt.view.character.ShowCharacter;   import ddt.view.characterStarling.GameCharacter3D;   import ddt.view.chat.ChatBugleView;   import ddt.view.chat.chatBall.ChatBallBoss;   import ddt.view.rescue.RescueRoomItemView;   import ddt.view.rescue.RescueScoreAlertView;   import flash.display.Bitmap;   import flash.display.Graphics;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.media.SoundTransform;   import flash.system.IME;   import flash.text.TextField;   import flash.utils.setTimeout;   import game.GameDecorateManager;   import game.view.heroAuto.HeroAutoView;   import gameCommon.BuffManager;   import gameCommon.GameControl;   import gameCommon.GameMessageTipManager;   import gameCommon.model.GameInfo;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.Player;   import gameCommon.model.SmallEnemy;   import gameCommon.model.TurnedLiving;   import gameCommon.view.DamageView;   import gameCommon.view.DungeonHelpView;   import gameCommon.view.DungeonInfoView;   import gameCommon.view.FightAchievBar;   import gameCommon.view.GameCountDownView;   import gameCommon.view.GameTrusteeshipView;   import gameCommon.view.LeftPlayerCartoonView;   import gameCommon.view.SelfMarkBar;   import gameCommon.view.VaneView;   import gameCommon.view.buff.SelfBuffBar;   import gameCommon.view.control.ControlState;   import gameCommon.view.control.FightControlBar;   import gameCommon.view.control.LiveState;   import gameCommon.view.playerThumbnail.PlayerThumbnailController;   import gameCommon.view.propContainer.PlayerStateContainer;   import gameStarling.actions.ViewEachPlayerAction;   import gameStarling.objects.GameLiving3D;   import gameStarling.objects.GameLocalPlayer3D;   import gameStarling.objects.GamePlayer3D;   import gameStarling.view.map.MapView3D;   import kingBless.KingBlessManager;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;   import particleSystem.ParticleRender;   import phy.math.EulerVector;   import rescue.data.RescueRoomInfo;   import road7th.StarlingMain;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import road7th.data.StringObject;   import road7th.utils.MovieClipWrapper;   import room.RoomManager;   import room.model.RoomPlayer;   import trainer.controller.NewHandGuideManager;   import trainer.controller.WeakGuildManager;   import worldboss.WorldBossManager;      public class GameViewBase3D extends BaseStateView   {                   protected var _arrowLeft:SpringArrowView3D;            protected var _arrowRight:SpringArrowView3D;            protected var _arrowUp:SpringArrowView3D;            protected var _arrowDown:SpringArrowView3D;            protected var _selfUsedProp:PlayerStateContainer;            protected var _leftPlayerView:LeftPlayerCartoonView;            protected var _missionHelp:DungeonHelpView;            protected var _fightControlBar:FightControlBar;            protected var _cs:ControlState;            protected var _vane:VaneView;            protected var _playerThumbnailLController:PlayerThumbnailController;            protected var _map:MapView3D;            protected var _mapSprite:Sprite;            protected var _smallMapBorderBg:Bitmap;            protected var _players:DictionaryData;            protected var _gameInfo:GameInfo;            protected var _selfGamePlayer:GameLocalPlayer3D;            protected var _selfBuffBar:SelfBuffBar;            protected var _selfMarkBar:SelfMarkBar;            protected var _achievBar:FightAchievBar;            protected var _bitmapMgr:BitmapManager;            private var _buffIconBox:HBox;            protected var _kingblessIcon:Image;            protected var _trialBuffIcon:Image;            protected var _ringSkillIcon:Image;            protected var _guardCoreIcon:Image;            protected var _gameTrusteeshipView:GameTrusteeshipView;            protected var _heroAutoView:HeroAutoView;            protected var _gameCountDownView:GameCountDownView;            private var _damageView:DamageView;            private var _rescueRoomItemView:RescueRoomItemView;            protected var _rescueScoreView:RescueScoreAlertView;            protected var _sceneEffectsBar:SceneEffectsBar3D;            private var _messageBtn:BaseButton;            private var _pirateBall:ChatBallBoss;            public var explorersLiving:Living;            protected var _weatherView:GameWeatherView;            protected var _barrier:DungeonInfoView;            private const GUIDEID:int = 10029;            protected var _barrierVisible:Boolean = true;            private var _self:LocalPlayer;            private var _level:int;            private var _gameLiving:GameLiving3D;            private var _selfGameLiving:GamePlayer3D;            private var _allLivings:DictionaryData;            private var _mass:Number = 10;            private var _gravityFactor:Number = 70;            protected var _windFactor:Number = 240;            private var _powerRef:Number = 1;            private var _reangle:Number = 0;            private var _dt:Number = 0.04;            private var _arf:Number;            private var _gf:Number;            private var _ga:Number;            private var _mapWind:Number = 0;            private var _wa:Number;            private var _ef:Point;            private var _shootAngle:Number;            private var _state:Boolean = false;            private var _useAble:Boolean = false;            private var _stateFlag:int;            private var _currentLivID:int;            private var _collideRect:Rectangle;            private var _drawRoute:Sprite;            public function GameViewBase3D() { super(); }
            override public function prepare() : void { }
            override public function fadingComplete() : void { }
            public function get selfGamePlayer() : GameLocalPlayer3D { return null; }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function addSmallMapBg() : Bitmap { return null; }
            protected function creatWeatherView() : void { }
            protected function __addRescueScore(event:CrazyTankSocketEvent) : void { }
            private function setScoreViewInvisible() : void { }
            protected function __updateRescueItemInfo(event:CrazyTankSocketEvent) : void { }
            public function addMessageBtn() : void { }
            protected function __onMessageClick(event:MouseEvent) : void { }
            private function initGameCountDownView() : void { }
            private function isShowTrusteeship() : Boolean { return false; }
            public function updateDamageView() : void { }
            protected function kingBlessIconInit() : void { }
            private function trialBuffIconInit() : void { }
            private function addRingSkillIcon() : void { }
            protected function updateGuardCoreIcon() : void { }
            private function setSkillTipData($target:Image) : void { }
            private function resetPlayerCharacters() : void { }
            protected function __wishClick(pEvent:Event) : void { }
            protected function __selfDie(event:LivingEvent) : void { }
            protected function drawMissionInfo() : void { }
            protected function __updateSmallMapView(event:GameEvent) : void { }
            protected function __dungeonHelpChanged(event:GameEvent) : void { }
            protected function __dungeonVisibleChanged(evt:DungeonInfoEvent) : void { }
            protected function initEvent() : void { }
            private function __selfBuffBarUpdateCellHandler(event:CEvent) : void { }
            private function addPlayerHander(e:DictionaryEvent) : void { }
            protected function loadWeakGuild() : void { }
            private function isWishGuideLoad() : Boolean { return false; }
            private function propOpenShow(mcStr:String) : void { }
            protected function newMap() : MapView3D { return null; }
            private function __soundChange(evt:Event) : void { }
            public function restoreSmallMap() : void { }
            protected function disposeUI() : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function dispose() : void { }
            protected function setupGameData() : void { }
            protected function __onAddRingAnimation(event:GameEvent) : void { }
            protected function __onAddGuardCoreAnimation(e:GameEvent) : void { }
            protected function setProperty(obj:GameLiving3D, property:String, value:String) : void { }
            private function initDiePlayer() : void { }
            private function removeGameData() : void { }
            public function addLiving($living:Living) : void { }
            private function updatePlayerState(info:Living) : void { }
            public function setCurrentPlayer(info:Living) : void { }
            private function updateBuffIconBoxPos() : void { }
            public function updateControlBarState(info:Living) : void { }
            protected function setPropBarClickEnable(clickAble:Boolean, isGray:Boolean) : void { }
            protected function gameOver() : void { }
            protected function set barrierInfo(evt:CrazyTankSocketEvent) : void { }
            protected function set arrowHammerEnable(b:Boolean) : void { }
            public function blockHammer() : void { }
            public function allowHammer() : void { }
            protected function defaultForbidDragFocus() : void { }
            protected function setBarrierVisible(v:Boolean) : void { }
            protected function setVaneVisible(v:Boolean) : void { }
            protected function setPlayerThumbVisible(v:Boolean) : void { }
            protected function setEnergyVisible(v:Boolean) : void { }
            public function setRecordRotation() : void { }
            public function get map() : * { return null; }
            public function get mapSprite() : Sprite { return null; }
            protected function set mapWind(value:Number) : void { }
            public function get currentLivID() : int { return 0; }
            public function set currentLivID(value:int) : void { }
            private function showFightPower() : void { }
            private function wishInit() : void { }
            public function updaet() : void { }
            private function __mouseClick(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            private function __useRescueKingBless(event:CrazyTankSocketEvent) : void { }
            protected function __KeyDown(event:KeyboardEvent) : void { }
            protected function showShoot() : void { }
            protected function judgeMaxPower(shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean) : Boolean { return false; }
            protected function getPower(min:Number, max:Number, shootPos:Point, enemyPos:Point, shootAngle:Number, xS_Lef_E:Boolean, yS_Up_E:Boolean) : Number { return 0; }
            protected function ifHit(bulletX:Number, bulletY:Number, enemyPos:Point) : Boolean { return false; }
            private function isOutOfMap(ex:EulerVector, ey:EulerVector) : Boolean { return false; }
            private function drawRouteLine(id:int) : void { }
            private function getRouteData(power:Number, shootAngle:Number, shootPos:Point, enemyPos:Point) : Vector.<Point> { return null; }
            public function drawDashed(graphics:Graphics, beginPoint:Point, endPoint:Point, width:Number, grap:Number) : void { }
            private function drawArrow(graphics:Graphics, start:Point, end:Point, angle:Number, length:int) : void { }
            protected function __playerChange(event:CrazyTankSocketEvent) : void { }
            private function __playerExit(e:Event) : void { }
            protected function __changeAngle(event:LivingEvent) : void { }
            protected function __wishofdd(event:CrazyTankSocketEvent) : void { }
            private function __thumbnailControlHandle(e:GameEvent) : void { }
            private function calculateRecent() : int { return 0; }
            private function getDistance(start:Point, end:Point) : int { return 0; }
            public function get barrier() : DungeonInfoView { return null; }
            public function get messageBtn() : BaseButton { return null; }
   }}