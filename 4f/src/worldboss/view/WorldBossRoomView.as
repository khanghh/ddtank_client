package worldboss.view{   import church.vo.SceneMapVO;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import ddt.view.chat.ChatView;   import ddt.view.scenePathSearcher.PathMapHitTester;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.geom.Point;   import flash.utils.Timer;   import worldboss.WorldBossManager;   import worldboss.WorldBossRoomController;   import worldboss.model.WorldBossRoomModel;      public class WorldBossRoomView extends Sprite implements Disposeable   {            public static const MAP_SIZEII:Array = [1738,1300];                   private var _contoller:WorldBossRoomController;            private var _model:WorldBossRoomModel;            private var _sceneScene:SceneScene;            private var _sceneMap:WorldBossScneneMap;            private var _chatFrame:ChatView;            private var _roomMenuView:RoomMenuView;            private var _bossHP:WorldBossHPScript;            private var _totalContainer:WorldBossRoomTotalInfoView;            private var _resurrectFrame:WorldBossResurrectView;            private var _buffIcon:WorldBossBuffIcon;            private var _buffIconArr:Array;            private var _timer:Timer;            private var _diff:int;            private var _hideBtn:WorldBossHideBtn;            private var _helpButton:BaseButton;            public function WorldBossRoomView(controller:WorldBossRoomController, model:WorldBossRoomModel) { super(); }
            public static function getImagePath(id:int) : String { return null; }
            public function show() : void { }
            private function initialize() : void { }
            public function refreshHpScript() : void { }
            public function setViewAgain() : void { }
            public function __timeOne(event:TimerEvent) : void { }
            public function timeComplete() : void { }
            public function setMap(localPos:Point = null) : void { }
            public function getSceneMapVO() : SceneMapVO { return null; }
            public function clearBuff() : void { }
            public function showBuff(evt:Event = null) : void { }
            public function movePlayer(id:int, p:Array) : void { }
            public function updatePlayerStauts(id:int, status:int, point:Point = null) : void { }
            public function updateSelfStatus(value:int) : void { }
            public function checkSelfStatus() : void { }
            private function showResurrectFrame(cd:int) : void { }
            public function playerRevive(id:int) : void { }
            private function __resurrectTimeOver(e:Event = null) : void { }
            private function removeFrame() : void { }
            private function _leaveRoom(e:Event) : void { }
            public function gameOver() : void { }
            public function updataRanking(arr:Array) : void { }
            public function getMapRes() : String { return null; }
            private function clearMap() : void { }
            public function dispose() : void { }
   }}