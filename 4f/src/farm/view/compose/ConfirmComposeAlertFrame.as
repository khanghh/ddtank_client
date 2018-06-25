package farm.view.compose{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import farm.view.compose.event.SelectComposeItemEvent;   import flash.display.DisplayObject;   import flash.events.Event;   import flash.events.MouseEvent;   import petsBag.PetsBagManager;      public class ConfirmComposeAlertFrame extends BaseAlerFrame   {            private static const MaxNum:int = 999;                   private var _minBtn:BaseButton;            private var _maxBtn:BaseButton;            private var _addBtn:BaseButton;            private var _removeBtn:BaseButton;            private var _inputNumBg:DisplayObject;            private var _inputTxt:FilterFrameText;            private var _inputNum:int = 1;            private var _bgTitle:DisplayObject;            public function ConfirmComposeAlertFrame() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            protected function __framePesponse(event:FrameEvent) : void { }
            private function __inputCheck(e:Event) : void { }
            private function checkInput() : void { }
            private function __changeInputNumber(e:MouseEvent) : void { }
            public function set maxCount(value:int) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}