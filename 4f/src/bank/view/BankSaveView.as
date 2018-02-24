package bank.view
{
   import baglocked.BaglockedManager;
   import bank.BankManager;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankSaveUI;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import morn.core.components.Label;
   import road7th.data.DictionaryData;
   
   public class BankSaveView extends BankSaveUI
   {
       
      
      private var _index:int = 0;
      
      private var _data:DictionaryData;
      
      public function BankSaveView(){super();}
      
      private function addEvent() : void{}
      
      private function initView() : void{}
      
      private function selectedItem(param1:Event) : void{}
      
      private function calculation(param1:int) : void{}
      
      private function textChange(param1:Event) : void{}
      
      private function saveMoney(param1:MouseEvent) : void{}
      
      private function onChecked() : void{}
      
      protected function onResponse(param1:FrameEvent) : void{}
      
      private function saveViewBack(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
