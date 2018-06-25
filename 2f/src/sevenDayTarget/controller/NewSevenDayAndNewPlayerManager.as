package sevenDayTarget.controller{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ComponentSetting;   import ddt.bagStore.BagStore;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import hallIcon.HallIconManager;   import quest.TaskManager;   import sevenDayTarget.model.NewTargetQuestionInfo;   import sevenDayTarget.view.NewSevenDayAndNewPlayerMainView;      public class NewSevenDayAndNewPlayerManager extends EventDispatcher   {            private static var _instance:NewSevenDayAndNewPlayerManager;                   private var _isShowIcon:Boolean;            private var _sevenDayOpen:Boolean;            private var _newPlayerOpen:Boolean;            public var sevenDayMainViewPreOk:Boolean;            public var newPlayerMainViewPreOk:Boolean;            private var _newSevenDayAndNewPlayerMainView:NewSevenDayAndNewPlayerMainView;            public var enterShop:Boolean;            public function NewSevenDayAndNewPlayerManager() { super(); }
            public static function get Instance() : NewSevenDayAndNewPlayerManager { return null; }
            public function get isShowIcon() : Boolean { return false; }
            public function get sevenDayOpen() : Boolean { return false; }
            public function set sevenDayOpen(isopen:Boolean) : void { }
            public function get newPlayerOpen() : Boolean { return false; }
            public function set newPlayerOpen(isopen:Boolean) : void { }
            public function setup() : void { }
            private function _aciveOtherManager(e:Event) : void { }
            public function addEnterIcon() : void { }
            private function disposeEnterIcon() : void { }
            public function onClickSevenDayTargetIcon(event:MouseEvent) : void { }
            private function _openMainView(e:Event) : void { }
            public function hideMainView() : void { }
            private function __clickLink(e:Event) : void { }
   }}