package bagAndInfo.amulet{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SelectedButton;   import com.pickgliss.ui.controls.SelectedButtonGroup;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.BagEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.events.Event;      public class EquipAmuletMainFrame extends Frame   {                   private var _helpBtn:SimpleBitmapButton;            private var _upgradeBtn:SelectedButton;            private var _activateBtn:SelectedButton;            private var _btnGroup:SelectedButtonGroup;            private var _upgradeView:EquipAmuletUpgradeView;            private var _activateView:EquipAmuletActivateView;            public function EquipAmuletMainFrame() { super(); }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            private function __onChangeHandler(e:Event) : void { }
            private function __onUpdateBuyStiveNum(e:PkgEvent) : void { }
            private function __onUpdateBag(e:BagEvent) : void { }
            override protected function onResponse(type:int) : void { }
            private function __onCloseFrameTips(e:FrameEvent) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}