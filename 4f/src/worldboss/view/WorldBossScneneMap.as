package worldboss.view{   import church.vo.SceneMapVO;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.SceneCharacterEvent;   import ddt.manager.CheckWeaponManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.DailyButtunBar;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;   import flash.utils.getTimer;   import flash.utils.setTimeout;   import hall.event.NewHallEvent;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import worldboss.WorldBossManager;   import worldboss.event.WorldBossRoomEvent;   import worldboss.model.WorldBossRoomModel;   import worldboss.player.PlayerVO;   import worldboss.player.WorldRoomPlayer;      public class WorldBossScneneMap extends Sprite implements Disposeable   {            public static const SCENE_ALLOW_FIRES:int = 6;                   private const CLICK_INTERVAL:Number = 200;            protected var articleLayer:Sprite;            protected var meshLayer:Sprite;            protected var bgLayer:Sprite;            protected var skyLayer:Sprite;            public var sceneScene:SceneScene;            protected var _data:DictionaryData;            protected var _characters:DictionaryData;            public var selfPlayer:WorldRoomPlayer;            private var last_click:Number;            private var current_display_fire:int = 0;            private var _mouseMovie:MovieClip;            private var _currentLoadingPlayer:WorldRoomPlayer;            private var _isShowName:Boolean = true;            private var _isChatBall:Boolean = true;            private var _clickInterval:Number = 200;            private var _lastClick:Number = 0;            private var _sceneMapVO:SceneMapVO;            private var _model:WorldBossRoomModel;            private var _worldboss:MovieClip;            private var _worldboss_mc:MovieClip;            private var _worldboss_sky:MovieClip;            private var armyPos:Point;            private var decorationLayer:Sprite;            private var _isShowOther:Boolean = true;            private var _beforeTimeView:WorldBossBeforeTimer;            private var r:int = 250;            private var auto:Point;            private var autoMove:Boolean = false;            private var clickAgain:Boolean = false;            private var _entering:Boolean = false;            private var _isFight:Boolean = false;            private var _frame_name:String = "stand";            protected var reference:WorldRoomPlayer;            public function WorldBossScneneMap(model:WorldBossRoomModel, sceneScene:SceneScene, data:DictionaryData, bg:Sprite, mesh:Sprite, acticle:Sprite = null, sky:Sprite = null, decoration:Sprite = null) { super(); }
            private function initBeforeTimeView() : void { }
            private function beforeTimeEndHandler(event:Event) : void { }
            private function disposeBeforeTimeView() : void { }
            private function hideBoss() : void { }
            private function showBoss() : void { }
            private function initBoss() : void { }
            private function _enterWorldBossGame(e:MouseEvent) : void { }
            private function checkDistance() : Boolean { return false; }
            private function checkCanStartGame() : Boolean { return false; }
            public function set enterIng(value:Boolean) : void { }
            public function removePrompt() : void { }
            private function CreateStartGame() : void { }
            private function __onAlertResponse(evt:FrameEvent) : void { }
            private function startGame() : void { }
            protected function __startFight(event:Event) : void { }
            private function __stopFight(e:Event) : void { }
            private function __arrive(e:SceneCharacterEvent) : void { }
            public function gameOver() : void { }
            public function get sceneMapVO() : SceneMapVO { return null; }
            public function set sceneMapVO(value:SceneMapVO) : void { }
            protected function init() : void { }
            protected function addEvent() : void { }
            protected function __onSetSelfPlayerPos(event:NewHallEvent) : void { }
            private function _hideOtherPlayer(event:WorldBossRoomEvent) : void { }
            private function __onRoomFull(pEvent:WorldBossRoomEvent) : void { }
            private function menuChange(evt:WorldBossRoomEvent) : void { }
            public function nameVisible() : void { }
            protected function updateMap(event:Event) : void { }
            protected function __click(event:MouseEvent) : void { }
            public function sendMyPosition(p:Array) : void { }
            public function movePlayer(id:int, p:Array) : void { }
            public function updatePlayersStauts(id:int, stauts:int, point:Point) : void { }
            public function __otherPlayrStartFight(evt:WorldBossRoomEvent) : void { }
            public function updateSelfStatus(value:int) : void { }
            public function checkSelfStatus() : int { return 0; }
            public function playerRevive(id:int) : void { }
            private function worldBoss_mc_gotoAndplay() : void { }
            private function checkGameOver() : Boolean { return false; }
            public function setCenter(event:SceneCharacterEvent = null) : void { }
            public function addSelfPlayer() : void { }
            protected function ajustScreen(worldRoomPlayer:WorldRoomPlayer) : void { }
            protected function __addPlayer(event:DictionaryEvent) : void { }
            private function addPlayerCallBack(worldRoomPlayer:WorldRoomPlayer, isLoadSucceed:Boolean, vFlag:int) : void { }
            private function playerActionChange(evt:SceneCharacterEvent) : void { }
            protected function __removePlayer(event:DictionaryEvent) : void { }
            protected function BuildEntityDepth() : void { }
            protected function getPointDepth(x:Number, y:Number) : Number { return 0; }
            protected function removeEvent() : void { }
            public function dispose() : void { }
   }}