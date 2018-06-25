package bank.view{   import baglocked.BaglockedManager;   import bank.BankManager;   import bank.data.BankRecordInfo;   import bank.data.GameBankEvent;   import bank.view.mornui.bank.BankGetUI;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import road7th.data.DictionaryData;      public class BankGetView extends BankGetUI   {                   private var _currentPage:int;            private var _index:int;            private var _info:BankRecordInfo;            private var _clickTime:Number = 0;            public function BankGetView() { super(); }
            private function addEvent() : void { }
            private function textChange(e:Event) : void { }
            private function canGetMoney(e:MouseEvent) : void { }
            protected function onResponse(e:FrameEvent) : void { }
            private function getMoney(bankId:int) : void { }
            public function setInfo(currentPage:int, index:int) : void { }
            private function getViewBack(e:MouseEvent) : void { }
            private function goSave(e:MouseEvent) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}