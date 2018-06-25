package entertainmentMode.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SharedManager;   import ddt.manager.SoundManager;   import flash.events.Event;      public class EntertainmentAlertFrame extends BaseAlerFrame   {                   private var _refreshSelBtn:SelectedCheckButton;            private var _content:FilterFrameText;            public function EntertainmentAlertFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __noAlertTip(e:Event) : void { }
            protected function __framePesponse(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}