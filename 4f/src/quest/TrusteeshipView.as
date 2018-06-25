package quest{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.QuickUseFrame;   import ddt.command.StripTip;   import ddt.data.quest.QuestInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.CheckMoneyUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;   import kingBless.KingBlessManager;      public class TrusteeshipView extends Sprite implements Disposeable   {                   private var _spiritImage:Bitmap;            private var _spiritValueTxtBg:Image;            private var _speedUpBg:Bitmap;            private var _spiritValueTxt:FilterFrameText;            private var _speedUpTipTxt:FilterFrameText;            private var _speedUpTimeTxt:FilterFrameText;            private var _speedUpBtn:SimpleBitmapButton;            private var _startCancelBtn:TextButton;            private var _buyBtn:SimpleBitmapButton;            private var _buyBtnStrip:StripTip;            private var _timer:Timer;            private var _count:int;            private var _questInfo:QuestInfo;            private var _callback:Function;            private var _questBtn:BaseButton;            private var _confirmFrame:BaseAlerFrame;            public function TrusteeshipView() { super(); }
            private function initView() : void { }
            private function refreshBuyBtn(event:Event) : void { }
            public function refreshSpiritTxt() : void { }
            private function initEvent() : void { }
            private function startCancelHandler(event:MouseEvent) : void { }
            private function __confirmStartCancel(evt:FrameEvent) : void { }
            private function speedUpHandler(event:MouseEvent) : void { }
            private function __confirmSpeedUp(evt:FrameEvent) : void { }
            protected function onCheckComplete() : void { }
            private function buyHandler(event:MouseEvent) : void { }
            private function __confirmBuySpirit(evt:FrameEvent) : void { }
            protected function onCheckComplete2() : void { }
            public function refreshView(questInfo:QuestInfo, callback:Function, questBtn:BaseButton) : void { }
            public function clearSome() : void { }
            private function taskCompleteState() : void { }
            private function timerHandler(event:TimerEvent) : void { }
            private function getTimeStr(count:int) : String { return null; }
            private function getTimeStrOO(value:int) : String { return null; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}