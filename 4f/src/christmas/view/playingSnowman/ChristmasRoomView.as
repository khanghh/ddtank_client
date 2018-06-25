package christmas.view.playingSnowman{   import christmas.ChristmasCoreController;   import christmas.ChristmasCoreManager;   import christmas.controller.ChristmasRoomController;   import christmas.loader.LoaderChristmasUIModule;   import christmas.model.ChristmasRoomModel;   import church.vo.SceneMapVO;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.view.chat.ChatView;   import ddt.view.scenePathSearcher.PathMapHitTester;   import ddt.view.scenePathSearcher.SceneScene;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;   import road7th.comm.PackageIn;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ChristmasRoomView extends Sprite implements Disposeable   {            public static const MAP_SIZEII:Array = [1738,1300];                   private var _contoller:ChristmasRoomController;            private var _model:ChristmasRoomModel;            private var _sceneScene:SceneScene;            private var _sceneMap:ChristmasScneneMap;            private var _chatFrame:ChatView;            private var _roomMenuView:RoomMenuView;            private var _snowPackNumImg:Bitmap;            private var _snowPackNumTxt:FilterFrameText;            private var _activeTimeTxt:FilterFrameText;            private var _timer:TimerJuggler;            public function ChristmasRoomView(controller:ChristmasRoomController, model:ChristmasRoomModel) { super(); }
            public function show() : void { }
            private function initialize() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __updateRoomTimes(event:CrazyTankSocketEvent) : void { }
            public function removeTimer() : void { }
            public function setViewAgain() : void { }
            private function flushTip() : void { }
            private function updateTip(e:Event) : void { }
            private function firestGetTime() : void { }
            public function setMap(localPos:Point = null) : void { }
            public function getSceneMapVO() : SceneMapVO { return null; }
            public function movePlayer(id:int, p:Array) : void { }
            public function updatePlayerStauts(id:int, status:int, point:Point = null) : void { }
            public function updateSelfStatus(value:int) : void { }
            public function playerRevive(id:int) : void { }
            private function _leaveRoom(e:Event) : void { }
            private function clearMap() : void { }
            public function dispose() : void { }
   }}