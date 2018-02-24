package bank.view
{
   import baglocked.BaglockedManager;
   import bank.BankManager;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankGetUI;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import road7th.data.DictionaryData;
   
   public class BankGetView extends BankGetUI
   {
       
      
      private var _currentPage:int;
      
      private var _index:int;
      
      private var _info:BankRecordInfo;
      
      private var _clickTime:Number = 0;
      
      public function BankGetView(){super();}
      
      private function addEvent() : void{}
      
      private function textChange(param1:Event) : void{}
      
      private function canGetMoney(param1:MouseEvent) : void{}
      
      protected function onResponse(param1:FrameEvent) : void{}
      
      private function getMoney(param1:int) : void{}
      
      public function setInfo(param1:int, param2:int) : void{}
      
      private function getViewBack(param1:MouseEvent) : void{}
      
      private function goSave(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
