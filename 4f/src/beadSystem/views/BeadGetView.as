package beadSystem.views{   import baglocked.BaglockedManager;   import beadSystem.beadSystemManager;   import beadSystem.data.BeadEvent;   import beadSystem.model.BeadModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import kingBless.KingBlessManager;   import times.utils.timerManager.TimerJuggler;   import times.utils.timerManager.TimerManager;      public class BeadGetView extends Sprite implements Disposeable   {                   private var _bg:Bitmap;            private var _requestBtn1:SimpleBitmapButton;            private var _requestBtn2:SimpleBitmapButton;            private var _requestBtn3:SimpleBitmapButton;            private var _requestBtn4:SimpleBitmapButton;            private var _requestBtn1MC:MovieClip;            private var _requestBtn2MC:MovieClip;            private var _requestBtn3MC:MovieClip;            private var _requestBtn4MC:MovieClip;            private var _autoOpenBeadTimer:TimerJuggler;            private var _autoOpenBeadCheckBtn:SelectedCheckButton;            private var _isSelectAutoCheck:Boolean = false;            private var _isServerReplied:Boolean = false;            private var _isFirst:Boolean = true;            private var _alertConfirm:BaseAlerFrame;            private var _alertCharge:BaseAlerFrame;            private var _titleBmp:Bitmap;            private var _freeTipTxt:FilterFrameText;            private var _selectedBandBtn:SelectedCheckButton;            private var _selectedBtn:SelectedCheckButton;            private var _moneyTxt:FilterFrameText;            private var _bandMoneyTxt:FilterFrameText;            private var _isBand:Boolean;            private var vBtn:SimpleBitmapButton;            public function BeadGetView() { super(); }
            private function initView() : void { }
            private function selectedHander(e:MouseEvent) : void { }
            private function selectedBandHander(e:MouseEvent) : void { }
            private function createMovies() : void { }
            private function initBtnState() : void { }
            private function initEvent() : void { }
            private function refreshFreeTipTxt(event:Event) : void { }
            private function __onOpenBeadAlertCancelled(pEvent:Event) : void { }
            private function removeEvent() : void { }
            private function __onViewIndexChanged(pEvent:BeadEvent) : void { }
            private function __onAutoBtnClick(pEvent:MouseEvent) : void { }
            private function __autoCheck(pEvent:Event) : void { }
            private function __onAutoOpenResponse(pEvent:FrameEvent) : void { }
            private function __requestClick(pEvent:MouseEvent) : void { }
            protected function onCheckComplete() : void { }
            private function __poorManResponse(event:FrameEvent) : void { }
            public function buttonState(pIndex:int) : void { }
            private function addTimer() : void { }
            public function removeTimer() : void { }
            private function __onAutoOpen(pEvent:Event) : void { }
            private function autoOpenBead() : void { }
            private function getMaxRequestBtn() : int { return 0; }
            public function dispose() : void { }
   }}