package worldboss.view
{
   import church.vo.SceneMapVO;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.chat.ChatView;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import worldboss.WorldBossManager;
   import worldboss.WorldBossRoomController;
   import worldboss.model.WorldBossRoomModel;
   
   public class WorldBossRoomView extends Sprite implements Disposeable
   {
      
      public static const MAP_SIZEII:Array = [1738,1300];
       
      
      private var _contoller:WorldBossRoomController;
      
      private var _model:WorldBossRoomModel;
      
      private var _sceneScene:SceneScene;
      
      private var _sceneMap:WorldBossScneneMap;
      
      private var _chatFrame:ChatView;
      
      private var _roomMenuView:RoomMenuView;
      
      private var _bossHP:WorldBossHPScript;
      
      private var _totalContainer:WorldBossRoomTotalInfoView;
      
      private var _resurrectFrame:WorldBossResurrectView;
      
      private var _buffIcon:WorldBossBuffIcon;
      
      private var _buffIconArr:Array;
      
      private var _timer:Timer;
      
      private var _diff:int;
      
      private var _hideBtn:WorldBossHideBtn;
      
      public function WorldBossRoomView(param1:WorldBossRoomController, param2:WorldBossRoomModel){super();}
      
      public static function getImagePath(param1:int) : String{return null;}
      
      public function show() : void{}
      
      private function initialize() : void{}
      
      public function refreshHpScript() : void{}
      
      public function setViewAgain() : void{}
      
      public function __timeOne(param1:TimerEvent) : void{}
      
      public function timeComplete() : void{}
      
      public function setMap(param1:Point = null) : void{}
      
      public function getSceneMapVO() : SceneMapVO{return null;}
      
      public function clearBuff() : void{}
      
      public function showBuff(param1:Event = null) : void{}
      
      public function movePlayer(param1:int, param2:Array) : void{}
      
      public function updatePlayerStauts(param1:int, param2:int, param3:Point = null) : void{}
      
      public function updateSelfStatus(param1:int) : void{}
      
      public function checkSelfStatus() : void{}
      
      private function showResurrectFrame(param1:int) : void{}
      
      public function playerRevive(param1:int) : void{}
      
      private function __resurrectTimeOver(param1:Event = null) : void{}
      
      private function removeFrame() : void{}
      
      private function _leaveRoom(param1:Event) : void{}
      
      public function gameOver() : void{}
      
      public function updataRanking(param1:Array) : void{}
      
      public function getMapRes() : String{return null;}
      
      private function clearMap() : void{}
      
      public function dispose() : void{}
   }
}
