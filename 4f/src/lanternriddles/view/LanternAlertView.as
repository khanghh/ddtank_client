package lanternriddles.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.events.Event;   import lanternriddles.event.LanternEvent;      public class LanternAlertView extends BaseAlerFrame   {                   private var _tipInfo:FilterFrameText;            private var _checkBtn:SelectedCheckButton;            public function LanternAlertView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            public function get notShowAgain() : Boolean { return false; }
            protected function __noAlertTip(event:Event) : void { }
            public function set text(text:String) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}