package consortiaRoseFlower{   import com.greensock.TweenLite;   import com.greensock.TweenMax;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.HelperUIModuleLoad;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class ConsortiaRoseManager extends EventDispatcher   {            public static const CLOSE_ROSE:String = "close_rose";            private static var instance:ConsortiaRoseManager;                   private var _roseView:ConsortiaRoseView;            private var _timer:TimerJuggler;            private var _showTime:Number = 30000;            private var _delaySeconds:Number = 3;            private var _playList:Array;            private var _isPlaying:Boolean = false;            private var _detailView:ConsortiaRoseDetailView;            public function ConsortiaRoseManager(single:inner) { super(); }
            public static function getInstance() : ConsortiaRoseManager { return null; }
            public function setup() : void { }
            public function onConsortiaRose(e:PkgEvent) : void { }
            public function playRose() : void { }
            private function isInBattle() : Boolean { return false; }
            public function show($isInBattle:Boolean, consortiaName:String, nickName:String) : void { }
            private function exitDetail() : void { }
            private function onDetailViewAutoClose() : void { }
            protected function onDetailClose(e:Event) : void { }
            protected function onTimerComplete(e:Event) : void { }
   }}class inner{          function inner() { super(); }
}