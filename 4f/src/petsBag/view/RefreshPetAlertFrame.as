package petsBag.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.PetconfigAnalyzer;   import ddt.manager.LanguageMgr;   import ddt.manager.SharedManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.DoubleSelectedItem;   import flash.display.DisplayObject;   import flash.events.Event;      public class RefreshPetAlertFrame extends BaseAlerFrame   {                   private var _bgTitle:DisplayObject;            private var _alertTips:FilterFrameText;            private var _alertTips2:FilterFrameText;            private var _refreshSelBtn:SelectedCheckButton;            private var _selecedItem:DoubleSelectedItem;            public function RefreshPetAlertFrame() { super(); }
            private function initView() : void { }
            public function getBind() : Boolean { return false; }
            private function initEvent() : void { }
            private function __noAlertTip(e:Event) : void { }
            protected function __framePesponse(event:FrameEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}