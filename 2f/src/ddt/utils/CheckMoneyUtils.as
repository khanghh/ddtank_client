package ddt.utils{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.EventDispatcher;      public class CheckMoneyUtils extends EventDispatcher   {            private static var _instance:CheckMoneyUtils;                   private var _isBind:Boolean;            private var _needMoney:int;            private var _completeFun:Function;            private var _cancelFun:Function;            public function CheckMoneyUtils() { super(); }
            public static function get instance() : CheckMoneyUtils { return null; }
            public function checkMoney(bind:Boolean, needMoney:int, completeFun:Function, cancelFun:Function = null, ifChangeMoney:Boolean = true) : void { }
            protected function reConfirmHandler(evt:FrameEvent) : void { }
            private function complete() : void { }
            private function cancel() : void { }
            public function get isBind() : Boolean { return false; }
   }}