package bank.view
{
   import bank.BankManager;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankLeftUI;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class BankLeftView extends BankLeftUI
   {
       
      
      private var _recordItemarr:Vector.<BankSaveRecordView>;
      
      private var _fourRecordItemArr:Vector.<BankSaveRecordView>;
      
      private var _index:int = 0;
      
      private var _currentPage:int = 1;
      
      private var _maxPage:int = 1;
      
      public function BankLeftView(){super();}
      
      private function addEvent() : void{}
      
      private function initView() : void{}
      
      private function pageLeft(param1:MouseEvent) : void{}
      
      private function pageRight(param1:MouseEvent) : void{}
      
      public function set currentPage(param1:int) : void{}
      
      public function get currentPage() : int{return 0;}
      
      public function leftViewChange() : void{}
      
      private function creatItem() : void{}
      
      private function getCurrentItemNum() : int{return 0;}
      
      private function indexChange(param1:GameBankEvent) : void{}
      
      private function lineChange() : void{}
      
      public function get index() : int{return 0;}
      
      public function set index(param1:int) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
