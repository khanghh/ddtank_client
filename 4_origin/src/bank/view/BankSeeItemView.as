package bank.view
{
   import bank.BankManager;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankSeeItemUI;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class BankSeeItemView extends BankSeeItemUI
   {
       
      
      public function BankSeeItemView()
      {
         super();
         principalTitle.text = LanguageMgr.GetTranslation("tank.bank.title.principal");
         interestTitle.text = LanguageMgr.GetTranslation("tank.bank.title.interest");
         note.text = LanguageMgr.GetTranslation("tank.bank.note");
         money.text = LanguageMgr.GetTranslation("money");
         money1.text = LanguageMgr.GetTranslation("money");
         ddtMoney.text = LanguageMgr.GetTranslation("ddtMoney");
         addEvent();
      }
      
      private function addEvent() : void
      {
         goSaveBtn.addEventListener("click",goSave);
      }
      
      public function setInfo(param1:int, param2:int) : void
      {
         var _loc4_:BankRecordInfo = BankManager.instance.model.list[(param1 - 1) * 3 + param2];
         moneyNum.text = String(_loc4_.Amount);
         var _loc3_:DictionaryData = BankManager.instance.model.data;
         if(_loc3_[_loc4_.tempId].DeadLine == 0)
         {
            saveType.text = LanguageMgr.GetTranslation("tank.bank.checkingAccountGet");
         }
         else
         {
            saveType.text = LanguageMgr.GetTranslation("tank.bank.dingqiAccount") + LanguageMgr.GetTranslation("tank.bank.monthNum",_loc3_[_loc4_.tempId].DeadLine);
         }
         InterestRate.text = LanguageMgr.GetTranslation("tank.bank.interestRate",Number(_loc3_[_loc4_.tempId].InterestRate / 100));
         myMoney.text = String(_loc4_.Amount);
         profitMoney.text = String(BankManager.instance.getProfitNum(_loc4_,true));
      }
      
      private function goSave(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_right_view_change",{"type":1}));
      }
      
      private function removeEvent() : void
      {
         goSaveBtn.removeEventListener("click",goSave);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}
