package bank.view
{
   import bank.BankManager;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import bank.view.mornui.bank.BankSaveRecordItemUI;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class BankSaveRecordView extends BankSaveRecordItemUI
   {
       
      
      private var lineBoolean:Boolean;
      
      private var _btnSprite:Sprite;
      
      private var _info:BankRecordInfo;
      
      private var _index:int;
      
      public function BankSaveRecordView(param1:int)
      {
         super();
         _index = param1;
         _btnSprite = new Sprite();
         _btnSprite.graphics.beginFill(16777215,0);
         _btnSprite.graphics.drawRect(22,115,267,78);
         _btnSprite.graphics.endFill();
         addChild(_btnSprite);
         _btnSprite.buttonMode = true;
         _btnSprite.x = 121;
         _btnSprite.y = 19;
         _btnSprite.addEventListener("click",changeView);
      }
      
      public function setInfo(param1:BankRecordInfo) : void
      {
         var _loc2_:DictionaryData = BankManager.instance.model.data;
         if(_loc2_[param1.tempId].DeadLine == 0)
         {
            saveTypeImg.skin = "asset.bank.checking";
            timeNum.text = LanguageMgr.GetTranslation("tank.bank.checkingAccount",Number(_loc2_[param1.tempId].InterestRate / 100));
            overTimeImg.skin = "";
         }
         else
         {
            saveTypeImg.skin = "asset.bank.regular";
            timeNum.text = LanguageMgr.GetTranslation("tank.bank.regular",_loc2_[param1.tempId].DeadLine,Number(_loc2_[param1.tempId].InterestRate / 100));
            if(BankManager.instance.isAchieve(param1))
            {
               overTimeImg.skin = "asset.bank.complete";
            }
            else
            {
               overTimeImg.skin = "asset.bank.notComplete";
            }
         }
         startTimeTxt.text = getTime(param1.begainTime);
         moneyNum.text = LanguageMgr.GetTranslation("tank.bank.moneyNum",param1.Amount);
         profitNum.text = LanguageMgr.GetTranslation("tank.bank.Interest",BankManager.instance.getProfitNum(param1,true));
      }
      
      private function getTime(param1:Date) : String
      {
         return param1.fullYear + "-" + (param1.month + 1) + "-" + param1.date;
      }
      
      private function changeView(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_left_view_line_show",{"index":_index}));
         BankManager.instance.dispatchEvent(new GameBankEvent("bank_left_item_click",{"isPageBtn":false}));
      }
      
      override public function dispose() : void
      {
         _btnSprite.removeEventListener("click",changeView);
         ObjectUtils.disposeObject(_btnSprite);
         _btnSprite = null;
         super.dispose();
      }
   }
}
