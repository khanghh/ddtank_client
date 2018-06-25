package bank.view{   import baglocked.BaglockedManager;   import bank.BankManager;   import bank.data.GameBankEvent;   import bank.view.mornui.bank.BankSaveUI;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import flash.events.Event;   import flash.events.MouseEvent;   import morn.core.components.Label;   import road7th.data.DictionaryData;      public class BankSaveView extends BankSaveUI   {                   private var _index:int = 0;            private var _data:DictionaryData;            public function BankSaveView() { super(); }
            private function addEvent() : void { }
            private function initView() : void { }
            private function selectedItem(e:Event) : void { }
            private function calculation(value:int) : void { }
            private function textChange(e:Event) : void { }
            private function saveMoney(e:MouseEvent) : void { }
            private function onChecked() : void { }
            protected function onResponse(e:FrameEvent) : void { }
            private function saveViewBack(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}