package bank.view{   import bank.BankManager;   import bank.data.GameBankEvent;   import bank.view.mornui.bank.BankMainFrameUI;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;      public class BankMainFrameView extends BankMainFrameUI   {                   private var _saveOrGetView:BankSaveOrGetView;            public function BankMainFrameView() { super(); }
            private function addEvent() : void { }
            private function __saveMoney(e:MouseEvent) : void { }
            private function __GetMoney(e:MouseEvent) : void { }
            private function __closeView(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function get saveOrGetView() : BankSaveOrGetView { return null; }
            public function set saveOrGetView(value:BankSaveOrGetView) : void { }
            override public function dispose() : void { }
   }}