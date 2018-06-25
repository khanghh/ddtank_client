package lanternriddles.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SharedManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import lanternriddles.LanternRiddlesControl;   import lanternriddles.LanternRiddlesManager;   import lanternriddles.data.LanternAwardInfo;   import lanternriddles.data.LanternInfo;   import lanternriddles.event.LanternEvent;   import road7th.comm.PackageIn;      public class LanternRiddlesView extends Frame   {            private static var RANK_NUM:int = 8;                   private var _bg:Bitmap;            private var _questionView:QuestionView;            private var _doubleBtn:BaseButton;            private var _hitBtn:BaseButton;            private var _freeDouble:FilterFrameText;            private var _freeHit:FilterFrameText;            private var _careInfo:FilterFrameText;            private var _questionNum:FilterFrameText;            private var _myRank:FilterFrameText;            private var _myInteger:FilterFrameText;            private var _rankVec:Vector.<LanternRankItem>;            private var _offY:int = 40;            private var _doubleFreeCount:int;            private var _hitFreeCount:int;            private var _doublePrice:int;            private var _hitPrice:int;            private var _hitFlag:Boolean;            private var _alertAsk:LanternAlertView;            public function LanternRiddlesView() { super(); }
            private function initView() : void { }
            private function addRankView() : void { }
            private function initEvent() : void { }
            protected function __onSetBtnEnable(event:CrazyTankSocketEvent) : void { }
            protected function __onSetQuestionInfo(event:CrazyTankSocketEvent) : void { }
            protected function __onSetRankInfo(event:CrazyTankSocketEvent) : void { }
            protected function _onDoubleBtnClick(event:MouseEvent) : void { }
            protected function __onLanternAlertSelect(event:LanternEvent) : void { }
            protected function __onBuyHandle(event:FrameEvent) : void { }
            private function setBindFlag(flag:Boolean) : void { }
            private function payment(isBand:Boolean) : Boolean { return false; }
            protected function __onHitBtnClick(event:MouseEvent) : void { }
            private function sendPkg() : void { }
            public function show() : void { }
            private function removeEvent() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            private function onResponseHander(e:FrameEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function checkMoney(isBand:Boolean) : Boolean { return false; }
            override public function dispose() : void { }
   }}