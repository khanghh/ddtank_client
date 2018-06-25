package church.controller{   import baglocked.BaglockedManager;   import church.ChurchManager;   import church.events.WeddingRoomEvent;   import church.model.ChurchRoomModel;   import church.view.weddingRoom.WeddingRoomSwitchMovie;   import church.view.weddingRoom.WeddingRoomView;   import church.vo.PlayerVO;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.data.player.PlayerInfo;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import ddt.view.chat.ChatData;   import flash.events.Event;   import flash.geom.Point;   import road7th.comm.PackageIn;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ChurchRoomController extends BaseStateView   {            private static const RESTART_WEDDING_FEE:int = 300;            private static const RESTART_COSTLYWEDDING_FEE:int = 8000;                   private var _sceneModel:ChurchRoomModel;            private var _view:WeddingRoomView;            private var timer:TimerJuggler;            private var _baseAlerFrame:BaseAlerFrame;            public function ChurchRoomController() { super(); }
            override public function prepare() : void { }
            override public function getBackType() : String { return null; }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function init() : void { }
            public function resetTimer() : void { }
            private function __timerComplete(event:Event) : void { }
            private function stopTimer() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __continuation(event:PkgEvent) : void { }
            private function __updateValidTime(event:WeddingRoomEvent) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getType() : String { return null; }
            public function __addPlayer(event:PkgEvent) : void { }
            public function __removePlayer(event:PkgEvent) : void { }
            public function __movePlayer(event:PkgEvent) : void { }
            private function __updateWeddingStatus(event:WeddingRoomEvent) : void { }
            public function playWeddingMovie() : void { }
            public function startWedding() : void { }
            private function __frameEvent(event:FrameEvent) : void { }
            private function __startWedding(event:PkgEvent) : void { }
            private function __stopWedding(event:PkgEvent) : void { }
            public function modifyDiscription(roomName:String, modifyPSW:Boolean, psw:String, discription:String) : void { }
            public function useFire(playerID:int, fireTemplateID:int) : void { }
            private function __onUseFire(e:PkgEvent) : void { }
            private function __onUseSalute(event:PkgEvent) : void { }
            public function setSaulte(id:int) : void { }
            private function __sceneChange(event:WeddingRoomEvent) : void { }
            public function readyEnterScene() : void { }
            private function __readyEnterOk(event:Event) : void { }
            public function enterScene() : void { }
            public function giftSubmit(money:uint) : void { }
            public function roomContinuation(secondType:int) : void { }
            private function getWeddingMoney() : int { return 0; }
            override public function dispose() : void { }
   }}