package ddt.view.common.church{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SelectedIconButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.ui.vo.AlertInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import flash.events.Event;   import flash.events.MouseEvent;      public class ChurchProposeFrame extends BaseAlerFrame   {                   private var _bg:MutipleImage;            private var _alertInfo:AlertInfo;            private var _txtInfo:TextArea;            private var _chkSysMsg:SelectedIconButton;            private var _maxChar:FilterFrameText;            private var _buyRingFrame:ChurchBuyRingFrame;            private var _spouseID:int;            private var useBugle:Boolean;            private var _bgTitleText:FilterFrameText;            private var _surplusCharText:FilterFrameText;            private var _noticeText:FilterFrameText;            private var _blessingText:FilterFrameText;            private var _selectedBandBtn:SelectedCheckButton;            private var _moneyTxt:FilterFrameText;            public function ChurchProposeFrame() { super(); }
            public function get spouseID() : int { return 0; }
            public function set spouseID(value:int) : void { }
            private function initialize() : void { }
            private function addEvent() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function removeEvent() : void { }
            private function __checkClick(event:Event) : void { }
            private function getFocus(evt:MouseEvent) : void { }
            private function __addToStages(e:Event) : void { }
            private function __input(e:Event) : void { }
            private function confirmSubmit() : void { }
            private function sendPropose() : void { }
            public function show() : void { }
            private function buyRingFrameClose(evt:Event) : void { }
            override public function dispose() : void { }
   }}