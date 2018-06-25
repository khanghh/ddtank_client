package horse.amulet{   import bagAndInfo.bag.BagView;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CellEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.events.Event;   import flash.events.MouseEvent;   import horse.HorseAmuletManager;   import uiUtils.SelectPageUI;      public class HorseAmuletBagView extends BagView   {                   private var _listBag:HorseAmuletBagListView;            private var _smashAllBtn:SimpleBitmapButton;            private var _equipBtn:SimpleBitmapButton;            private var _activateBtn:SimpleBitmapButton;            private var _smashBtn:HorseAmuletSmashButton;            private var _lockBtn:HorseAmuletLockButton;            private var _selectPage:SelectPageUI;            public function HorseAmuletBagView() { super(); }
            override public function setBagType(type:int) : void { }
            private function __onClickSmashAll(e:MouseEvent) : void { }
            private function __onConfirmResponse(event:FrameEvent) : void { }
            private function __onClickEquip(e:MouseEvent) : void { }
            private function __onClickActivate(e:MouseEvent) : void { }
            private function __onChangePage(e:Event) : void { }
            override protected function __sortBagClick(evt:MouseEvent) : void { }
            override protected function initMoneyTexts() : void { }
            override protected function initBackGround() : void { }
            override protected function initTabButtons() : void { }
            override protected function initButtons() : void { }
            override protected function set_breakBtn_enable() : void { }
            override protected function __bagArrangeOver(evt:MouseEvent) : void { }
            override protected function __bagArrangeOut(event:MouseEvent) : void { }
            override protected function initBagList() : void { }
            override protected function initEvent() : void { }
            override protected function removeEvents() : void { }
            override protected function __cellClick(evt:CellEvent) : void { }
            override public function dispose() : void { }
   }}