package worldboss.view
{
   import church.vo.SceneMapVO;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.DailyButtunBar;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import hall.event.NewHallEvent;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.model.WorldBossRoomModel;
   import worldboss.player.PlayerVO;
   import worldboss.player.WorldRoomPlayer;
   
   public class WorldBossScneneMap extends Sprite implements Disposeable
   {
      
      public static const SCENE_ALLOW_FIRES:int = 6;
       
      
      private const CLICK_INTERVAL:Number = 200;
      
      protected var articleLayer:Sprite;
      
      protected var meshLayer:Sprite;
      
      protected var bgLayer:Sprite;
      
      protected var skyLayer:Sprite;
      
      public var sceneScene:SceneScene;
      
      protected var _data:DictionaryData;
      
      protected var _characters:DictionaryData;
      
      public var selfPlayer:WorldRoomPlayer;
      
      private var last_click:Number;
      
      private var current_display_fire:int = 0;
      
      private var _mouseMovie:MovieClip;
      
      private var _currentLoadingPlayer:WorldRoomPlayer;
      
      private var _isShowName:Boolean = true;
      
      private var _isChatBall:Boolean = true;
      
      private var _clickInterval:Number = 200;
      
      private var _lastClick:Number = 0;
      
      private var _sceneMapVO:SceneMapVO;
      
      private var _model:WorldBossRoomModel;
      
      private var _worldboss:MovieClip;
      
      private var _worldboss_mc:MovieClip;
      
      private var _worldboss_sky:MovieClip;
      
      private var armyPos:Point;
      
      private var decorationLayer:Sprite;
      
      private var _isShowOther:Boolean = true;
      
      private var _beforeTimeView:WorldBossBeforeTimer;
      
      private var r:int = 250;
      
      private var auto:Point;
      
      private var autoMove:Boolean = false;
      
      private var clickAgain:Boolean = false;
      
      private var _entering:Boolean = false;
      
      private var _isFight:Boolean = false;
      
      private var _frame_name:String = "stand";
      
      protected var reference:WorldRoomPlayer;
      
      public function WorldBossScneneMap(param1:WorldBossRoomModel, param2:SceneScene, param3:DictionaryData, param4:Sprite, param5:Sprite, param6:Sprite = null, param7:Sprite = null, param8:Sprite = null){super();}
      
      private function initBeforeTimeView() : void{}
      
      private function beforeTimeEndHandler(param1:Event) : void{}
      
      private function disposeBeforeTimeView() : void{}
      
      private function hideBoss() : void{}
      
      private function showBoss() : void{}
      
      private function initBoss() : void{}
      
      private function _enterWorldBossGame(param1:MouseEvent) : void{}
      
      private function checkDistance() : Boolean{return false;}
      
      private function checkCanStartGame() : Boolean{return false;}
      
      public function set enterIng(param1:Boolean) : void{}
      
      public function removePrompt() : void{}
      
      private function CreateStartGame() : void{}
      
      private function __onAlertResponse(param1:FrameEvent) : void{}
      
      private function startGame() : void{}
      
      protected function __startFight(param1:Event) : void{}
      
      private function __stopFight(param1:Event) : void{}
      
      private function __arrive(param1:SceneCharacterEvent) : void{}
      
      public function gameOver() : void{}
      
      public function get sceneMapVO() : SceneMapVO{return null;}
      
      public function set sceneMapVO(param1:SceneMapVO) : void{}
      
      protected function init() : void{}
      
      protected function addEvent() : void{}
      
      protected function __onSetSelfPlayerPos(param1:NewHallEvent) : void{}
      
      private function _hideOtherPlayer(param1:WorldBossRoomEvent) : void{}
      
      private function __onRoomFull(param1:WorldBossRoomEvent) : void{}
      
      private function menuChange(param1:WorldBossRoomEvent) : void{}
      
      public function nameVisible() : void{}
      
      protected function updateMap(param1:Event) : void{}
      
      protected function __click(param1:MouseEvent) : void{}
      
      public function sendMyPosition(param1:Array) : void{}
      
      public function movePlayer(param1:int, param2:Array) : void{}
      
      public function updatePlayersStauts(param1:int, param2:int, param3:Point) : void{}
      
      public function __otherPlayrStartFight(param1:WorldBossRoomEvent) : void{}
      
      public function updateSelfStatus(param1:int) : void{}
      
      public function checkSelfStatus() : int{return 0;}
      
      public function playerRevive(param1:int) : void{}
      
      private function worldBoss_mc_gotoAndplay() : void{}
      
      private function checkGameOver() : Boolean{return false;}
      
      public function setCenter(param1:SceneCharacterEvent = null) : void{}
      
      public function addSelfPlayer() : void{}
      
      protected function ajustScreen(param1:WorldRoomPlayer) : void{}
      
      protected function __addPlayer(param1:DictionaryEvent) : void{}
      
      private function addPlayerCallBack(param1:WorldRoomPlayer, param2:Boolean, param3:int) : void{}
      
      private function playerActionChange(param1:SceneCharacterEvent) : void{}
      
      protected function __removePlayer(param1:DictionaryEvent) : void{}
      
      protected function BuildEntityDepth() : void{}
      
      protected function getPointDepth(param1:Number, param2:Number) : Number{return 0;}
      
      protected function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
