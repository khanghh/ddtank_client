package ddtmatch.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.DoubleSelectedItem;   import ddtmatch.event.DDTMatchEvent;   import flash.events.Event;      public class DDTMatchAlertView extends BaseAlerFrame   {                   private var _tipInfo:FilterFrameText;            private var _selecedItem:DoubleSelectedItem;            private var _checkBtn:SelectedCheckButton;            public function DDTMatchAlertView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __noAlertTip(event:Event) : void { }
            override public function get isBand() : Boolean { return false; }
            public function set text(text:String) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}