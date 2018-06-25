package bank.view{   import bank.BankManager;   import bank.data.BankRecordInfo;   import bank.data.GameBankEvent;   import bank.view.mornui.bank.BankSaveOrGetUI;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import flash.events.MouseEvent;   import morn.core.components.View;      public class BankSaveOrGetView extends BankSaveOrGetUI   {                   private var _viewType:int = 0;            private var _viewArr:Array;            private var _recodArr:Vector.<BankRecordInfo>;            private var _rightView:View;            private var _leftView:BankLeftView;            private var _btnHelp:BaseButton;            public function BankSaveOrGetView() { super(); }
            private function initView() : void { }
            private function initData() : void { }
            private function __onChangeTypeView(e:GameBankEvent) : void { }
            private function __onViewBack(e:GameBankEvent) : void { }
            private function changeView() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __onGetSuccess(e:GameBankEvent) : void { }
            private function __onSaveSuccess(e:GameBankEvent) : void { }
            private function __onLeftItemClick(e:GameBankEvent) : void { }
            private function __closeView(e:MouseEvent) : void { }
            public function get viewType() : int { return 0; }
            public function set viewType(value:int) : void { }
            override public function dispose() : void { }
   }}