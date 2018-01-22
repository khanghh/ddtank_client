package bank.view
{
   import bank.BankManager;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankMainFrameUI;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class BankMainFrameView extends BankMainFrameUI
   {
       
      
      private var _saveOrGetView:BankSaveOrGetView;
      
      public function BankMainFrameView(){super();}
      
      private function addEvent() : void{}
      
      private function __saveMoney(param1:MouseEvent) : void{}
      
      private function __GetMoney(param1:MouseEvent) : void{}
      
      private function __closeView(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function get saveOrGetView() : BankSaveOrGetView{return null;}
      
      public function set saveOrGetView(param1:BankSaveOrGetView) : void{}
      
      override public function dispose() : void{}
   }
}
