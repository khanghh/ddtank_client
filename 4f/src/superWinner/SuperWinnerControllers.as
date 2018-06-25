package superWinner{   import christmas.view.playingSnowman.RoomMenuView;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import flash.events.Event;   import flash.events.EventDispatcher;   import superWinner.controller.SuperWinnerController;   import superWinner.manager.SuperWinnerManager;   import superWinner.view.SuperWinnerView;      public class SuperWinnerControllers extends EventDispatcher   {            private static var _instance:SuperWinnerControllers;                   private var _view:SuperWinnerView;            private var _roomMenuView:RoomMenuView;            public function SuperWinnerControllers() { super(); }
            public static function get Instance() : SuperWinnerControllers { return null; }
            public function setup() : void { }
            private function __onEnterGame(e:Event) : void { }
            private function __onEndGame(e:Event) : void { }
            private function __onDisposeSuperWinner(e:Event) : void { }
   }}