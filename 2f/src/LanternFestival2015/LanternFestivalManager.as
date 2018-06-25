package LanternFestival2015{   import LanternFestival2015.model.LanternFestivalModel;   import LanternFestival2015.view.LanternFestivalInHallButton;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.CoreManager;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import hall.HallStateView;   import road7th.comm.PackageIn;      public class LanternFestivalManager extends CoreManager   {            public static const SHOW_HOME_BOARD:String = "lt15_show_home_board";            public static const HIDE_HOME_BOARD:String = "lt15_hide_home_board";            public static const SHOW_COOKING_BOARD:String = "lt15_show_cooking_board";            public static const UPDATE:String = "lt15_update";            public static const UPDATE_MAKE_BOARD:String = "lt15_update_make_board";            private static var instance:LanternFestivalManager;                   private var _model:LanternFestivalModel;            private var _hall:HallStateView;            private var _iconLantern:LanternFestivalInHallButton;            private var _showType:String = "";            private var _playerBG:Sprite;            private var _showTarget:DisplayObject;            private var _firstRequestIsOpen:Boolean = true;            public function LanternFestivalManager(single:inner) { super(); }
            public static function getInstance() : LanternFestivalManager { return null; }
            public function get model() : LanternFestivalModel { return null; }
            private function addHomeEvents() : void { }
            private function removeHomeEvents() : void { }
            private function addCookEvents() : void { }
            private function removeCookEvents() : void { }
            protected function onGetData(e:PkgEvent) : void { }
            protected function onIsOpen(e:PkgEvent) : void { }
            public function isOpen(isOpen:Boolean) : void { }
            protected function onBagUpdate(e:Event) : void { }
            public function dispose() : void { }
            public function setup() : void { }
            override protected function start() : void { }
            public function get playerBG() : Sprite { return null; }
            public function get showTarget() : DisplayObject { return null; }
            public function showHomeBoard(target:Object, playerBG:Sprite) : void { }
            public function afterHideCookBoard() : void { }
            public function showCookingBoard() : void { }
            public function showHallIcon($hall:HallStateView) : void { }
            private function requireActivityIsOpen() : void { }
            private function requireData() : void { }
            private function requireMakeLantern(num:int) : void { }
            private function requireCookLantern(num:int) : void { }
            private function requireGainWishGift() : void { }
            public function onBtnCookClicked(count:int) : void { }
            public function onBtnMakeClicked(count:int) : void { }
            public function onActivityButtonClick() : void { }
            public function onBtnInHallClicked() : void { }
            public function onEnterHome() : void { }
            public function initHall($hall:HallStateView) : void { }
   }}class inner{          function inner() { super(); }
}